Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbUJaKkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbUJaKkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUJaKjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:39:22 -0500
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:22861
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261541AbUJaKDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:47 -0500
Date: Sun, 31 Oct 2004 11:03:41 +0100
Message-Id: <200410311003.i9VA3fGx009709@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 518] Reiserfs: Add missing #include <linux/sched.h>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reiserfs: Add missing #include <linux/sched.h>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/include/linux/reiserfs_fs.h	2004-10-23 10:33:38.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/linux/reiserfs_fs.h	2004-10-24 16:42:45.000000000 +0200
@@ -16,6 +16,7 @@
 #ifdef __KERNEL__
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <asm/unaligned.h>
 #include <linux/bitops.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
