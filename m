Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUGTSiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUGTSiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUGTSiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:38:06 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:26198 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S266116AbUGTSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:03 -0400
Date: Tue, 20 Jul 2004 20:38:00 +0200
Message-Id: <200407201838.i6KIc0OC015394@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 465] m68k sparse extern
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Remove `extern' at function definition (found by sparse)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/arch/m68k/kernel/traps.c	2004-06-20 17:14:30.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/kernel/traps.c	2004-07-10 21:07:34.000000000 +0200
@@ -990,7 +990,7 @@
 	printk ("\n");
 }
 
-extern void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack(struct task_struct *task, unsigned long *stack)
 {
 	unsigned long *endstack;
 	int i;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
