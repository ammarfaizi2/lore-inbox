Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTHXM6U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbTHXM6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:58:19 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:44071 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S263455AbTHXM6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:58:18 -0400
Date: Sun, 24 Aug 2003 14:58:47 +0200
Message-Id: <200308241258.h7OCwlSW000948@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k asm/sections.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: asm/sections.h just includes the generic version (from Roman Zippel)

--- linux-2.6.0-test2/include/asm-m68k/sections.h	Thu Jan  1 01:00:00 1970
+++ linux-m68k-2.6.0-test2/include/asm-m68k/sections.h	Mon Jul 28 00:23:16 2003
@@ -0,0 +1,6 @@
+#ifndef _ASM_M68K_SECTIONS_H
+#define _ASM_M68K_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+#endif /* _ASM_M68K_SECTIONS_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
