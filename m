Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTH2Owh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbTH2Ouv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:50:51 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:38718 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261292AbTH2Ouj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:50:39 -0400
Date: Fri, 29 Aug 2003 16:49:47 +0200
Message-Id: <200308291449.h7TEnlR8005839@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Sun-3 SBUS updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3 SBUS updates: Rename remaining occurrencies of struct linux_sbus_device
to struct sbus_dev for source code compatibility with SPARC

--- linux-2.4.23-pre1/include/asm-m68k/dvma.h	2 Mar 2003 20:58:23 -0000	1.1.1.1.2.1
+++ linux-m68k-2.4.23-pre1/include/asm-m68k/dvma.h	14 Jun 2003 11:40:33 -0000
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
