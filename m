Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTIZMNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTIZMNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:13:46 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:52773 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262063AbTIZMNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:13:45 -0400
Date: Fri, 26 Sep 2003 14:14:06 +0200
Message-Id: <200309261214.h8QCE6iG004999@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 088] Sun-3 SBUS updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3 SBUS updates: Rename remaining occurrencies of struct linux_sbus_device
to struct sbus_dev for source code compatibility with SPARC

--- linux-2.4.23-pre5/include/asm-m68k/dvma.h	2 Mar 2003 20:58:23 -0000	1.1.1.1.2.1
+++ linux-m68k-2.4.23-pre5/include/asm-m68k/dvma.h	14 Jun 2003 11:40:33 -0000
@@ -110,7 +110,7 @@
 /* Linux DMA information structure, filled during probe. */
 struct Linux_SBus_DMA {
 	struct Linux_SBus_DMA *next;
-	struct linux_sbus_device *SBus_dev;
+	struct sbus_dev *SBus_dev;
 	struct sparc_dma_registers *regs;
 
 	/* Status, misc info */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
