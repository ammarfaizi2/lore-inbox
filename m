Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUEJTpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUEJTpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUEJTpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:45:53 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:2102 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261389AbUEJTpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:45:51 -0400
Date: Mon, 10 May 2004 21:45:47 +0200
Message-Id: <200405101945.i4AJjlYh029382@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 447] M68k missing <linux/compiler.h>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: <asm/virtconvert.h> needs include <linux/compiler.h> for
__attribute_const__ (from Richard Zidlicky)

--- linux-2.6.6/include/asm-m68k/virtconvert.h	2004-05-03 11:01:24.000000000 +0200
+++ linux-m68k-2.6.6/include/asm-m68k/virtconvert.h	2004-05-05 12:58:46.000000000 +0200
@@ -8,6 +8,7 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <asm/setup.h>
 #include <asm/page.h>
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
