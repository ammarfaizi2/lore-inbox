Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266194AbUGTSvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUGTSvv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUGTStX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:49:23 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:45102 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S266141AbUGTSoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:44:38 -0400
Date: Tue, 20 Jul 2004 20:38:08 +0200
Message-Id: <200407201838.i6KIc8A2015424@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 471] m68k hardirq.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing #include <linux/config.h>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/include/asm-m68k/hardirq.h	2004-04-28 10:58:58.000000000 +0200
+++ linux-m68k-2.6.8-rc2/include/asm-m68k/hardirq.h	2004-07-10 21:06:55.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef __M68K_HARDIRQ_H
 #define __M68K_HARDIRQ_H
 
+#include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/cache.h>
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
