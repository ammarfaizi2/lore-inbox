Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbTI1NJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTI1NIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:08:14 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:58401 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262557AbTI1NFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:05:32 -0400
Date: Sun, 28 Sep 2003 14:55:20 +0200
Message-Id: <200309281255.h8SCtKWQ005498@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 304] M68k PCI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k PCI: Include <asm/scatterlist.h>, like all other archs do

--- linux-2.6.0-test6/include/asm-m68k/pci.h	Sun Jun 15 09:38:59 2003
+++ linux-m68k-2.6.0-test6/include/asm-m68k/pci.h	Tue Sep  9 14:25:13 2003
@@ -7,6 +7,8 @@
  * Written by Wout Klaren.
  */
 
+#include <asm/scatterlist.h>
+
 struct pci_ops;
 
 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
