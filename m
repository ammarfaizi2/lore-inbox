Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263107AbTDBSRL>; Wed, 2 Apr 2003 13:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263115AbTDBSRL>; Wed, 2 Apr 2003 13:17:11 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:10119 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S263107AbTDBSQ7>; Wed, 2 Apr 2003 13:16:59 -0500
Date: Wed, 2 Apr 2003 20:28:21 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initialisers for sound/oss/dmasound/*
Message-ID: <Pine.LNX.4.51.0304022027001.3676@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

more C99 initialisers.

Regards,
Maciej Soltysiak

diff -Nru linux-2.5.64.orig/sound/oss/dmasound/dmasound_atari.c linux-2.5.64/sound/oss/dmasound/dmasound_atari.c
--- linux-2.5.64.orig/sound/oss/dmasound/dmasound_atari.c	2003-03-05 04:29:04.000000000 +0100
+++ linux-2.5.64/sound/oss/dmasound/dmasound_atari.c	2003-04-02 20:23:32.000000000 +0200
@@ -767,39 +767,39 @@


 static TRANS transTTNormal = {
-	ct_ulaw:	ata_ct_law,
-	ct_alaw:	ata_ct_law,
-	ct_s8:		ata_ct_s8,
-	ct_u8:		ata_ct_u8,
+	.ct_ulaw	= ata_ct_law,
+	.ct_alaw	= ata_ct_law,
+	.ct_s8		= ata_ct_s8,
+	.ct_u8		= ata_ct_u8,
 };

 static TRANS transTTExpanding = {
-	ct_ulaw:	ata_ctx_law,
-	ct_alaw:	ata_ctx_law,
-	ct_s8:		ata_ctx_s8,
-	ct_u8:		ata_ctx_u8,
+	ct_ulaw		= ata_ctx_law,
+	ct_alaw		= ata_ctx_law,
+	ct_s8		= ata_ctx_s8,
+	ct_u8		= ata_ctx_u8,
 };

 static TRANS transFalconNormal = {
-	ct_ulaw:	ata_ct_law,
-	ct_alaw:	ata_ct_law,
-	ct_s8:		ata_ct_s8,
-	ct_u8:		ata_ct_u8,
-	ct_s16be:	ata_ct_s16be,
-	ct_u16be:	ata_ct_u16be,
-	ct_s16le:	ata_ct_s16le,
-	ct_u16le:	ata_ct_u16le
+	.ct_ulaw	= ata_ct_law,
+	.ct_alaw	= ata_ct_law,
+	.ct_s8		= ata_ct_s8,
+	.ct_u8		= ata_ct_u8,
+	.ct_s16be	= ata_ct_s16be,
+	.ct_u16be	= ata_ct_u16be,
+	.ct_s16le	= ata_ct_s16le,
+	.ct_u16le	= ata_ct_u16le
 };

 static TRANS transFalconExpanding = {
-	ct_ulaw:	ata_ctx_law,
-	ct_alaw:	ata_ctx_law,
-	ct_s8:		ata_ctx_s8,
-	ct_u8:		ata_ctx_u8,
-	ct_s16be:	ata_ctx_s16be,
-	ct_u16be:	ata_ctx_u16be,
-	ct_s16le:	ata_ctx_s16le,
-	ct_u16le:	ata_ctx_u16le,
+	.ct_ulaw	= ata_ctx_law,
+	.ct_alaw	= ata_ctx_law,
+	.ct_s8		= ata_ctx_s8,
+	.ct_u8		= ata_ctx_u8,
+	.ct_s16be	= ata_ctx_s16be,
+	.ct_u16be	= ata_ctx_u16be,
+	.ct_s16le	= ata_ctx_s16le,
+	.ct_u16le	= ata_ctx_u16le,
 };


@@ -1495,81 +1495,81 @@
 /*** Machine definitions *****************************************************/

 static SETTINGS def_hard_falcon = {
-	format: AFMT_S8,
-	stereo: 0,
-	size: 8,
-	speed: 8195
+	.format		= AFMT_S8,
+	.stereo		= 0,
+	.size		= 8,
+	.speed		= 8195
 } ;

 static SETTINGS def_hard_tt = {
-	format: AFMT_S8,
-	stereo: 0,
-	size: 8,
-	speed: 12517
+	.format	= AFMT_S8,
+	.stereo	= 0,
+	.size	= 8,
+	.speed	= 12517
 } ;

 static SETTINGS def_soft = {
-	format: AFMT_U8,
-	stereo: 0,
-	size: 8,
-	speed: 8000
+	.format	= AFMT_U8,
+	.stereo	= 0,
+	.size	= 8,
+	.speed	= 8000
 } ;

 static MACHINE machTT = {
-	name:		"Atari",
-	name2:		"TT",
-	open:		AtaOpen,
-	release:	AtaRelease,
-	dma_alloc:	AtaAlloc,
-	dma_free:	AtaFree,
-	irqinit:	AtaIrqInit,
+	.name		= "Atari",
+	.name2		= "TT",
+	.open		= AtaOpen,
+	.release	= AtaRelease,
+	.dma_alloc	= AtaAlloc,
+	.dma_free	= AtaFree,
+	.irqinit	= AtaIrqInit,
 #ifdef MODULE
-	irqcleanup:	AtaIrqCleanUp,
+	.irqcleanup	= AtaIrqCleanUp,
 #endif /* MODULE */
-	init:		TTInit,
-	silence:	TTSilence,
-	setFormat:	TTSetFormat,
-	setVolume:	TTSetVolume,
-	setBass:	AtaSetBass,
-	setTreble:	AtaSetTreble,
-	setGain:	TTSetGain,
-	play:		AtaPlay,
-	mixer_init:	TTMixerInit,
-	mixer_ioctl:	TTMixerIoctl,
-	write_sq_setup:	AtaWriteSqSetup,
-	sq_open:	AtaSqOpen,
-	state_info:	TTStateInfo,
-	min_dsp_speed:	6258,
-	version:	((DMASOUND_ATARI_REVISION<<8) | DMASOUND_ATARI_EDITION),
-	hardware_afmts:	AFMT_S8,  /* h'ware-supported formats *only* here */
-	capabilities:	 DSP_CAP_BATCH	/* As per SNDCTL_DSP_GETCAPS */
+	.init		= TTInit,
+	.silence	= TTSilence,
+	.setFormat	= TTSetFormat,
+	.setVolume	= TTSetVolume,
+	.setBass	= AtaSetBass,
+	.setTreble	= AtaSetTreble,
+	.setGain	= TTSetGain,
+	.play		= AtaPlay,
+	.mixer_init	= TTMixerInit,
+	.mixer_ioctl	= TTMixerIoctl,
+	.write_sq_setup	= AtaWriteSqSetup,
+	.sq_open	= AtaSqOpen,
+	.state_info	= TTStateInfo,
+	min_dsp_speed	= 6258,
+	.version	= ((DMASOUND_ATARI_REVISION<<8) | DMASOUND_ATARI_EDITION),
+	.hardware_afmts	= AFMT_S8,  /* h'ware-supported formats *only* here */
+	.capabilities	=  DSP_CAP_BATCH	/* As per SNDCTL_DSP_GETCAPS */
 };

 static MACHINE machFalcon = {
-	name:		"Atari",
-	name2:		"FALCON",
-	dma_alloc:	AtaAlloc,
-	dma_free:	AtaFree,
-	irqinit:	AtaIrqInit,
+	.name		= "Atari",
+	.name2		= "FALCON",
+	.dma_alloc	= AtaAlloc,
+	.dma_free	= AtaFree,
+	.irqinit	= AtaIrqInit,
 #ifdef MODULE
-	irqcleanup:	AtaIrqCleanUp,
+	.irqcleanup	= AtaIrqCleanUp,
 #endif /* MODULE */
-	init:		FalconInit,
-	silence:	FalconSilence,
-	setFormat:	FalconSetFormat,
-	setVolume:	FalconSetVolume,
-	setBass:	AtaSetBass,
-	setTreble:	AtaSetTreble,
-	play:		AtaPlay,
-	mixer_init:	FalconMixerInit,
-	mixer_ioctl:	FalconMixerIoctl,
-	write_sq_setup:	AtaWriteSqSetup,
-	sq_open:	AtaSqOpen,
-	state_info:	FalconStateInfo,
-	min_dsp_speed:	8195,
-	version:	((DMASOUND_ATARI_REVISION<<8) | DMASOUND_ATARI_EDITION),
-	hardware_afmts:	(AFMT_S8 | AFMT_S16_BE), /* h'ware-supported formats *only* here */
-	capabilities:	 DSP_CAP_BATCH	/* As per SNDCTL_DSP_GETCAPS */
+	.init		= FalconInit,
+	.silence	= FalconSilence,
+	.setFormat	= FalconSetFormat,
+	.setVolume	= FalconSetVolume,
+	.setBass	= AtaSetBass,
+	.setTreble	= AtaSetTreble,
+	.play		= AtaPlay,
+	.mixer_init	= FalconMixerInit,
+	.mixer_ioctl	= FalconMixerIoctl,
+	.write_sq_setup	= AtaWriteSqSetup,
+	.sq_open	= AtaSqOpen,
+	.state_info	= FalconStateInfo,
+	.min_dsp_speed	= 8195,
+	.version	= ((DMASOUND_ATARI_REVISION<<8) | DMASOUND_ATARI_EDITION),
+	.hardware_afmts	= (AFMT_S8 | AFMT_S16_BE), /* h'ware-supported formats *only* here */
+	.capabilities	=  DSP_CAP_BATCH	/* As per SNDCTL_DSP_GETCAPS */
 };


diff -Nru linux-2.5.64.orig/sound/oss/dmasound/dmasound_awacs.c linux-2.5.64/sound/oss/dmasound/dmasound_awacs.c
--- linux-2.5.64.orig/sound/oss/dmasound/dmasound_awacs.c	2003-03-05 04:29:15.000000000 +0100
+++ linux-2.5.64/sound/oss/dmasound/dmasound_awacs.c	2003-04-02 20:15:00.000000000 +0200
@@ -2405,45 +2405,45 @@
 /*** Machine definitions *****************************************************/

 static SETTINGS def_hard = {
-	format: AFMT_S16_BE,
-	stereo: 1,
-	size: 16,
-	speed: 44100
+	.format	= AFMT_S16_BE,
+	.stereo	= 1,
+	.size	= 16,
+	.speed	= 44100
 } ;

 static SETTINGS def_soft = {
-	format: AFMT_S16_BE,
-	stereo: 1,
-	size: 16,
-	speed: 44100
+	.format	= AFMT_S16_BE,
+	.stereo	= 1,
+	.size	= 16,
+	.speed	= 44100
 } ;

 static MACHINE machPMac = {
-	name:		awacs_name,
-	name2:		"PowerMac Built-in Sound",
-	open:		PMacOpen,
-	release:	PMacRelease,
-	dma_alloc:	PMacAlloc,
-	dma_free:	PMacFree,
-	irqinit:	PMacIrqInit,
+	.name		= awacs_name,
+	.name2		= "PowerMac Built-in Sound",
+	.open		= PMacOpen,
+	.release	= PMacRelease,
+	.dma_alloc	= PMacAlloc,
+	.dma_free	= PMacFree,
+	.irqinit	= PMacIrqInit,
 #ifdef MODULE
-	irqcleanup:	PMacIrqCleanup,
+	.irqcleanup	= PMacIrqCleanup,
 #endif /* MODULE */
-	init:		PMacInit,
-	silence:	PMacSilence,
-	setFormat:	PMacSetFormat,
-	setVolume:	PMacSetVolume,
-	play:		PMacPlay,
-	record:		NULL,		/* default to no record */
-	mixer_init:	PMacMixerInit,
-	mixer_ioctl:	PMacMixerIoctl,
-	write_sq_setup:	PMacWriteSqSetup,
-	read_sq_setup:	PMacReadSqSetup,
-	state_info:	PMacStateInfo,
-	abort_read:	PMacAbortRead,
-	min_dsp_speed:	7350,
-	max_dsp_speed:	44100,
-	version:	((DMASOUND_AWACS_REVISION<<8) + DMASOUND_AWACS_EDITION)
+	.init		= PMacInit,
+	.silence	= PMacSilence,
+	.setFormat	= PMacSetFormat,
+	.setVolume	= PMacSetVolume,
+	.play		= PMacPlay,
+	.record		= NULL,		/* default to no record */
+	.mixer_init	= PMacMixerInit,
+	.mixer_ioctl	= PMacMixerIoctl,
+	.write_sq_setup	= PMacWriteSqSetup,
+	.read_sq_setup	= PMacReadSqSetup,
+	.state_info	= PMacStateInfo,
+	.abort_read	= PMacAbortRead,
+	.min_dsp_speed	= 7350,
+	.max_dsp_speed	= 44100,
+	.version	= ((DMASOUND_AWACS_REVISION<<8) + DMASOUND_AWACS_EDITION)
 };


diff -Nru linux-2.5.64.orig/sound/oss/dmasound/dmasound_core.c linux-2.5.64/sound/oss/dmasound/dmasound_core.c
--- linux-2.5.64.orig/sound/oss/dmasound/dmasound_core.c	2003-03-05 04:29:00.000000000 +0100
+++ linux-2.5.64/sound/oss/dmasound/dmasound_core.c	2003-04-02 20:16:09.000000000 +0200
@@ -367,11 +367,11 @@

 static struct file_operations mixer_fops =
 {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		mixer_ioctl,
-	open:		mixer_open,
-	release:	mixer_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= mixer_ioctl,
+	.open		= mixer_open,
+	.release	= mixer_release,
 };

 static void __init mixer_init(void)
@@ -1325,15 +1325,15 @@

 static struct file_operations sq_fops =
 {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	write:		sq_write,
-	poll:		sq_poll,
-	ioctl:		sq_ioctl,
-	open:		sq_open,
-	release:	sq_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= sq_write,
+	.poll		= sq_poll,
+	.ioctl		= sq_ioctl,
+	.open		= sq_open,
+	.release	= sq_release,
 #ifdef HAS_RECORD
-	read:		NULL	/* default to no read for compat mode */
+	.read		= NULL	/* default to no read for compat mode */
 #endif
 };

@@ -1548,11 +1548,11 @@
 }

 static struct file_operations state_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		state_read,
-	open:		state_open,
-	release:	state_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= state_read,
+	.open		= state_open,
+	.release	= state_release,
 };

 static int __init state_init(void)
diff -Nru linux-2.5.64.orig/sound/oss/dmasound/dmasound_paula.c linux-2.5.64/sound/oss/dmasound/dmasound_paula.c
--- linux-2.5.64.orig/sound/oss/dmasound/dmasound_paula.c	2003-03-05 04:28:53.000000000 +0100
+++ linux-2.5.64/sound/oss/dmasound/dmasound_paula.c	2003-04-02 20:17:41.000000000 +0200
@@ -298,14 +298,14 @@


 static TRANS transAmiga = {
-	ct_ulaw:	ami_ct_ulaw,
-	ct_alaw:	ami_ct_alaw,
-	ct_s8:		ami_ct_s8,
-	ct_u8:		ami_ct_u8,
-	ct_s16be:	ami_ct_s16be,
-	ct_u16be:	ami_ct_u16be,
-	ct_s16le:	ami_ct_s16le,
-	ct_u16le:	ami_ct_u16le,
+	.ct_ulaw	= ami_ct_ulaw,
+	.ct_alaw	= ami_ct_alaw,
+	.ct_s8		= ami_ct_s8,
+	.ct_u8		= ami_ct_u8,
+	.ct_s16be	= ami_ct_s16be,
+	.ct_u16be	= ami_ct_u16be,
+	.ct_s16le	= ami_ct_s16le,
+	.ct_u16le	= ami_ct_u16le,
 };

 /*** Low level stuff *********************************************************/
@@ -681,44 +681,44 @@
 /*** Machine definitions *****************************************************/

 static SETTINGS def_hard = {
-	format: AFMT_S8,
-	stereo: 0,
-	size: 8,
-	speed: 8000
+	.format	= AFMT_S8,
+	.stereo	= 0,
+	.size	= 8,
+	.speed	= 8000
 } ;

 static SETTINGS def_soft = {
-	format: AFMT_U8,
-	stereo: 0,
-	size: 8,
-	speed: 8000
+	.format	= AFMT_U8,
+	.stereo	= 0,
+	.size	= 8,
+	.speed	= 8000
 } ;

 static MACHINE machAmiga = {
-	name:		"Amiga",
-	name2:		"AMIGA",
-	open:		AmiOpen,
-	release:	AmiRelease,
-	dma_alloc:	AmiAlloc,
-	dma_free:	AmiFree,
-	irqinit:	AmiIrqInit,
+	.name		= "Amiga",
+	.name2		= "AMIGA",
+	.open		= AmiOpen,
+	.release	= AmiRelease,
+	.dma_alloc	= AmiAlloc,
+	.dma_free	= AmiFree,
+	.irqinit	= AmiIrqInit,
 #ifdef MODULE
-	irqcleanup:	AmiIrqCleanUp,
+	.irqcleanup	= AmiIrqCleanUp,
 #endif /* MODULE */
-	init:		AmiInit,
-	silence:	AmiSilence,
-	setFormat:	AmiSetFormat,
-	setVolume:	AmiSetVolume,
-	setTreble:	AmiSetTreble,
-	play:		AmiPlay,
-	mixer_init:	AmiMixerInit,
-	mixer_ioctl:	AmiMixerIoctl,
-	write_sq_setup:	AmiWriteSqSetup,
-	state_info:	AmiStateInfo,
-	min_dsp_speed:	8000,
-	version:	((DMASOUND_PAULA_REVISION<<8) | DMASOUND_PAULA_EDITION),
-	hardware_afmts:	(AFMT_S8 | AFMT_S16_BE), /* h'ware-supported formats *only* here */
-        capabilities:   DSP_CAP_BATCH          /* As per SNDCTL_DSP_GETCAPS */
+	.init		= AmiInit,
+	.silence	= AmiSilence,
+	.setFormat	= AmiSetFormat,
+	.setVolume	= AmiSetVolume,
+	.setTreble	= AmiSetTreble,
+	.play		= AmiPlay,
+	.mixer_init	= AmiMixerInit,
+	.mixer_ioctl	= AmiMixerIoctl,
+	.write_sq_setup	= AmiWriteSqSetup,
+	.state_info	= AmiStateInfo,
+	.min_dsp_speed	= 8000,
+	.version	= ((DMASOUND_PAULA_REVISION<<8) | DMASOUND_PAULA_EDITION),
+	.hardware_afmts	= (AFMT_S8 | AFMT_S16_BE), /* h'ware-supported formats *only* here */
+        .capabilities	= DSP_CAP_BATCH          /* As per SNDCTL_DSP_GETCAPS */
 };


diff -Nru linux-2.5.64.orig/sound/oss/dmasound/dmasound_q40.c linux-2.5.64/sound/oss/dmasound/dmasound_q40.c
--- linux-2.5.64.orig/sound/oss/dmasound/dmasound_q40.c	2003-03-05 04:28:53.000000000 +0100
+++ linux-2.5.64/sound/oss/dmasound/dmasound_q40.c	2003-04-02 20:23:40.000000000 +0200
@@ -584,39 +584,39 @@
 /*** Machine definitions *****************************************************/

 static SETTINGS def_hard = {
-	format: AFMT_U8,
-	stereo: 0,
-	size: 8,
-	speed: 10000
+	.format	= AFMT_U8,
+	.stereo	= 0,
+	.size	= 8,
+	.speed	= 10000
 } ;

 static SETTINGS def_soft = {
-	format: AFMT_U8,
-	stereo: 0,
-	size: 8,
-	speed: 8000
+	.format	= AFMT_U8,
+	.stereo	= 0,
+	.size	= 8,
+	.speed	= 8000
 } ;

 static MACHINE machQ40 = {
-	name:		"Q40",
-	name2:		"Q40",
-	open:		Q40Open,
-	release:	Q40Release,
-	dma_alloc:	Q40Alloc,
-	dma_free:	Q40Free,
-	irqinit:	Q40IrqInit,
+	.name		= "Q40",
+	.name2		= "Q40",
+	.open		= Q40Open,
+	.release	= Q40Release,
+	.dma_alloc	= Q40Alloc,
+	.dma_free	= Q40Free,
+	.irqinit	= Q40IrqInit,
 #ifdef MODULE
-	irqcleanup:	Q40IrqCleanUp,
+	.irqcleanup	= Q40IrqCleanUp,
 #endif /* MODULE */
-	init:		Q40Init,
-	silence:	Q40Silence,
-	setFormat:	Q40SetFormat,
-	setVolume:	Q40SetVolume,
-	play:		Q40Play,
- 	min_dsp_speed:	10000,
-	version:	((DMASOUND_Q40_REVISION<<8) | DMASOUND_Q40_EDITION),
-	hardware_afmts:	AFMT_U8, /* h'ware-supported formats *only* here */
-        capabilities:	DSP_CAP_BATCH  /* As per SNDCTL_DSP_GETCAPS */
+	.init		= Q40Init,
+	.silence	= Q40Silence,
+	.setFormat	= Q40SetFormat,
+	.setVolume	= Q40SetVolume,
+	.play		= Q40Play,
+ 	.min_dsp_speed	= 10000,
+	.version	= ((DMASOUND_Q40_REVISION<<8) | DMASOUND_Q40_EDITION),
+	.hardware_afmts	= AFMT_U8, /* h'ware-supported formats *only* here */
+        .capabilities	= DSP_CAP_BATCH  /* As per SNDCTL_DSP_GETCAPS */
 };


