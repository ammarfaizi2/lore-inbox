Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTLGU6s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTLGU5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:57:42 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:44092 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S264527AbTLGUzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:37 -0500
Date: Sun, 7 Dec 2003 21:51:23 +0100
Message-Id: <200312072051.hB7KpNBt000723@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 132] Macfb setup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macfb: Update setup routine (from Matthias Urlichs in 2.6.0)

--- linux-2.4.23/drivers/video/macfb.c	Fri Sep 13 10:16:48 2002
+++ linux-m68k-2.4.23/drivers/video/macfb.c	Mon Oct 20 21:50:01 2003
@@ -839,7 +839,7 @@
 	fb_set_cmap:	macfb_set_cmap,
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
