Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTHXM6W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263499AbTHXM6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:58:22 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:44357 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S263460AbTHXM6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:58:18 -0400
Date: Sun, 24 Aug 2003 14:58:49 +0200
Message-Id: <200308241258.h7OCwnpt000961@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k asm/local.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: asm/local.h just includes the generic version (from Roman Zippel)

--- linux-2.6.0-test2/include/asm-m68k/local.h	Tue Jun 24 14:30:53 2003
+++ linux-m68k-2.6.0-test2/include/asm-m68k/local.h	Mon Jul 28 00:23:16 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_M68K_LOCAL_H
+#define _ASM_M68K_LOCAL_H
+
+#include <asm-generic/local.h>
+
+#endif /* _ASM_M68K_LOCAL_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
