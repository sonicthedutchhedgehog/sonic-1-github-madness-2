
; ===============================================================
; Mega PCM Driver Include File
; (c) 2012, Vladikcomper
; ===============================================================

; ---------------------------------------------------------------
; Variables used in DAC table
; ---------------------------------------------------------------

; flags
panLR	= $C0
panL	= $80
panR	= $40
pcm	= 0
dpcm	= 4
loop	= 2
pri	= 1

; ---------------------------------------------------------------
; Macros
; ---------------------------------------------------------------

z80word macro Value
	dc.w	((Value)&$FF)<<8|((Value)&$FF00)>>8
	endm

DAC_Entry macro Pitch,Offset,Flags
	dc.b	Flags			; 00h	- Flags
	dc.b	Pitch			; 01h	- Pitch
	dc.b	(Offset>>15)&$FF	; 02h	- Start Bank
	dc.b	(Offset_End>>15)&$FF	; 03h	- End Bank
	z80word	(Offset)|$8000		; 04h	- Start Offset (in Start bank)
	z80word	(Offset_End-1)|$8000	; 06h	- End Offset (in End bank)
	endm

IncludeDAC macro Name,Extension
Name:       label   *
    if ("Extension"="WAV")
        BINCLUDE    "DAC/Name.Extension",$3A
    else
        BINCLUDE    "DAC/Name.Extension"
    endif
Name_End:   label   *
    endm

; ---------------------------------------------------------------
; Driver's code
; ---------------------------------------------------------------

MegaPCM:
	binclude	"MegaPCM.z80"

; ---------------------------------------------------------------
; DAC Samples Table
; ---------------------------------------------------------------

	DAC_Entry	$01, fuckyou, pcm+pri			; $81	- Kick
	DAC_Entry	$01, fuckyou, pcm+pri		; $82	- Snare
	DAC_Entry	$01, fuckyou, pcm+pri	        ; $83   - Timpani
	dc.l    0,0             		        ; $84	- <Free>
	dc.l	0,0					; $85	- <Free>
	dc.l	0,0					; $86	- <Free>
	dc.l	0,0					; $87	- <Free>
	DAC_Entry	$01, fuckyou, pcm+pri		; $88	- Hi-Timpani
	DAC_Entry	$01, fuckyou, pcm+pri		; $89	- Mid-Timpani
	DAC_Entry	$01, fuckyou, pcm+pri		; $8A	- Mid-Low-Timpani
	DAC_Entry	$01, fuckyou, pcm+pri		; $8B	- Low-Timpani
        DAC_Entry       $01, fuckyou, pcm+pri           ; $8C - FUCK YOU

MegaPCM_End:

; ---------------------------------------------------------------
; DAC Samples Files
; ---------------------------------------------------------------

	IncludeDAC	Kick, bin
	IncludeDAC	Snare, bin
	IncludeDAC	Timpani, bin
        IncludeDAC	fuckyou, wav
	even

