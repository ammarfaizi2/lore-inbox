Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUGTSs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUGTSs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUGTSmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:42:18 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:1328 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S266138AbUGTSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:10 -0400
Date: Tue, 20 Jul 2004 20:38:08 +0200
Message-Id: <200407201838.i6KIc8Fg015429@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 472] dmasound paths
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmasound was moved to sound/oss/ a while ago

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/sound/oss/dmasound/dmasound.h	2004-05-24 11:14:06.000000000 +0200
+++ linux-m68k-2.6.8-rc2/sound/oss/dmasound/dmasound.h	2004-07-11 11:57:40.000000000 +0200
@@ -1,6 +1,6 @@
 #ifndef _dmasound_h_
 /*
- *  linux/drivers/sound/dmasound/dmasound.h
+ *  linux/sound/oss/dmasound/dmasound.h
  *
  *
  *  Minor numbers for the sound driver.
--- linux-2.6.8-rc2/sound/oss/dmasound/dmasound_atari.c	2004-04-28 11:02:52.000000000 +0200
+++ linux-m68k-2.6.8-rc2/sound/oss/dmasound/dmasound_atari.c	2004-07-11 11:57:46.000000000 +0200
@@ -1,9 +1,9 @@
 /*
- *  linux/drivers/sound/dmasound/dmasound_atari.c
+ *  linux/sound/oss/dmasound/dmasound_atari.c
  *
  *  Atari TT and Falcon DMA Sound Driver
  *
- *  See linux/drivers/sound/dmasound/dmasound_core.c for copyright and credits
+ *  See linux/sound/oss/dmasound/dmasound_core.c for copyright and credits
  *  prior to 28/01/2001
  *
  *  28/01/2001 [0.1] Iain Sandoe
--- linux-2.6.8-rc2/sound/oss/dmasound/dmasound_awacs.c	2004-05-24 11:14:06.000000000 +0200
+++ linux-m68k-2.6.8-rc2/sound/oss/dmasound/dmasound_awacs.c	2004-07-11 11:57:50.000000000 +0200
@@ -1,10 +1,10 @@
 /*
- *  linux/drivers/sound/dmasound/dmasound_awacs.c
+ *  linux/sound/oss/dmasound/dmasound_awacs.c
  *
  *  PowerMac `AWACS' and `Burgundy' DMA Sound Driver
  *  with some limited support for DACA & Tumbler
  *
- *  See linux/drivers/sound/dmasound/dmasound_core.c for copyright and
+ *  See linux/sound/oss/dmasound/dmasound_core.c for copyright and
  *  history prior to 2001/01/26.
  *
  *	26/01/2001 ed 0.1 Iain Sandoe
--- linux-2.6.8-rc2/sound/oss/dmasound/dmasound_core.c	2004-04-28 15:49:59.000000000 +0200
+++ linux-m68k-2.6.8-rc2/sound/oss/dmasound/dmasound_core.c	2004-07-11 11:57:55.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/sound/dmasound/dmasound_core.c
+ *  linux/sound/oss/dmasound/dmasound_core.c
  *
  *
  *  OSS/Free compatible Atari TT/Falcon and Amiga DMA sound driver for
--- linux-2.6.8-rc2/sound/oss/dmasound/dmasound_paula.c	2004-04-28 11:02:52.000000000 +0200
+++ linux-m68k-2.6.8-rc2/sound/oss/dmasound/dmasound_paula.c	2004-07-11 11:58:09.000000000 +0200
@@ -1,9 +1,9 @@
 /*
- *  linux/drivers/sound/dmasound/dmasound_paula.c
+ *  linux/sound/oss/dmasound/dmasound_paula.c
  *
  *  Amiga `Paula' DMA Sound Driver
  *
- *  See linux/drivers/sound/dmasound/dmasound_core.c for copyright and credits
+ *  See linux/sound/oss/dmasound/dmasound_core.c for copyright and credits
  *  prior to 28/01/2001
  *
  *  28/01/2001 [0.1] Iain Sandoe
--- linux-2.6.8-rc2/sound/oss/dmasound/dmasound_q40.c	2004-04-28 11:02:52.000000000 +0200
+++ linux-m68k-2.6.8-rc2/sound/oss/dmasound/dmasound_q40.c	2004-07-11 11:58:12.000000000 +0200
@@ -1,9 +1,9 @@
 /*
- *  linux/drivers/sound/dmasound/dmasound_q40.c
+ *  linux/sound/oss/dmasound/dmasound_q40.c
  *
  *  Q40 DMA Sound Driver
  *
- *  See linux/drivers/sound/dmasound/dmasound_core.c for copyright and credits
+ *  See linux/sound/oss/dmasound/dmasound_core.c for copyright and credits
  *  prior to 28/01/2001
  *
  *  28/01/2001 [0.1] Iain Sandoe
--- linux-2.6.8-rc2/sound/oss/dmasound/trans_16.c	2004-04-28 15:48:25.000000000 +0200
+++ linux-m68k-2.6.8-rc2/sound/oss/dmasound/trans_16.c	2004-07-11 11:58:15.000000000 +0200
@@ -1,9 +1,9 @@
 /*
- *  linux/drivers/sound/dmasound/trans_16.c
+ *  linux/sound/oss/dmasound/trans_16.c
  *
  *  16 bit translation routines.  Only used by Power mac at present.
  *
- *  See linux/drivers/sound/dmasound/dmasound_core.c for copyright and
+ *  See linux/sound/oss/dmasound/dmasound_core.c for copyright and
  *  history prior to 08/02/2001.
  *
  *  08/02/2001 Iain Sandoe

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
