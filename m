Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUBTM5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUBTM4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:56:07 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:5984 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261199AbUBTMxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:53:00 -0500
Date: Fri, 20 Feb 2004 13:48:25 +0100
Message-Id: <200402201248.i1KCmP95004329@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 415] M68k core spelling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k core spelling fix (from Michael Hayes)

--- linux-2.6.3/arch/m68k/kernel/traps.c	2004-02-08 21:52:17.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/kernel/traps.c	2004-02-11 12:13:48.000000000 +0100
@@ -646,7 +646,7 @@
 			if (do_page_fault (&fp->ptregs, addr, errorcode) < 0)
 				return;
 		} else if (!(mmusr & MMU_I)) {
-			/* propably a 020 cas fault */
+			/* probably a 020 cas fault */
 			if (!(ssw & RM))
 				printk("unexpected bus error (%#x,%#x)\n", ssw, mmusr);
 		} else if (mmusr & (MMU_B|MMU_L|MMU_S)) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
