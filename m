Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTI1Snj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbTI1Snj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:43:39 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:55136 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262671AbTI1Snh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:43:37 -0400
Date: Sun, 28 Sep 2003 14:55:41 +0200
Message-Id: <200309281255.h8SCtfcB005672@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 334] Amiga A2232 Serial typo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A2232 Serial: Fix typo

--- linux-2.6.0-test6/drivers/char/ser_a2232.c	Sun Sep 28 09:35:59 2003
+++ linux-m68k-2.6.0-test6/drivers/char/ser_a2232.c	Sun Sep 28 10:18:12 2003
@@ -703,7 +703,7 @@
 	a2232_driver->name = "ttyY";
 	a2232_driver->major = A2232_NORMAL_MAJOR;
 	a2232_driver->type = TTY_DRIVER_TYPE_SERIAL;
-	a2232_driver->subtype = SERIAL_TTY_NORMAL;
+	a2232_driver->subtype = SERIAL_TYPE_NORMAL;
 	a2232_driver->init_termios = tty_std_termios;
 	a2232_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
