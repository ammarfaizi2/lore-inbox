Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272534AbTGZOlU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272551AbTGZOk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:40:59 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:25662 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272533AbTGZOcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:52 -0400
Date: Sat, 26 Jul 2003 16:51:56 +0200
Message-Id: <200307261451.h6QEpu0g002442@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k mm cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Kill superfluous includes

--- linux-2.6.x/arch/m68k/mm/memory.c	Thu Mar 27 10:58:32 2003
+++ linux-m68k-2.6.x/arch/m68k/mm/memory.c	Tue Jul  1 22:34:03 2003
@@ -19,11 +19,7 @@
 #include <asm/pgalloc.h>
 #include <asm/system.h>
 #include <asm/traps.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
-#ifdef CONFIG_AMIGA
-#include <asm/amigahw.h>
-#endif
 
 
 /* ++andreas: {get,free}_pointer_table rewritten to use unused fields from

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
