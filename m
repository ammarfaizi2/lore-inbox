Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVAGVUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVAGVUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVAGVON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:14:13 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:57652 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261601AbVAGVLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:11:05 -0500
Date: Fri, 7 Jan 2005 22:11:03 +0100
Message-Id: <200501072111.j07LB3Hd011212@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 166] Kill unused variables in the tty code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill unused variables in the tty code

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.29-rc1/drivers/char/tty_io.c	2004-12-26 11:04:04.000000000 +0100
+++ linux-m68k-2.4.29-rc1/drivers/char/tty_io.c	2004-12-26 13:15:53.000000000 +0100
@@ -480,7 +480,6 @@
 	int	retval = 0;
 	struct	tty_ldisc o_ldisc;
 	char buf[64];
-	int work;
 	unsigned long flags;
 	struct tty_ldisc *ld;
 
--- linux-2.4.29-rc1/drivers/char/tty_ioctl.c	2004-12-26 10:43:11.000000000 +0100
+++ linux-m68k-2.4.29-rc1/drivers/char/tty_ioctl.c	2004-12-26 13:16:01.000000000 +0100
@@ -387,7 +387,6 @@
 	struct tty_struct * real_tty;
 	int retval;
 	struct tty_ldisc *ld;
-	unsigned long flags;
 
 	if (tty->driver.type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver.subtype == PTY_TYPE_MASTER)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
