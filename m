Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUCVKCB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 05:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUCVKAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 05:00:42 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:51531 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261860AbUCVKAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 05:00:20 -0500
Date: Mon, 22 Mar 2004 11:00:17 +0100
Message-Id: <200403221000.i2MA0HpQ004127@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 150] Mac missing include
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac: Add missing #include <asm/keyboard.h> (needed for SYSRQ_KEY)

--- linux-2.4.26-pre5/arch/m68k/mac/config.c	2003-07-10 16:22:26.000000000 +0200
+++ linux-m68k-2.4.26-pre5/arch/m68k/mac/config.c	2004-02-09 20:32:36.000000000 +0100
@@ -33,6 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/rtc.h>
 #include <asm/machdep.h>
+#include <asm/keyboard.h>
 
 #include <asm/macintosh.h>
 #include <asm/macints.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
