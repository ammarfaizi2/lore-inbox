Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSLXMrS>; Tue, 24 Dec 2002 07:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSLXMrS>; Tue, 24 Dec 2002 07:47:18 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:38852 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261721AbSLXMrR>;
	Tue, 24 Dec 2002 07:47:17 -0500
Date: Tue, 24 Dec 2002 13:55:12 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rusty Trivial Russell <trivial@rustcorp.com.au>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove unused prototype for init_modules()
Message-ID: <Pine.GSO.4.21.0212241354220.1821-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove unused prototype for init_modules()

--- linux-2.5.53/init/main.c	Tue Dec 24 10:09:02 2002
+++ linux-m68k-2.5.53/init/main.c	Tue Dec 24 10:41:42 2002
@@ -58,7 +58,6 @@
 static int init(void *);
 
 extern void init_IRQ(void);
-extern void init_modules(void);
 extern void sock_init(void);
 extern void fork_init(unsigned long);
 extern void extable_init(void);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

