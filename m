Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269559AbTGZQFL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272523AbTGZOlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:41:08 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:48947 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272534AbTGZOcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:53 -0400
Date: Sat, 26 Jul 2003 16:51:57 +0200
Message-Id: <200307261451.h6QEpvOm002448@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k #include <linux/config.h>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Kill unneeded #include <linux/config.h>

--- linux-2.6.x/include/asm-m68k/kmap_types.h	Tue Mar 25 10:07:21 2003
+++ linux-m68k-2.6.x/include/asm-m68k/kmap_types.h	Wed Jul  9 17:27:31 2003
@@ -1,8 +1,6 @@
 #ifndef __ASM_M68K_KMAP_TYPES_H
 #define __ASM_M68K_KMAP_TYPES_H
 
-#include <linux/config.h>
-
 enum km_type {
 	KM_BOUNCE_READ,
 	KM_SKB_SUNRPC_DATA,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
