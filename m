Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbTDMNGV (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 09:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTDMM5l (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:57:41 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:56610 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S263505AbTDMM4Q (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:56:16 -0400
Date: Sun, 13 Apr 2003 15:05:18 +0200
Message-Id: <200304131305.h3DD5Im3001299@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k needs WANT_PAGE_VIRTUAL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k needs WANT_PAGE_VIRTUAL (from Richard Zidlicky)

--- linux-2.4.21-pre7/include/asm-m68k/page.h	Sun Apr  6 10:29:44 2003
+++ linux-m68k-2.4.21-pre7/include/asm-m68k/page.h	Sun Apr  6 23:24:12 2003
@@ -127,6 +127,7 @@
 
 #ifndef CONFIG_SUN3
 
+#define WANT_PAGE_VIRTUAL
 #ifdef CONFIG_SINGLE_MEMORY_CHUNK
 extern unsigned long m68k_memoffset;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
