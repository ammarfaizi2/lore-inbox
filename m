Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTDHAHq (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTDGXY3 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:24:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1153
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263750AbTDGXK5 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:10:57 -0400
Date: Tue, 8 Apr 2003 01:29:53 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080029.h380TrP7009170@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: asm-alpha typo fixe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-alpha/mmzone.h linux-2.5.67-ac1/include/asm-alpha/mmzone.h
--- linux-2.5.67/include/asm-alpha/mmzone.h	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-alpha/mmzone.h	2003-04-03 23:49:57.000000000 +0100
@@ -51,7 +51,7 @@
 #ifdef CONFIG_DISCONTIGMEM
 
 /*
- * Following are macros that each numa implmentation must define.
+ * Following are macros that each numa implementation must define.
  */
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-alpha/pci.h linux-2.5.67-ac1/include/asm-alpha/pci.h
--- linux-2.5.67/include/asm-alpha/pci.h	2003-03-18 16:46:52.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-alpha/pci.h	2003-04-03 23:49:57.000000000 +0100
@@ -78,7 +78,7 @@
 /* Free and unmap a consistent DMA buffer.  CPU_ADDR and DMA_ADDR must
    be values that were returned from pci_alloc_consistent.  SIZE must
    be the same as what as passed into pci_alloc_consistent.
-   References to the memory and mappings assosciated with CPU_ADDR or
+   References to the memory and mappings associated with CPU_ADDR or
    DMA_ADDR past this call are illegal.  */
 
 extern void pci_free_consistent(struct pci_dev *, size_t, void *, dma_addr_t);
@@ -118,7 +118,7 @@
 	(((PTR)->LEN_NAME) = (VAL))
 
 /* Map a set of buffers described by scatterlist in streaming mode for
-   PCI DMA.  This is the scather-gather version of the above
+   PCI DMA.  This is the scatter-gather version of the above
    pci_map_single interface.  Here the scatter gather list elements
    are each tagged with the appropriate PCI dma address and length.
    They are obtained via sg_dma_{address,length}(SG).
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-alpha/uaccess.h linux-2.5.67-ac1/include/asm-alpha/uaccess.h
--- linux-2.5.67/include/asm-alpha/uaccess.h	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-alpha/uaccess.h	2003-04-03 23:49:57.000000000 +0100
@@ -31,7 +31,7 @@
 
 
 /*
- * Is a address valid? This does a straighforward calculation rather
+ * Is a address valid? This does a straightforward calculation rather
  * than tests.
  *
  * Address valid if:
