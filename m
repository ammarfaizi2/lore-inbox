Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263536AbTHXM7k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263499AbTHXM6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:58:25 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:46397 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S263463AbTHXM6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:58:20 -0400
Date: Sun, 24 Aug 2003 14:58:50 +0200
Message-Id: <200308241258.h7OCwo1B000973@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Amiga z2ram
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga z2ram: Add missing includes and remove some unnecessary includes

--- linux-2.6.0-test2/drivers/block/z2ram.c	Tue Jul 29 18:18:46 2003
+++ linux-m68k-2.6.0-test2/drivers/block/z2ram.c	Wed Jul 30 22:20:18 2003
@@ -28,10 +28,10 @@
 #define DEVICE_NAME "Z2RAM"
 
 #include <linux/major.h>
-#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/blkdev.h>
 
 #include <asm/setup.h>
 #include <asm/bitops.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
