Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSLCNjl>; Tue, 3 Dec 2002 08:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSLCNjl>; Tue, 3 Dec 2002 08:39:41 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:31653 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261337AbSLCNjl>;
	Tue, 3 Dec 2002 08:39:41 -0500
Date: Tue, 3 Dec 2002 14:47:03 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: [PATCH] typo in comment
Message-ID: <Pine.GSO.4.21.0212031445460.23065-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Typo in comment. Applies to both 2.4.20 and 2.5.50.

--- linux/kernel/printk.c.orig	Fri Mar  1 11:06:05 2002
+++ linux/kernel/printk.c	Tue Dec  3 14:42:39 2002
@@ -629,7 +629,7 @@
 	}
 	if (console->flags & CON_PRINTBUFFER) {
 		/*
-		 * release_cosole_sem() will print out the buffered messages for us.
+		 * release_console_sem() will print out the buffered messages for us.
 		 */
 		spin_lock_irqsave(&logbuf_lock, flags);
 		con_start = log_start;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

