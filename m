Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTDGXdt (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTDGXdX (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:33:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19585
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263748AbTDGXVm (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:21:42 -0400
Date: Tue, 8 Apr 2003 01:40:33 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080040.h380eXEJ009312@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: lots more version and C99 for audio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/cs4281/cs4281m.c linux-2.5.67-ac1/sound/oss/cs4281/cs4281m.c
--- linux-2.5.67/sound/oss/cs4281/cs4281m.c	2003-02-10 18:39:00.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/cs4281/cs4281m.c	2003-04-03 23:52:57.000000000 +0100
@@ -58,7 +58,6 @@
 //#define NOT_CS4281_PM 1 
 
 #include <linux/list.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/cs46xx.c linux-2.5.67-ac1/sound/oss/cs46xx.c
--- linux-2.5.67/sound/oss/cs46xx.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/cs46xx.c	2003-04-03 23:52:57.000000000 +0100
@@ -77,7 +77,6 @@
  
 #include <linux/interrupt.h>
 #include <linux/list.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/dmasound/dmasound_atari.c linux-2.5.67-ac1/sound/oss/dmasound/dmasound_atari.c
--- linux-2.5.67/sound/oss/dmasound/dmasound_atari.c	2003-02-10 18:38:15.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/dmasound/dmasound_atari.c	2003-04-03 23:34:57.000000000 +0100
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
+	.ct_ulaw	= ata_ctx_law,
+	.ct_alaw	= ata_ctx_law,
+	.ct_s8		= ata_ctx_s8,
+	.ct_u8		= ata_ctx_u8,
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
+	.min_dsp_speed	= 6258,
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
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/dmasound/dmasound_awacs.c linux-2.5.67-ac1/sound/oss/dmasound/dmasound_awacs.c
--- linux-2.5.67/sound/oss/dmasound/dmasound_awacs.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/dmasound/dmasound_awacs.c	2003-04-03 23:34:57.000000000 +0100
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
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/dmasound/dmasound_core.c linux-2.5.67-ac1/sound/oss/dmasound/dmasound_core.c
--- linux-2.5.67/sound/oss/dmasound/dmasound_core.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/dmasound/dmasound_core.c	2003-04-03 23:34:57.000000000 +0100
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/dmasound/dmasound_paula.c linux-2.5.67-ac1/sound/oss/dmasound/dmasound_paula.c
--- linux-2.5.67/sound/oss/dmasound/dmasound_paula.c	2003-02-10 18:37:55.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/dmasound/dmasound_paula.c	2003-04-03 23:34:57.000000000 +0100
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
+	.capabilities	= DSP_CAP_BATCH          /* As per SNDCTL_DSP_GETCAPS */
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/dmasound/dmasound_q40.c linux-2.5.67-ac1/sound/oss/dmasound/dmasound_q40.c
--- linux-2.5.67/sound/oss/dmasound/dmasound_q40.c	2003-02-10 18:37:55.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/dmasound/dmasound_q40.c	2003-04-03 23:34:57.000000000 +0100
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
+	.capabilities	= DSP_CAP_BATCH  /* As per SNDCTL_DSP_GETCAPS */
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/emu10k1/audio.c linux-2.5.67-ac1/sound/oss/emu10k1/audio.c
--- linux-2.5.67/sound/oss/emu10k1/audio.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/emu10k1/audio.c	2003-04-03 23:52:57.000000000 +0100
@@ -33,7 +33,6 @@
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
 #include <linux/sched.h>
@@ -1020,7 +1019,7 @@
 }
 
 struct vm_operations_struct emu10k1_mm_ops = {
-	nopage:         emu10k1_mm_nopage,
+	.nopage         = emu10k1_mm_nopage,
 };
 
 static int emu10k1_audio_mmap(struct file *file, struct vm_area_struct *vma)
@@ -1558,13 +1557,13 @@
 }
 
 struct file_operations emu10k1_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		emu10k1_audio_read,
-	write:		emu10k1_audio_write,
-	poll:		emu10k1_audio_poll,
-	ioctl:		emu10k1_audio_ioctl,
-	mmap:		emu10k1_audio_mmap,
-	open:		emu10k1_audio_open,
-	release:	emu10k1_audio_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= emu10k1_audio_read,
+	.write		= emu10k1_audio_write,
+	.poll		= emu10k1_audio_poll,
+	.ioctl		= emu10k1_audio_ioctl,
+	.mmap		= emu10k1_audio_mmap,
+	.open		= emu10k1_audio_open,
+	.release	= emu10k1_audio_release,
 };
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/emu10k1/main.c linux-2.5.67-ac1/sound/oss/emu10k1/main.c
--- linux-2.5.67/sound/oss/emu10k1/main.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/emu10k1/main.c	2003-04-03 23:52:57.000000000 +0100
@@ -86,7 +86,6 @@
  *********************************************************************/
 
 /* These are only included once per module */
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -1144,10 +1143,10 @@
 MODULE_LICENSE("GPL");
 
 static struct pci_driver emu10k1_pci_driver = {
-	name:		"emu10k1",
-	id_table:	emu10k1_pci_tbl,
-	probe:		emu10k1_probe,
-	remove:		__devexit_p(emu10k1_remove),
+	.name		= "emu10k1",
+	.id_table	= emu10k1_pci_tbl,
+	.probe		= emu10k1_probe,
+	.remove		= __devexit_p(emu10k1_remove),
 };
 
 static int __init emu10k1_init_module(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/emu10k1/midi.c linux-2.5.67-ac1/sound/oss/emu10k1/midi.c
--- linux-2.5.67/sound/oss/emu10k1/midi.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/emu10k1/midi.c	2003-04-03 23:52:57.000000000 +0100
@@ -32,7 +32,6 @@
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
@@ -465,12 +464,12 @@
 
 /* MIDI file operations */
 struct file_operations emu10k1_midi_fops = {
-	owner:		THIS_MODULE,
-	read:		emu10k1_midi_read,
-	write:		emu10k1_midi_write,
-	poll:		emu10k1_midi_poll,
-	open:		emu10k1_midi_open,
-	release:	emu10k1_midi_release,
+	.owner		= THIS_MODULE,
+	.read		= emu10k1_midi_read,
+	.write		= emu10k1_midi_write,
+	.poll		= emu10k1_midi_poll,
+	.open		= emu10k1_midi_open,
+	.release	= emu10k1_midi_release,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/emu10k1/mixer.c linux-2.5.67-ac1/sound/oss/emu10k1/mixer.c
--- linux-2.5.67/sound/oss/emu10k1/mixer.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/emu10k1/mixer.c	2003-04-03 23:52:57.000000000 +0100
@@ -31,7 +31,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <asm/uaccess.h>
 #include <linux/fs.h>
 
@@ -675,9 +674,9 @@
 }
 
 struct file_operations emu10k1_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		emu10k1_mixer_ioctl,
-	open:		emu10k1_mixer_open,
-	release:	emu10k1_mixer_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= emu10k1_mixer_ioctl,
+	.open		= emu10k1_mixer_open,
+	.release	= emu10k1_mixer_release,
 };
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/emu10k1/passthrough.c linux-2.5.67-ac1/sound/oss/emu10k1/passthrough.c
--- linux-2.5.67/sound/oss/emu10k1/passthrough.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/emu10k1/passthrough.c	2003-04-03 23:52:57.000000000 +0100
@@ -32,7 +32,6 @@
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
 #include <linux/sched.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/es1370.c linux-2.5.67-ac1/sound/oss/es1370.c
--- linux-2.5.67/sound/oss/es1370.c	2003-02-15 03:39:36.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/es1370.c	2003-04-03 23:52:57.000000000 +0100
@@ -140,7 +140,6 @@
 
 /*****************************************************************************/
       
-#include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/string.h>
@@ -1054,11 +1053,11 @@
 }
 
 static /*const*/ struct file_operations es1370_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		es1370_ioctl_mixdev,
-	open:		es1370_open_mixdev,
-	release:	es1370_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= es1370_ioctl_mixdev,
+	.open		= es1370_open_mixdev,
+	.release	= es1370_release_mixdev,
 };
 
 /* --------------------------------------------------------------------- */
@@ -1816,15 +1815,15 @@
 }
 
 static /*const*/ struct file_operations es1370_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		es1370_read,
-	write:		es1370_write,
-	poll:		es1370_poll,
-	ioctl:		es1370_ioctl,
-	mmap:		es1370_mmap,
-	open:		es1370_open,
-	release:	es1370_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= es1370_read,
+	.write		= es1370_write,
+	.poll		= es1370_poll,
+	.ioctl		= es1370_ioctl,
+	.mmap		= es1370_mmap,
+	.open		= es1370_open,
+	.release	= es1370_release,
 };
 
 /* --------------------------------------------------------------------- */
@@ -2240,14 +2239,14 @@
 }
 
 static /*const*/ struct file_operations es1370_dac_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	write:		es1370_write_dac,
-	poll:		es1370_poll_dac,
-	ioctl:		es1370_ioctl_dac,
-	mmap:		es1370_mmap_dac,
-	open:		es1370_open_dac,
-	release:	es1370_release_dac,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= es1370_write_dac,
+	.poll		= es1370_poll_dac,
+	.ioctl		= es1370_ioctl_dac,
+	.mmap		= es1370_mmap_dac,
+	.open		= es1370_open_dac,
+	.release	= es1370_release_dac,
 };
 
 /* --------------------------------------------------------------------- */
@@ -2513,13 +2512,13 @@
 }
 
 static /*const*/ struct file_operations es1370_midi_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		es1370_midi_read,
-	write:		es1370_midi_write,
-	poll:		es1370_midi_poll,
-	open:		es1370_midi_open,
-	release:	es1370_midi_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= es1370_midi_read,
+	.write		= es1370_midi_write,
+	.poll		= es1370_midi_poll,
+	.open		= es1370_midi_open,
+	.release	= es1370_midi_release,
 };
 
 /* --------------------------------------------------------------------- */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/es1371.c linux-2.5.67-ac1/sound/oss/es1371.c
--- linux-2.5.67/sound/oss/es1371.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/es1371.c	2003-04-03 23:52:57.000000000 +0100
@@ -109,7 +109,6 @@
 
 /*****************************************************************************/
       
-#include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/string.h>
@@ -1243,11 +1242,11 @@
 }
 
 static /*const*/ struct file_operations es1371_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		es1371_ioctl_mixdev,
-	open:		es1371_open_mixdev,
-	release:	es1371_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= es1371_ioctl_mixdev,
+	.open		= es1371_open_mixdev,
+	.release	= es1371_release_mixdev,
 };
 
 /* --------------------------------------------------------------------- */
@@ -2004,15 +2003,15 @@
 }
 
 static /*const*/ struct file_operations es1371_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		es1371_read,
-	write:		es1371_write,
-	poll:		es1371_poll,
-	ioctl:		es1371_ioctl,
-	mmap:		es1371_mmap,
-	open:		es1371_open,
-	release:	es1371_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= es1371_read,
+	.write		= es1371_write,
+	.poll		= es1371_poll,
+	.ioctl		= es1371_ioctl,
+	.mmap		= es1371_mmap,
+	.open		= es1371_open,
+	.release	= es1371_release,
 };
 
 /* --------------------------------------------------------------------- */
@@ -2418,14 +2417,14 @@
 }
 
 static /*const*/ struct file_operations es1371_dac_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	write:		es1371_write_dac,
-	poll:		es1371_poll_dac,
-	ioctl:		es1371_ioctl_dac,
-	mmap:		es1371_mmap_dac,
-	open:		es1371_open_dac,
-	release:	es1371_release_dac,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= es1371_write_dac,
+	.poll		= es1371_poll_dac,
+	.ioctl		= es1371_ioctl_dac,
+	.mmap		= es1371_mmap_dac,
+	.open		= es1371_open_dac,
+	.release	= es1371_release_dac,
 };
 
 /* --------------------------------------------------------------------- */
@@ -2690,13 +2689,13 @@
 }
 
 static /*const*/ struct file_operations es1371_midi_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		es1371_midi_read,
-	write:		es1371_midi_write,
-	poll:		es1371_midi_poll,
-	open:		es1371_midi_open,
-	release:	es1371_midi_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= es1371_midi_read,
+	.write		= es1371_midi_write,
+	.poll		= es1371_midi_poll,
+	.open		= es1371_midi_open,
+	.release	= es1371_midi_release,
 };
 
 /* --------------------------------------------------------------------- */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/esssolo1.c linux-2.5.67-ac1/sound/oss/esssolo1.c
--- linux-2.5.67/sound/oss/esssolo1.c	2003-02-10 18:37:59.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/esssolo1.c	2003-04-03 23:52:57.000000000 +0100
@@ -87,7 +87,6 @@
 
 /*****************************************************************************/
       
-#include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/string.h>
@@ -951,11 +950,11 @@
 }
 
 static /*const*/ struct file_operations solo1_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		solo1_ioctl_mixdev,
-	open:		solo1_open_mixdev,
-	release:	solo1_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= solo1_ioctl_mixdev,
+	.open		= solo1_open_mixdev,
+	.release	= solo1_release_mixdev,
 };
 
 /* --------------------------------------------------------------------- */
@@ -1650,15 +1649,15 @@
 }
 
 static /*const*/ struct file_operations solo1_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		solo1_read,
-	write:		solo1_write,
-	poll:		solo1_poll,
-	ioctl:		solo1_ioctl,
-	mmap:		solo1_mmap,
-	open:		solo1_open,
-	release:	solo1_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= solo1_read,
+	.write		= solo1_write,
+	.poll		= solo1_poll,
+	.ioctl		= solo1_ioctl,
+	.mmap		= solo1_mmap,
+	.open		= solo1_open,
+	.release	= solo1_release,
 };
 
 /* --------------------------------------------------------------------- */
@@ -2001,13 +2000,13 @@
 }
 
 static /*const*/ struct file_operations solo1_midi_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		solo1_midi_read,
-	write:		solo1_midi_write,
-	poll:		solo1_midi_poll,
-	open:		solo1_midi_open,
-	release:	solo1_midi_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= solo1_midi_read,
+	.write		= solo1_midi_write,
+	.poll		= solo1_midi_poll,
+	.open		= solo1_midi_open,
+	.release	= solo1_midi_release,
 };
 
 /* --------------------------------------------------------------------- */
@@ -2189,11 +2188,11 @@
 }
 
 static /*const*/ struct file_operations solo1_dmfm_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		solo1_dmfm_ioctl,
-	open:		solo1_dmfm_open,
-	release:	solo1_dmfm_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= solo1_dmfm_ioctl,
+	.open		= solo1_dmfm_open,
+	.release	= solo1_dmfm_release,
 };
 
 /* --------------------------------------------------------------------- */
