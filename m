Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272509AbTGZOlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272511AbTGZOfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:35:36 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:35120 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272513AbTGZOci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:38 -0400
Date: Sat, 26 Jul 2003 16:51:41 +0200
Message-Id: <200307261451.h6QEpfeg002322@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atari ST-RAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari ST-RAM: Add missing include

--- linux-2.6.x/arch/m68k/atari/stram.c	Tue Apr  8 10:04:43 2003
+++ linux-m68k-2.6.x/arch/m68k/atari/stram.c	Sun Jun  8 10:59:19 2003
@@ -21,6 +21,7 @@
 #include <linux/pagemap.h>
 #include <linux/shm.h>
 #include <linux/bootmem.h>
+#include <linux/mount.h>
 
 #include <asm/setup.h>
 #include <asm/machdep.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
