Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263706AbTDGWlI (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTDGWlI (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:41:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34944
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263706AbTDGWlH (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:41:07 -0400
Date: Tue, 8 Apr 2003 00:59:57 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304072359.h37NxvTf008882@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: alpha typos part 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/alpha/kernel/core_cia.c linux-2.5.67-ac1/arch/alpha/kernel/core_cia.c
--- linux-2.5.67/arch/alpha/kernel/core_cia.c	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.67-ac1/arch/alpha/kernel/core_cia.c	2003-04-03 23:49:57.000000000 +0100
@@ -610,7 +610,7 @@
 		*(vip)CIA_IOC_CIA_CNFG = temp;
 	}
 
-	/* Syncronize with all previous changes.  */
+	/* Synchronize with all previous changes.  */
 	mb();
 	*(vip)CIA_IOC_CIA_REV;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/alpha/kernel/pci.c linux-2.5.67-ac1/arch/alpha/kernel/pci.c
--- linux-2.5.67/arch/alpha/kernel/pci.c	2003-04-08 00:37:34.000000000 +0100
+++ linux-2.5.67-ac1/arch/alpha/kernel/pci.c	2003-04-03 23:49:57.000000000 +0100
@@ -230,7 +230,7 @@
 void __init
 pcibios_fixup_bus(struct pci_bus *bus)
 {
-	/* Propogate hose info into the subordinate devices.  */
+	/* Propagate hose info into the subordinate devices.  */
 
 	struct pci_controller *hose = bus->sysdata;
 	struct list_head *ln;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/alpha/kernel/pci_iommu.c linux-2.5.67-ac1/arch/alpha/kernel/pci_iommu.c
--- linux-2.5.67/arch/alpha/kernel/pci_iommu.c	2003-03-06 17:04:22.000000000 +0000
+++ linux-2.5.67-ac1/arch/alpha/kernel/pci_iommu.c	2003-04-03 23:49:57.000000000 +0100
@@ -431,7 +431,7 @@
 /* Free and unmap a consistent DMA buffer.  CPU_ADDR and DMA_ADDR must
    be values that were returned from pci_alloc_consistent.  SIZE must
    be the same as what as passed into pci_alloc_consistent.
-   References to the memory and mappings assosciated with CPU_ADDR or
+   References to the memory and mappings associated with CPU_ADDR or
    DMA_ADDR past this call are illegal.  */
 
 void
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/alpha/kernel/semaphore.c linux-2.5.67-ac1/arch/alpha/kernel/semaphore.c
--- linux-2.5.67/arch/alpha/kernel/semaphore.c	2003-02-10 18:38:38.000000000 +0000
+++ linux-2.5.67-ac1/arch/alpha/kernel/semaphore.c	2003-04-03 23:49:57.000000000 +0100
@@ -122,7 +122,7 @@
 		long tmp, tmp2, tmp3;
 
 		/* We must undo the sem->count down_interruptible decrement
-		   simultaneously and atomicly with the sem->waking
+		   simultaneously and atomically with the sem->waking
 		   adjustment, otherwise we can race with __up.  This is
 		   accomplished by doing a 64-bit ll/sc on two 32-bit words.
 		
