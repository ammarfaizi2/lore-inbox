Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312492AbSCZPjq>; Tue, 26 Mar 2002 10:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312477AbSCZPjh>; Tue, 26 Mar 2002 10:39:37 -0500
Received: from mail.sonytel.be ([193.74.243.200]:7383 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S312347AbSCZPjX>;
	Tue, 26 Mar 2002 10:39:23 -0500
Date: Tue, 26 Mar 2002 16:39:15 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci_set_mwi
Message-ID: <Pine.GSO.4.21.0203261633140.7290-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apparently MWI means `memory-write-INvalidate'.

--- linux-2.4.19-pre4/drivers/pci/pci.c.orig	Thu Mar 21 09:33:37 2002
+++ linux-2.4.19-pre4/drivers/pci/pci.c	Tue Mar 26 16:33:04 2002
@@ -889,7 +889,7 @@
 }
 
 /**
- * pci_set_mwi - enables memory-write-validate PCI transaction
+ * pci_set_mwi - enables memory-write-invalidate PCI transaction
  * @dev: the PCI device for which MWI is enabled
  *
  * Enables the Memory-Write-Invalidate transaction in %PCI_COMMAND,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

