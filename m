Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTBYD3V>; Mon, 24 Feb 2003 22:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbTBYD1z>; Mon, 24 Feb 2003 22:27:55 -0500
Received: from [24.77.48.240] ([24.77.48.240]:29027 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S265423AbTBYD1Z>;
	Mon, 24 Feb 2003 22:27:25 -0500
Date: Mon, 24 Feb 2003 19:37:45 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302250337.h1P3bj732722@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - occurring
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling fixes for 2.5.63:

This patch fixes:
    occuring -> occurring

Fixes 29 occurrences in all.

diff -ur 2.5.63a/arch/arm/mach-iop310/iop310-pci.c 2.5.63b/arch/arm/mach-iop310/iop310-pci.c
--- 2.5.63a/arch/arm/mach-iop310/iop310-pci.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/arch/arm/mach-iop310/iop310-pci.c	Mon Feb 24 18:09:27 2003
@@ -296,7 +296,7 @@
  *  within 3 instructions."
  *
  * This does not appear to be the case.  With 8 NOPs after the load, we
- * see the imprecise abort occuring on the STM of iop310_sec_pci_status()
+ * see the imprecise abort occurring on the STM of iop310_sec_pci_status()
  * which is about 10 instructions away.
  *
  * Always trust reality!
diff -ur 2.5.63a/arch/ia64/sn/io/sn1/pcibr.c 2.5.63b/arch/ia64/sn/io/sn1/pcibr.c
--- 2.5.63a/arch/ia64/sn/io/sn1/pcibr.c	Mon Feb 24 11:05:36 2003
+++ 2.5.63b/arch/ia64/sn/io/sn1/pcibr.c	Mon Feb 24 18:09:31 2003
@@ -5113,7 +5113,7 @@
 
     /* Bridge Hardware Bug WAR #484930:
      * Bridge can't handle updating External ATEs
-     * while DMA is occuring that uses External ATEs,
+     * while DMA is occurring that uses External ATEs,
      * even if the particular ATEs involved are disjoint.
      */
 
@@ -6844,7 +6844,7 @@
  *
  * This is the pcibr interrupt "wrapper" function that is called,
  * in interrupt context, to initiate the interrupt handler(s) registered
- * (via pcibr_intr_alloc/connect) for the occuring interrupt. Non-threaded 
+ * (via pcibr_intr_alloc/connect) for the occurring interrupt. Non-threaded 
  * handlers will be called directly, and threaded handlers will have their 
  * thread woken up.
  */
diff -ur 2.5.63a/arch/ia64/sn/io/sn2/pcibr/pcibr_ate.c 2.5.63b/arch/ia64/sn/io/sn2/pcibr/pcibr_ate.c
--- 2.5.63a/arch/ia64/sn/io/sn2/pcibr/pcibr_ate.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/arch/ia64/sn/io/sn2/pcibr/pcibr_ate.c	Mon Feb 24 18:09:33 2003
@@ -362,7 +362,7 @@
 
     /* Bridge Hardware Bug WAR #484930:
      * Bridge can't handle updating External ATEs
-     * while DMA is occuring that uses External ATEs,
+     * while DMA is occurring that uses External ATEs,
      * even if the particular ATEs involved are disjoint.
      */
 
diff -ur 2.5.63a/arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c 2.5.63b/arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c
--- 2.5.63a/arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c	Mon Feb 24 18:09:35 2003
@@ -842,7 +842,7 @@
  *
  * This is the pcibr interrupt "wrapper" function that is called,
  * in interrupt context, to initiate the interrupt handler(s) registered
- * (via pcibr_intr_alloc/connect) for the occuring interrupt. Non-threaded 
+ * (via pcibr_intr_alloc/connect) for the occurring interrupt. Non-threaded 
  * handlers will be called directly, and threaded handlers will have their 
  * thread woken up.
  */
diff -ur 2.5.63a/arch/parisc/kernel/perf_images.h 2.5.63b/arch/parisc/kernel/perf_images.h
--- 2.5.63a/arch/parisc/kernel/perf_images.h	Mon Feb 24 11:05:09 2003
+++ 2.5.63b/arch/parisc/kernel/perf_images.h	Mon Feb 24 18:09:38 2003
@@ -1556,7 +1556,7 @@
  * IRTN_AV fires twice for every I-cache miss returning from RIB to the IFU.
  * It will not fire if a second I-cache miss is issued from the IFU to RIB
  * before the first returns.  Therefore, if the IRTN_AV count is much less
- * than 2x the ICORE_AV count, many speculative I-cache misses are occuring
+ * than 2x the ICORE_AV count, many speculative I-cache misses are occurring
  * which are "discovered" to be incorrect fairly quickly.
  * The ratio of I-cache miss transactions on Runway to the ICORE_AV count is
  * a measure of the effectiveness of instruction prefetching.  This ratio
diff -ur 2.5.63a/drivers/acpi/events/evevent.c 2.5.63b/drivers/acpi/events/evevent.c
--- 2.5.63a/drivers/acpi/events/evevent.c	Mon Feb 24 11:05:41 2003
+++ 2.5.63b/drivers/acpi/events/evevent.c	Mon Feb 24 18:09:40 2003
@@ -79,7 +79,7 @@
 
 	/*
 	 * Initialize the Fixed and General Purpose acpi_events prior. This is
-	 * done prior to enabling SCIs to prevent interrupts from occuring
+	 * done prior to enabling SCIs to prevent interrupts from occurring
 	 * before handers are installed.
 	 */
 	status = acpi_ev_fixed_event_initialize ();
diff -ur 2.5.63a/drivers/char/epca.c 2.5.63b/drivers/char/epca.c
--- 2.5.63a/drivers/char/epca.c	Mon Feb 24 11:05:34 2003
+++ 2.5.63b/drivers/char/epca.c	Mon Feb 24 18:09:42 2003
@@ -897,7 +897,7 @@
 					Remember copy_from_user WILL generate a page fault if the
 					user memory being accessed has been swapped out.  This can
 					cause this routine to temporarily sleep while this page
-					fault is occuring.
+					fault is occurring.
 				
 				----------------------------------------------------------------- */
 
diff -ur 2.5.63a/drivers/char/watchdog/sbc60xxwdt.c 2.5.63b/drivers/char/watchdog/sbc60xxwdt.c
--- 2.5.63a/drivers/char/watchdog/sbc60xxwdt.c	Mon Feb 24 11:05:37 2003
+++ 2.5.63b/drivers/char/watchdog/sbc60xxwdt.c	Mon Feb 24 18:09:44 2003
@@ -50,7 +50,7 @@
  *
  *  Why `V' ?  Well, `V' is the character in ASCII for the value 86,
  *  and we all know that 86 is _the_ most random number in the universe.
- *  Therefore it is the letter that has the slightest chance of occuring
+ *  Therefore it is the letter that has the slightest chance of occurring
  *  by chance, when the system becomes corrupted.
  *
  */
diff -ur 2.5.63a/drivers/char/watchdog/wdt.c 2.5.63b/drivers/char/watchdog/wdt.c
--- 2.5.63a/drivers/char/watchdog/wdt.c	Mon Feb 24 11:05:32 2003
+++ 2.5.63b/drivers/char/watchdog/wdt.c	Mon Feb 24 18:09:47 2003
@@ -175,7 +175,7 @@
  *
  *	Handle an interrupt from the board. These are raised when the status
  *	map changes in what the board considers an interesting way. That means
- *	a failure condition occuring.
+ *	a failure condition occurring.
  */
  
 void wdt_interrupt(int irq, void *dev_id, struct pt_regs *regs)
diff -ur 2.5.63a/drivers/char/watchdog/wdt_pci.c 2.5.63b/drivers/char/watchdog/wdt_pci.c
--- 2.5.63a/drivers/char/watchdog/wdt_pci.c	Mon Feb 24 11:05:35 2003
+++ 2.5.63b/drivers/char/watchdog/wdt_pci.c	Mon Feb 24 18:09:49 2003
@@ -158,7 +158,7 @@
  *
  *	Handle an interrupt from the board. These are raised when the status
  *	map changes in what the board considers an interesting way. That means
- *	a failure condition occuring.
+ *	a failure condition occurring.
  */
  
 static void wdtpci_interrupt(int irq, void *dev_id, struct pt_regs *regs)
diff -ur 2.5.63a/drivers/macintosh/via-pmu.c 2.5.63b/drivers/macintosh/via-pmu.c
--- 2.5.63a/drivers/macintosh/via-pmu.c	Mon Feb 24 11:05:43 2003
+++ 2.5.63b/drivers/macintosh/via-pmu.c	Mon Feb 24 18:09:53 2003
@@ -2066,7 +2066,7 @@
 
 	/* Make sure the decrementer won't interrupt us */
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-	/* Make sure any pending DEC interrupt occuring while we did
+	/* Make sure any pending DEC interrupt occurring while we did
 	 * the above didn't re-enable the DEC */
 	mb();
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
@@ -2211,7 +2211,7 @@
 
 	/* Make sure the decrementer won't interrupt us */
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-	/* Make sure any pending DEC interrupt occuring while we did
+	/* Make sure any pending DEC interrupt occurring while we did
 	 * the above didn't re-enable the DEC */
 	mb();
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
@@ -2376,7 +2376,7 @@
 
 	/* Make sure the decrementer won't interrupt us */
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-	/* Make sure any pending DEC interrupt occuring while we did
+	/* Make sure any pending DEC interrupt occurring while we did
 	 * the above didn't re-enable the DEC */
 	mb();
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
diff -ur 2.5.63a/drivers/net/wan/sdla_fr.c 2.5.63b/drivers/net/wan/sdla_fr.c
--- 2.5.63a/drivers/net/wan/sdla_fr.c	Mon Feb 24 11:06:01 2003
+++ 2.5.63b/drivers/net/wan/sdla_fr.c	Mon Feb 24 18:09:55 2003
@@ -107,7 +107,7 @@
 *                                  the if clause for it(0,dev->tbusy) 
 *				   forever.
 *				   The code got into this stage due to an 
-*				   interrupt occuring within the if clause for 
+*				   interrupt occurring within the if clause for 
 *				   set_bit(0,dev->tbusy).  Since an interrupt 
 *				   disables furhter transmit interrupt and 
 * 				   makes dev->tbusy = 0, this effect was undone 
diff -ur 2.5.63a/drivers/scsi/NCR53C9x.c 2.5.63b/drivers/scsi/NCR53C9x.c
--- 2.5.63a/drivers/scsi/NCR53C9x.c	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/drivers/scsi/NCR53C9x.c	Mon Feb 24 18:09:58 2003
@@ -2942,7 +2942,7 @@
 /* Target negotiates for synchronous transfers before we do, this
  * is legal although very strange.  What is even funnier is that
  * the SCSI2 standard specifically recommends against targets doing
- * this because so many initiators cannot cope with this occuring.
+ * this because so many initiators cannot cope with this occurring.
  */
 static int target_with_ants_in_pants(struct NCR_ESP *esp,
 				     Scsi_Cmnd *SCptr,
diff -ur 2.5.63a/drivers/scsi/esp.c 2.5.63b/drivers/scsi/esp.c
--- 2.5.63a/drivers/scsi/esp.c	Mon Feb 24 11:06:01 2003
+++ 2.5.63b/drivers/scsi/esp.c	Mon Feb 24 18:10:00 2003
@@ -3567,7 +3567,7 @@
 /* Target negotiates for synchronous transfers before we do, this
  * is legal although very strange.  What is even funnier is that
  * the SCSI2 standard specifically recommends against targets doing
- * this because so many initiators cannot cope with this occuring.
+ * this because so many initiators cannot cope with this occurring.
  */
 static int target_with_ants_in_pants(struct esp *esp,
 				     Scsi_Cmnd *SCptr,
diff -ur 2.5.63a/drivers/scsi/sym53c8xx.c 2.5.63b/drivers/scsi/sym53c8xx.c
--- 2.5.63a/drivers/scsi/sym53c8xx.c	Mon Feb 24 11:05:36 2003
+++ 2.5.63b/drivers/scsi/sym53c8xx.c	Mon Feb 24 18:10:02 2003
@@ -3653,7 +3653,7 @@
 	**	some target to reset or some disconnected 
 	**	job to abort. Since error recovery is a serious 
 	**	busyness, we will really reset the SCSI BUS, if 
-	**	case of a SCSI interrupt occuring in this path.
+	**	case of a SCSI interrupt occurring in this path.
 	*/
 
 	/*
diff -ur 2.5.63a/drivers/scsi/sym53c8xx_2/sym_fw1.h 2.5.63b/drivers/scsi/sym53c8xx_2/sym_fw1.h
--- 2.5.63a/drivers/scsi/sym53c8xx_2/sym_fw1.h	Mon Feb 24 11:05:39 2003
+++ 2.5.63b/drivers/scsi/sym53c8xx_2/sym_fw1.h	Mon Feb 24 18:10:04 2003
@@ -1361,7 +1361,7 @@
 	 *  some target to reset or some disconnected 
 	 *  job to abort. Since error recovery is a serious 
 	 *  busyness, we will really reset the SCSI BUS, if 
-	 *  case of a SCSI interrupt occuring in this path.
+	 *  case of a SCSI interrupt occurring in this path.
 	 */
 
 #ifdef SYM_CONF_TARGET_ROLE_SUPPORT
diff -ur 2.5.63a/drivers/scsi/sym53c8xx_2/sym_fw2.h 2.5.63b/drivers/scsi/sym53c8xx_2/sym_fw2.h
--- 2.5.63a/drivers/scsi/sym53c8xx_2/sym_fw2.h	Mon Feb 24 11:05:42 2003
+++ 2.5.63b/drivers/scsi/sym53c8xx_2/sym_fw2.h	Mon Feb 24 18:10:06 2003
@@ -1246,7 +1246,7 @@
 	 *  some target to reset or some disconnected 
 	 *  job to abort. Since error recovery is a serious 
 	 *  busyness, we will really reset the SCSI BUS, if 
-	 *  case of a SCSI interrupt occuring in this path.
+	 *  case of a SCSI interrupt occurring in this path.
 	 */
 #ifdef SYM_CONF_TARGET_ROLE_SUPPORT
 	/*
diff -ur 2.5.63a/drivers/serial/8250.c 2.5.63b/drivers/serial/8250.c
--- 2.5.63a/drivers/serial/8250.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/drivers/serial/8250.c	Mon Feb 24 18:10:08 2003
@@ -1241,7 +1241,7 @@
 
 	/*
 	 * Finally, enable interrupts.  Note: Modem status interrupts
-	 * are set via set_termios(), which will be occuring imminently
+	 * are set via set_termios(), which will be occurring imminently
 	 * anyway, so we don't enable them here.
 	 */
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
diff -ur 2.5.63a/drivers/serial/sunsu.c 2.5.63b/drivers/serial/sunsu.c
--- 2.5.63a/drivers/serial/sunsu.c	Mon Feb 24 11:05:11 2003
+++ 2.5.63b/drivers/serial/sunsu.c	Mon Feb 24 18:10:10 2003
@@ -713,7 +713,7 @@
 
 	/*
 	 * Finally, enable interrupts.  Note: Modem status interrupts
-	 * are set via set_termios(), which will be occuring imminently
+	 * are set via set_termios(), which will be occurring imminently
 	 * anyway, so we don't enable them here.
 	 */
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
diff -ur 2.5.63a/fs/reiserfs/do_balan.c 2.5.63b/fs/reiserfs/do_balan.c
--- 2.5.63a/fs/reiserfs/do_balan.c	Mon Feb 24 11:05:10 2003
+++ 2.5.63b/fs/reiserfs/do_balan.c	Mon Feb 24 18:10:13 2003
@@ -1381,7 +1381,7 @@
   if ( cur_tb ) {
     reiserfs_panic (tb->tb_sb, "vs-12335: check_before_balancing: "
 		    "suspect that schedule occurred based on cur_tb not being null at this point in code. "
-		    "do_balance cannot properly handle schedule occuring while it runs.");
+		    "do_balance cannot properly handle schedule occurring while it runs.");
   }
   
   /* double check that buffers that we will modify are unlocked. (fix_nodes should already have
diff -ur 2.5.63a/fs/reiserfs/journal.c 2.5.63b/fs/reiserfs/journal.c
--- 2.5.63a/fs/reiserfs/journal.c	Mon Feb 24 11:05:34 2003
+++ 2.5.63b/fs/reiserfs/journal.c	Mon Feb 24 18:10:15 2003
@@ -2523,7 +2523,7 @@
 ** haven't hit disk yet.  called from bitmap.c
 **
 ** if it starts flushing things, it ors SCHEDULE_OCCURRED into repeat.
-** note, this is just if schedule has a chance of occuring.  I need to 
+** note, this is just if schedule has a chance of occurring.  I need to 
 ** change flush_commit_lists to have a repeat parameter too.
 **
 */
diff -ur 2.5.63a/fs/reiserfs/stree.c 2.5.63b/fs/reiserfs/stree.c
--- 2.5.63a/fs/reiserfs/stree.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/fs/reiserfs/stree.c	Mon Feb 24 18:10:17 2003
@@ -1495,7 +1495,7 @@
 
 
     /* Repeat this loop until we either cut the item without needing
-       to balance, or we fix_nodes without schedule occuring */
+       to balance, or we fix_nodes without schedule occurring */
     while ( 1 ) {
 	/* Determine the balance mode, position of the first byte to
 	   be cut, and size to be cut.  In case of the indirect item
diff -ur 2.5.63a/include/asm-cris/processor.h 2.5.63b/include/asm-cris/processor.h
--- 2.5.63a/include/asm-cris/processor.h	Mon Feb 24 11:05:32 2003
+++ 2.5.63b/include/asm-cris/processor.h	Mon Feb 24 18:10:20 2003
@@ -65,7 +65,7 @@
 /*
  * At user->kernel entry, the pt_regs struct is stacked on the top of the kernel-stack.
  * This macro allows us to find those regs for a task.
- * Notice that subsequent pt_regs stackings, like recursive interrupts occuring while
+ * Notice that subsequent pt_regs stackings, like recursive interrupts occurring while
  * we're in the kernel, won't affect this - only the first user->kernel transition
  * registers are reached by this.
  */
diff -ur 2.5.63a/kernel/pm.c 2.5.63b/kernel/pm.c
--- 2.5.63a/kernel/pm.c	Mon Feb 24 11:05:11 2003
+++ 2.5.63b/kernel/pm.c	Mon Feb 24 18:10:24 2003
@@ -141,7 +141,7 @@
  *	data field must hold the intended next state. No call is made
  *	if the state matches.
  *
- *	BUGS: what stops two power management requests occuring in parallel
+ *	BUGS: what stops two power management requests occurring in parallel
  *	and conflicting.
  *
  *	WARNING: Calling pm_send directly is not generally recommended, in
@@ -227,7 +227,7 @@
  *	Zero is returned on success. If a suspend fails then the status
  *	from the device that vetoes the suspend is returned.
  *
- *	BUGS: what stops two power management requests occuring in parallel
+ *	BUGS: what stops two power management requests occurring in parallel
  *	and conflicting.
  */
  
diff -ur 2.5.63a/net/sctp/sm_statefuns.c 2.5.63b/net/sctp/sm_statefuns.c
--- 2.5.63a/net/sctp/sm_statefuns.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/net/sctp/sm_statefuns.c	Mon Feb 24 18:10:27 2003
@@ -939,7 +939,7 @@
 	return 0;
 }
 
-/* A restart is occuring, check to make sure no new addresses
+/* A restart is occurring, check to make sure no new addresses
  * are being added as we may be under a takeover attack.
  */
 static int sctp_sf_check_restart_addrs(const sctp_association_t *new_asoc,
