Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTI1NJf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbTI1NIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:08:00 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:43 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262560AbTI1NFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:05:42 -0400
Date: Sun, 28 Sep 2003 14:55:22 +0200
Message-Id: <200309281255.h8SCtMoN005516@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 307] Mac SWIM floppy missing include
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac SWIM floppy: Add missing include

--- linux-2.6.0-test6/drivers/block/swim_iop.c	Sat Aug  9 21:42:48 2003
+++ linux-m68k-2.6.0-test6/drivers/block/swim_iop.c	Thu Sep 18 04:24:55 2003
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/fd.h>
 #include <linux/ioctl.h>
+#include <linux/blkdev.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/mac_iop.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
