Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264128AbTCUUof>; Fri, 21 Mar 2003 15:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263814AbTCUSxv>; Fri, 21 Mar 2003 13:53:51 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30852
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263813AbTCUSws>; Fri, 21 Mar 2003 13:52:48 -0500
Date: Fri, 21 Mar 2003 20:08:04 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212008.h2LK84C3026266@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix  __NO_VERSION__ in audio_syms
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/audio_syms.c linux-2.5.65-ac2/sound/oss/audio_syms.c
--- linux-2.5.65/sound/oss/audio_syms.c	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/audio_syms.c	2003-03-14 00:52:26.000000000 +0000
@@ -1,9 +1,7 @@
 /*
  * Exported symbols for audio driver.
- * __NO_VERSION__ because this is still part of sound.o.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 
 char audio_syms_symbol;
