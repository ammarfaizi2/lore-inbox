Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263809AbTCUS4P>; Fri, 21 Mar 2003 13:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263824AbTCUSzQ>; Fri, 21 Mar 2003 13:55:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33924
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263809AbTCUSy2>; Fri, 21 Mar 2003 13:54:28 -0500
Date: Fri, 21 Mar 2003 20:09:43 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212009.h2LK9h6S026292@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: __NO_VERSION__ for midi_syms
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/midi_syms.c linux-2.5.65-ac2/sound/oss/midi_syms.c
--- linux-2.5.65/sound/oss/midi_syms.c	2003-02-10 18:37:59.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/midi_syms.c	2003-03-14 00:52:26.000000000 +0000
@@ -1,9 +1,7 @@
 /*
  * Exported symbols for midi driver.
- * __NO_VERSION__ because this is still part of sound.o.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 
 char midi_syms_symbol;
