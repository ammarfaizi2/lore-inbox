Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbUBTMtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUBTMrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:47:36 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:274 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261185AbUBTMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:46:55 -0500
Date: Fri, 20 Feb 2004 13:46:40 +0100
Message-Id: <200402201246.i1KCkeGp004211@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 397] M68k MCA cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Remove obsolete MCA definition

--- linux-2.6.3/include/asm-m68k/processor.h	2003-11-30 20:07:03.000000000 +0100
+++ linux-m68k-2.6.3/include/asm-m68k/processor.h	2004-01-29 12:10:54.000000000 +0100
@@ -56,11 +56,6 @@
 #endif
 #define TASK_UNMAPPED_ALIGN(addr, off)	PAGE_ALIGN(addr)
 
-/*
- * Bus types
- */
-#define MCA_bus 0
-
 struct task_work {
 	unsigned char sigpending;
 	unsigned char notify_resume;	/* request for notification on

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
