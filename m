Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUAAUJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUAAUH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:07:28 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:23098 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264873AbUAAUCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:02:02 -0500
Date: Thu, 1 Jan 2004 21:02:00 +0100
Message-Id: <200401012002.i01K20YE031805@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 361] Macfb setup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macfb: Update setup routine (from Matthias Urlichs)

--- linux-2.6.0/drivers/video/macfb.c	Tue Jul 29 18:19:18 2003
+++ linux-m68k-2.6.0/drivers/video/macfb.c	Mon Oct 20 21:49:57 2003
@@ -592,7 +592,7 @@
 	.fb_cursor	= soft_cursor,
 };
 
-void __init macfb_setup(char *options, int *ints)
+void __init macfb_setup(char *options)
 {
 	char *this_opt;
 	

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
