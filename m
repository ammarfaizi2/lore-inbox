Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTI1NJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTI1NIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:08:07 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:6418 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262558AbTI1NFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:05:40 -0400
Date: Sun, 28 Sep 2003 14:55:21 +0200
Message-Id: <200309281255.h8SCtLEW005510@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 306] Atari ST-RAM missing include
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari ST-RAM: Add missing include

--- linux-2.6.0-test6/arch/m68k/atari/stram.c	Tue Sep  9 10:12:16 2003
+++ linux-m68k-2.6.0-test6/arch/m68k/atari/stram.c	Sun Sep 14 20:41:59 2003
@@ -22,6 +22,7 @@
 #include <linux/shm.h>
 #include <linux/bootmem.h>
 #include <linux/mount.h>
+#include <linux/blkdev.h>
 
 #include <asm/setup.h>
 #include <asm/machdep.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
