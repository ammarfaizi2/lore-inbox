Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSKRWMU>; Mon, 18 Nov 2002 17:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265033AbSKRWMU>; Mon, 18 Nov 2002 17:12:20 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:33250 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265037AbSKRWMS>;
	Mon, 18 Nov 2002 17:12:18 -0500
Date: Mon, 18 Nov 2002 23:19:14 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] More missing includes [3/4]
Message-ID: <Pine.GSO.4.21.0211182318110.16079-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add missing #include <linux/sched.h>

--- linux-2.5.48/drivers/parport/ieee1284.c	Tue Jan 29 10:14:00 2002
+++ linux-m68k-2.5.48/drivers/parport/ieee1284.c	Mon Nov 18 14:06:27 2002
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/sched.h>
 
 #undef DEBUG /* undef me for production */
 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

