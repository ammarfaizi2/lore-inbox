Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264122AbTCUUnX>; Fri, 21 Mar 2003 15:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264114AbTCUUmP>; Fri, 21 Mar 2003 15:42:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35460
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263822AbTCUSzH>; Fri, 21 Mar 2003 13:55:07 -0500
Date: Fri, 21 Mar 2003 20:10:23 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212010.h2LKANjd026304@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: more __NO_VERSION__ in audio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/nm256_audio.c linux-2.5.65-ac2/sound/oss/nm256_audio.c
--- linux-2.5.65/sound/oss/nm256_audio.c	2003-02-10 18:38:29.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/nm256_audio.c	2003-03-14 00:52:26.000000000 +0000
@@ -19,7 +19,6 @@
  *		Ported to 2.4 PCI API.
  */
 
-#define __NO_VERSION__
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/sequencer_syms.c linux-2.5.65-ac2/sound/oss/sequencer_syms.c
--- linux-2.5.65/sound/oss/sequencer_syms.c	2003-02-10 18:38:17.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/sequencer_syms.c	2003-03-14 00:52:26.000000000 +0000
@@ -1,9 +1,7 @@
 /*
  * Exported symbols for sequencer driver.
- * __NO_VERSION__ because this is still part of sound.o.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 
 char sequencer_syms_symbol;
