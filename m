Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272507AbTGZOlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272509AbTGZOfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:35:17 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:15669 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S272511AbTGZOcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:36 -0400
Date: Sat, 26 Jul 2003 16:51:43 +0200
Message-Id: <200307261451.h6QEphCP002346@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IPV6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing include for IPV6

--- linux-2.6.x/include/asm-m68k/checksum.h	Mon Oct 28 11:03:42 2002
+++ linux-m68k-2.6.x/include/asm-m68k/checksum.h	Sun Jun  8 13:32:24 2003
@@ -1,6 +1,8 @@
 #ifndef _M68K_CHECKSUM_H
 #define _M68K_CHECKSUM_H
 
+#include <linux/in6.h>
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
