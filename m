Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293422AbSB1Po3>; Thu, 28 Feb 2002 10:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293423AbSB1PoP>; Thu, 28 Feb 2002 10:44:15 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:59780 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S293434AbSB1PnH>; Thu, 28 Feb 2002 10:43:07 -0500
Message-Id: <200202281455.HAA26468@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.5-dj2, add 9 help texts to sound/oss/Config.help
Date: Thu, 28 Feb 2002 08:41:06 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds help texts for the following nine options
to sound/oss/Config.help. The texts were obtained from 
Eric Raymond's Configure.help v2.97.

Steven

CONFIG_SOUND_VRC5477
CONFIG_SC6600_CDROM
CONFIG_SOUND_CMPCI_FM
CONFIG_SOUND_CMPCI_FMIO
CONFIG_SOUND_CMPCI_MIDI
CONFIG_SOUND_CMPCI_MPUIO
CONFIG_SOUND_CMPCI_SPDIFINVERSE
CONFIG_SOUND_CMPCI_LINE_REAR
CONFIG_SOUND_CMPCI_LINE_BASS

--- linux-2.5.5-dj2/sound/oss/Config.help.orig	Thu Feb 28 08:06:58 2002
+++ linux-2.5.5-dj2/sound/oss/Config.help	Thu Feb 28 08:24:45 2002
@@ -192,6 +192,11 @@
   <file:Documentation/sound/vwsnd> for more info on this driver's
   capabilities.
 
+CONFIG_SOUND_VRC5477
+  Say Y here to enable sound support for the NEC Vrc5477 chip, an
+  integrated, multi-function controller chip for MIPS CPUs.  Works
+  with the AC97 codec.
+
 CONFIG_SOUND_SSCAPE
   Answer Y if you have a sound card based on the Ensoniq SoundScape
   chipset. Such cards are being manufactured at least by Ensoniq, Spea
@@ -476,6 +481,11 @@
   Say Y here in order to use the joystick interface of the Audio Excel
   DSP 16 card.
 
+CONFIG_SC6600_CDROM
+  This is used to activate the CD-ROM interface of the Audio Excel
+  DSP 16 card. Enter: 0 for Sony, 1 for Panasonic, 2 for IDE, 4 for no
+  CD-ROM present.
+
 CONFIG_SC6600_CDROMBASE
   Base I/O port address for the CD-ROM interface of the Audio Excel
   DSP 16 card.
@@ -498,6 +508,34 @@
   chips is available at
   <http://member.nifty.ne.jp/Breeze/softwares/unix/cmictl-e.html>.
 
+CONFIG_SOUND_CMPCI_FM
+  Say Y here to enable the legacy FM (frequency-modulation) synthesis
+  support on a card using the CMI8338 or CMI8378 chipset.
+
+CONFIG_SOUND_CMPCI_FMIO
+  Set the base I/O address for FM synthesis control on a card using
+  the CMI8338 or CMI8378 chipset.
+
+CONFIG_SOUND_CMPCI_MIDI
+  Say Y here to enable the legacy MP401 MIDI synthesis support on a
+  card using the CMI8338 or CMI8378 chipset.
+
+CONFIG_SOUND_CMPCI_MPUIO
+  Set the base I/O address for MP401 MIDI synthesis control on a card
+  using the CMI8338 or CMI8378 chipset.
+
+CONFIG_SOUND_CMPCI_SPDIFINVERSE
+  Say Y here to have the driver invert the signal presented on SPDIF IN
+  of s card using the CMI8338 or CMI8378 chipset.
+
+CONFIG_SOUND_CMPCI_LINE_REAR
+  Say Y here to enable using line-in jack as an output jack for a rear
+  speaker.
+
+CONFIG_SOUND_CMPCI_LINE_BASS
+  Say Y here to enable using line-in jack as an output jack for a bass
+  speaker.
+
 CONFIG_SOUND_CMPCI_CM8738
   Say Y or M if you have a PCI sound card using the CMI8338
   or the CMI8378 chipset.  Data on this chip is available at
