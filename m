Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268243AbTBYUVK>; Tue, 25 Feb 2003 15:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268294AbTBYUVK>; Tue, 25 Feb 2003 15:21:10 -0500
Received: from [24.77.48.240] ([24.77.48.240]:40745 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268243AbTBYUVC>;
	Tue, 25 Feb 2003 15:21:02 -0500
Date: Tue, 25 Feb 2003 12:31:18 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302252031.h1PKVIo24925@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - shouldn't
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    shouldnt -> shouldn't (15 occurrences)

diff -ur a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Mon Feb 24 11:05:06 2003
+++ b/arch/i386/kernel/irq.c	Tue Feb 25 09:52:41 2003
@@ -696,7 +696,7 @@
  *	The interrupt probe logic state is returned to its previous
  *	value.
  *
- *	BUGS: When used in a module (which arguably shouldnt happen)
+ *	BUGS: When used in a module (which arguably shouldn't happen)
  *	nothing prevents two IRQ probe callers from overlapping. The
  *	results of this are non-optimal.
  */
diff -ur a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
--- a/arch/ia64/kernel/irq.c	Mon Feb 24 11:05:42 2003
+++ b/arch/ia64/kernel/irq.c	Tue Feb 25 09:52:44 2003
@@ -699,7 +699,7 @@
  *	The interrupt probe logic state is returned to its previous
  *	value.
  *
- *	BUGS: When used in a module (which arguably shouldnt happen)
+ *	BUGS: When used in a module (which arguably shouldn't happen)
  *	nothing prevents two IRQ probe callers from overlapping. The
  *	results of this are non-optimal.
  */
diff -ur a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
--- a/arch/mips/kernel/irq.c	Mon Feb 24 11:05:10 2003
+++ b/arch/mips/kernel/irq.c	Tue Feb 25 09:52:50 2003
@@ -600,7 +600,7 @@
  *	The interrupt probe logic state is returned to its previous
  *	value.
  *
- *	BUGS: When used in a module (which arguably shouldnt happen)
+ *	BUGS: When used in a module (which arguably shouldn't happen)
  *	nothing prevents two IRQ probe callers from overlapping. The
  *	results of this are non-optimal.
  */
diff -ur a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
--- a/arch/mips/math-emu/cp1emu.c	Mon Feb 24 11:05:44 2003
+++ b/arch/mips/math-emu/cp1emu.c	Tue Feb 25 09:52:55 2003
@@ -744,7 +744,7 @@
  * not change cp0_epc due to the instruction
  *
  * According to the spec:
- * 1) it shouldnt be a branch :-)
+ * 1) it shouldn't be a branch :-)
  * 2) it can be a COP instruction :-(
  * 3) if we are tring to run a protected memory space we must take
  *    special care on memory access instructions :-(
diff -ur a/arch/mips64/math-emu/cp1emu.c b/arch/mips64/math-emu/cp1emu.c
--- a/arch/mips64/math-emu/cp1emu.c	Mon Feb 24 11:05:35 2003
+++ b/arch/mips64/math-emu/cp1emu.c	Tue Feb 25 09:52:48 2003
@@ -767,7 +767,7 @@
  * not change cp0_epc due to the instruction
  *
  * According to the spec:
- * 1) it shouldnt be a branch :-)
+ * 1) it shouldn't be a branch :-)
  * 2) it can be a COP instruction :-(
  * 3) if we are tring to run a protected memory space we must take
  *    special care on memory access instructions :-(
diff -ur a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
--- a/arch/parisc/kernel/irq.c	Mon Feb 24 11:05:16 2003
+++ b/arch/parisc/kernel/irq.c	Tue Feb 25 09:52:58 2003
@@ -806,7 +806,7 @@
  *	The interrupt probe logic state is returned to its previous
  *	value.
  *
- *	BUGS: When used in a module (which arguably shouldnt happen)
+ *	BUGS: When used in a module (which arguably shouldn't happen)
  *	nothing prevents two IRQ probe callers from overlapping. The
  *	results of this are non-optimal.
  */
diff -ur a/arch/ppc64/mm/init.c b/arch/ppc64/mm/init.c
--- a/arch/ppc64/mm/init.c	Mon Feb 24 11:05:34 2003
+++ b/arch/ppc64/mm/init.c	Tue Feb 25 09:53:00 2003
@@ -603,7 +603,7 @@
 	clear_page(page);
 
 	/*
-	 * We shouldnt have to do this, but some versions of glibc
+	 * We shouldn't have to do this, but some versions of glibc
 	 * require it (ld.so assumes zero filled pages are icache clean)
 	 * - Anton
 	 */
diff -ur a/arch/v850/kernel/irq.c b/arch/v850/kernel/irq.c
--- a/arch/v850/kernel/irq.c	Mon Feb 24 11:05:39 2003
+++ b/arch/v850/kernel/irq.c	Tue Feb 25 09:53:03 2003
@@ -604,7 +604,7 @@
  *	The interrupt probe logic state is returned to its previous
  *	value.
  *
- *	BUGS: When used in a module (which arguably shouldnt happen)
+ *	BUGS: When used in a module (which arguably shouldn't happen)
  *	nothing prevents two IRQ probe callers from overlapping. The
  *	results of this are non-optimal.
  */
diff -ur a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	Mon Feb 24 11:05:29 2003
+++ b/arch/x86_64/kernel/irq.c	Tue Feb 25 09:53:05 2003
@@ -684,7 +684,7 @@
  *	The interrupt probe logic state is returned to its previous
  *	value.
  *
- *	BUGS: When used in a module (which arguably shouldnt happen)
+ *	BUGS: When used in a module (which arguably shouldn't happen)
  *	nothing prevents two IRQ probe callers from overlapping. The
  *	results of this are non-optimal.
  */
diff -ur a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Mon Feb 24 11:05:29 2003
+++ b/drivers/ide/ide-disk.c	Tue Feb 25 09:53:11 2003
@@ -68,7 +68,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-/* FIXME: some day we shouldnt need to look in here! */
+/* FIXME: some day we shouldn't need to look in here! */
 
 #include "legacy/pdc4030.h"
 
diff -ur a/drivers/net/wan/z85230.c b/drivers/net/wan/z85230.c
--- a/drivers/net/wan/z85230.c	Mon Feb 24 11:05:05 2003
+++ b/drivers/net/wan/z85230.c	Tue Feb 25 09:53:14 2003
@@ -549,7 +549,7 @@
 		z8530_tx(chan);
 		return;
 	}
-	/* This shouldnt occur in DMA mode */
+	/* This shouldn't occur in DMA mode */
 	printk(KERN_ERR "DMA tx - bogus event!\n");
 	z8530_tx(chan);
 }
diff -ur a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
--- a/drivers/scsi/aic7xxx_old.c	Mon Feb 24 11:05:17 2003
+++ b/drivers/scsi/aic7xxx_old.c	Tue Feb 25 09:53:18 2003
@@ -4094,7 +4094,7 @@
             aic_dev->max_q_depth = aic_dev->temp_q_depth = 1;
             /*
              * We set this command up as a bus device reset.  However, we have
-             * to clear the tag type as it's causing us problems.  We shouldnt
+             * to clear the tag type as it's causing us problems.  We shouldn't
              * have to worry about any other commands being active, since if
              * the device is refusing tagged commands, this should be the
              * first tagged command sent to the device, however, we do have
diff -ur a/drivers/scsi/sym53c416.c b/drivers/scsi/sym53c416.c
--- a/drivers/scsi/sym53c416.c	Mon Feb 24 11:05:10 2003
+++ b/drivers/scsi/sym53c416.c	Tue Feb 25 09:53:20 2003
@@ -820,7 +820,7 @@
 
 	/* printk("sym53c416_reset\n"); */
 	base = SCpnt->device->host->io_port;
-	/* search scsi_id - fixme, we shouldnt need to iterate for this! */
+	/* search scsi_id - fixme, we shouldn't need to iterate for this! */
 	for(i = 0; i < host_index && scsi_id != -1; i++)
 		if(hosts[i].base == base)
 			scsi_id = hosts[i].scsi_id;
diff -ur a/include/asm-m68k/macintosh.h b/include/asm-m68k/macintosh.h
--- a/include/asm-m68k/macintosh.h	Mon Feb 24 11:05:04 2003
+++ b/include/asm-m68k/macintosh.h	Tue Feb 25 09:53:23 2003
@@ -27,7 +27,7 @@
 extern void mac_boom(int);
 
 /*
- *	Floppy driver magic hook - probably shouldnt be here
+ *	Floppy driver magic hook - probably shouldn't be here
  */
  
 extern void via1_set_head(int);
diff -ur a/sound/pci/trident/trident_synth.c b/sound/pci/trident/trident_synth.c
--- a/sound/pci/trident/trident_synth.c	Mon Feb 24 11:05:17 2003
+++ b/sound/pci/trident/trident_synth.c	Tue Feb 25 09:53:26 2003
@@ -600,7 +600,7 @@
 		size <<= 1;
 
 	trident->synth.current_size -= size;
-	if (trident->synth.current_size < 0)	/* shouldnt need this check... */
+	if (trident->synth.current_size < 0)	/* shouldn't need this check... */
 		trident->synth.current_size = 0;
 
 	return 0;
