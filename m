Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263839AbTCUS6x>; Fri, 21 Mar 2003 13:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263835AbTCUS5j>; Fri, 21 Mar 2003 13:57:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37764
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263830AbTCUS5I>; Fri, 21 Mar 2003 13:57:08 -0500
Date: Fri, 21 Mar 2003 20:12:21 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212012.h2LKCLtI026322@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update emu10k1 config help
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/Kconfig linux-2.5.65-ac2/sound/oss/Kconfig
--- linux-2.5.65/sound/oss/Kconfig	2003-03-03 19:20:18.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/Kconfig	2003-03-03 21:09:18.000000000 +0000
@@ -113,15 +113,17 @@
 	  Say Y or M if you have a PCI sound card using the EMU10K1 chipset,
 	  such as the Creative SBLive!, SB PCI512 or Emu-APS.
 
-	  For more information on this driver and the degree of support for the
-	  different card models please check <http://opensource.creative.com/>.
+	  For more information on this driver and the degree of support for
+	  the different card models please check:
+
+	        <http://sourceforge.net/projects/emu10k1/>
 
 	  It is now possible to load dsp microcode patches into the EMU10K1
 	  chip.  These patches are used to implement real time sound
 	  processing effects which include for example: signal routing,
 	  bass/treble control, AC3 passthrough, ...
 	  Userspace tools to create new patches and load/unload them can be
-	  found at <http://opensource.creative.com/dist.html>.
+	  found in the emu-tools package at the above URL.
 
 config MIDI_EMU10K1
 	bool "Creative SBLive! MIDI (EXPERIMENTAL)"
@p
