Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbUBTMxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUBTMwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:52:50 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:59937 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261199AbUBTMsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:48:38 -0500
Date: Fri, 20 Feb 2004 13:48:23 +0100
Message-Id: <200402201248.i1KCmNqV004311@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 412] M68k FPU emu broken link
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k FPU emu: Remove reference to non-existing website

--- linux-2.6.3/arch/m68k/kernel/setup.c	2003-05-27 19:02:33.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/kernel/setup.c	2004-02-08 20:57:22.000000000 +0100
@@ -538,7 +538,6 @@
 				"WHICH IS REQUIRED BY LINUX/M68K ***\n" );
 		printk( KERN_EMERG "Upgrade your hardware or join the FPU "
 				"emulation project\n" );
-		printk( KERN_EMERG "(see http://no-fpu.linux-m68k.org)\n" );
 		panic( "no FPU" );
 	}
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
