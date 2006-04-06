Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWDFITV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWDFITV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 04:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWDFITV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 04:19:21 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:57260 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932143AbWDFITU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 04:19:20 -0400
Date: Thu, 6 Apr 2006 10:19:14 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] trivial: spelling (2.6.17-rc1)
Message-ID: <20060406081914.GA11619@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

patch against 2.6.17-rc1:

acquired (aquired)
contiguous (contigious)
successful (succesful, succesfull)
surprise (suprise)
whether (weather)
some other misspellings

k/M/Gb -> k/M/GB (bits vs. Bytes)

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc1.orig/arch/i386/kernel/cpu/cyrix.c linux-2.6.17-rc1/arch/i386/kernel/cpu/cyrix.c
--- linux-2.6.17-rc1.orig/arch/i386/kernel/cpu/cyrix.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/arch/i386/kernel/cpu/cyrix.c	2006-04-06 09:47:43.000000000 +0200
@@ -353,7 +353,7 @@
 	 * This function only handles the GX processor, and kicks every
 	 * thing else to the Cyrix init function above - that should
 	 * cover any processors that might have been branded differently
-	 * after NSC aquired Cyrix.
+	 * after NSC acquired Cyrix.
 	 *
 	 * If this breaks your GX1 horribly, please e-mail
 	 * info-linux@ldcmail.amd.com to tell us.
diff -urN linux-2.6.17-rc1.orig/arch/i386/kernel/i8259.c linux-2.6.17-rc1/arch/i386/kernel/i8259.c
--- linux-2.6.17-rc1.orig/arch/i386/kernel/i8259.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/arch/i386/kernel/i8259.c	2006-04-06 09:47:43.000000000 +0200
@@ -175,7 +175,7 @@
 	 * Lightweight spurious IRQ detection. We do not want
 	 * to overdo spurious IRQ handling - it's usually a sign
 	 * of hardware problems, so we only do the checks we can
-	 * do without slowing down good hardware unnecesserily.
+	 * do without slowing down good hardware unnecessarily.
 	 *
 	 * Note that IRQ7 and IRQ15 (the two spurious IRQs
 	 * usually resulting from the 8259A-1|2 PICs) occur
diff -urN linux-2.6.17-rc1.orig/arch/mips/momentum/ocelot_g/gt-irq.c linux-2.6.17-rc1/arch/mips/momentum/ocelot_g/gt-irq.c
--- linux-2.6.17-rc1.orig/arch/mips/momentum/ocelot_g/gt-irq.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/arch/mips/momentum/ocelot_g/gt-irq.c	2006-04-06 09:47:43.000000000 +0200
@@ -59,7 +59,7 @@
  * bit_num   - Indicates which bit number in the cause register
  *
  * Outputs :
- * 1 if succesful, 0 if failure
+ * 1 if successful, 0 if failure
  */
 int enable_galileo_irq(int int_cause, int bit_num)
 {
@@ -83,7 +83,7 @@
  * bit_num   - Indicates which bit number in the cause register
  *
  * Outputs :
- * 1 if succesful, 0 if failure
+ * 1 if successful, 0 if failure
  */
 int disable_galileo_irq(int int_cause, int bit_num)
 {
diff -urN linux-2.6.17-rc1.orig/arch/powerpc/platforms/cell/spufs/switch.c linux-2.6.17-rc1/arch/powerpc/platforms/cell/spufs/switch.c
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/cell/spufs/switch.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/arch/powerpc/platforms/cell/spufs/switch.c	2006-04-06 09:47:43.000000000 +0200
@@ -2081,7 +2081,7 @@
  * @spu: pointer to SPU iomem structure.
  *
  * Perform harvest + restore, as we may not be coming
- * from a previous succesful save operation, and the
+ * from a previous successful save operation, and the
  * hardware state is unknown.
  */
 int spu_restore(struct spu_state *new, struct spu *spu)
diff -urN linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh_cache.c linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_cache.c
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_cache.c	2006-04-06 09:47:43.000000000 +0200
@@ -287,7 +287,7 @@
  * find the pci device that corresponds to a given address.
  * This routine scans all pci busses to build the cache.
  * Must be run late in boot process, after the pci controllers
- * have been scaned for devices (after all device resources are known).
+ * have been scanned for devices (after all device resources are known).
  */
 void __init pci_addr_cache_build(void)
 {
diff -urN linux-2.6.17-rc1.orig/arch/s390/kernel/vtime.c linux-2.6.17-rc1/arch/s390/kernel/vtime.c
--- linux-2.6.17-rc1.orig/arch/s390/kernel/vtime.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/arch/s390/kernel/vtime.c	2006-04-06 09:47:43.000000000 +0200
@@ -356,7 +356,7 @@
 
 	set_vtimer(event->expires);
 	spin_unlock_irqrestore(&vt_list->lock, flags);
-	/* release CPU aquired in prepare_vtimer or mod_virt_timer() */
+	/* release CPU acquired in prepare_vtimer or mod_virt_timer() */
 	put_cpu();
 }
 
diff -urN linux-2.6.17-rc1.orig/arch/um/drivers/ubd_kern.c linux-2.6.17-rc1/arch/um/drivers/ubd_kern.c
--- linux-2.6.17-rc1.orig/arch/um/drivers/ubd_kern.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/arch/um/drivers/ubd_kern.c	2006-04-06 09:47:43.000000000 +0200
@@ -1222,7 +1222,7 @@
 		}
 	}
 
-	/* Succesful return case! */
+	/* Successful return case! */
 	if(backing_file_out == NULL)
 		return(fd);
 
diff -urN linux-2.6.17-rc1.orig/arch/x86_64/kernel/i8259.c linux-2.6.17-rc1/arch/x86_64/kernel/i8259.c
--- linux-2.6.17-rc1.orig/arch/x86_64/kernel/i8259.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/arch/x86_64/kernel/i8259.c	2006-04-06 09:47:43.000000000 +0200
@@ -278,7 +278,7 @@
 	 * Lightweight spurious IRQ detection. We do not want
 	 * to overdo spurious IRQ handling - it's usually a sign
 	 * of hardware problems, so we only do the checks we can
-	 * do without slowing down good hardware unnecesserily.
+	 * do without slowing down good hardware unnecessarily.
 	 *
 	 * Note that IRQ7 and IRQ15 (the two spurious IRQs
 	 * usually resulting from the 8259A-1|2 PICs) occur
diff -urN linux-2.6.17-rc1.orig/block/as-iosched.c linux-2.6.17-rc1/block/as-iosched.c
--- linux-2.6.17-rc1.orig/block/as-iosched.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/block/as-iosched.c	2006-04-06 09:47:43.000000000 +0200
@@ -902,7 +902,7 @@
 }
 
 /*
- * as_can_anticipate indicates weather we should either run arq
+ * as_can_anticipate indicates whether we should either run arq
  * or keep anticipating a better request.
  */
 static int as_can_anticipate(struct as_data *ad, struct as_rq *arq)
diff -urN linux-2.6.17-rc1.orig/block/ll_rw_blk.c linux-2.6.17-rc1/block/ll_rw_blk.c
--- linux-2.6.17-rc1.orig/block/ll_rw_blk.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/block/ll_rw_blk.c	2006-04-06 09:47:43.000000000 +0200
@@ -2729,7 +2729,7 @@
 		return 0;
 
 	/*
-	 * not contigious
+	 * not contiguous
 	 */
 	if (req->sector + req->nr_sectors != next->sector)
 		return 0;
@@ -3397,7 +3397,7 @@
  *
  * Description:
  *     Ends all I/O on a request. It does not handle partial completions,
- *     unless the driver actually implements this in its completionc callback
+ *     unless the driver actually implements this in its completion callback
  *     through requeueing. Theh actual completion happens out-of-order,
  *     through a softirq handler. The user must have registered a completion
  *     callback through blk_queue_softirq_done().
diff -urN linux-2.6.17-rc1.orig/drivers/atm/firestream.c linux-2.6.17-rc1/drivers/atm/firestream.c
--- linux-2.6.17-rc1.orig/drivers/atm/firestream.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/atm/firestream.c	2006-04-06 09:47:43.000000000 +0200
@@ -951,7 +951,7 @@
 		   it most likely that the chip will notice it. It also prevents us
 		   from having to wait for completion. On the other hand, we may
 		   need to wait for completion anyway, to see if it completed
-		   succesfully. */
+		   successfully. */
 
 		switch (atm_vcc->qos.aal) {
 		case ATM_AAL2:
diff -urN linux-2.6.17-rc1.orig/drivers/char/agp/amd-k7-agp.c linux-2.6.17-rc1/drivers/char/agp/amd-k7-agp.c
--- linux-2.6.17-rc1.orig/drivers/char/agp/amd-k7-agp.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/char/agp/amd-k7-agp.c	2006-04-06 09:47:43.000000000 +0200
@@ -118,7 +118,7 @@
 	return retval;
 }
 
-/* Since we don't need contigious memory we just try
+/* Since we don't need contiguous memory we just try
  * to get the gatt table once
  */
 
diff -urN linux-2.6.17-rc1.orig/drivers/char/agp/ati-agp.c linux-2.6.17-rc1/drivers/char/agp/ati-agp.c
--- linux-2.6.17-rc1.orig/drivers/char/agp/ati-agp.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/char/agp/ati-agp.c	2006-04-06 09:47:43.000000000 +0200
@@ -261,7 +261,7 @@
 #endif
 
 /*
- *Since we don't need contigious memory we just try
+ *Since we don't need contiguous memory we just try
  * to get the gatt table once
  */
 
diff -urN linux-2.6.17-rc1.orig/drivers/char/agp/efficeon-agp.c linux-2.6.17-rc1/drivers/char/agp/efficeon-agp.c
--- linux-2.6.17-rc1.orig/drivers/char/agp/efficeon-agp.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/char/agp/efficeon-agp.c	2006-04-06 09:47:43.000000000 +0200
@@ -171,7 +171,7 @@
 
 
 /*
- * Since we don't need contigious memory we just try
+ * Since we don't need contiguous memory we just try
  * to get the gatt table once
  */
 
diff -urN linux-2.6.17-rc1.orig/drivers/char/rio/riointr.c linux-2.6.17-rc1/drivers/char/rio/riointr.c
--- linux-2.6.17-rc1.orig/drivers/char/rio/riointr.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/char/rio/riointr.c	2006-04-06 09:47:43.000000000 +0200
@@ -546,7 +546,7 @@
 	 ** run out of space it will be set to the offset of the
 	 ** next byte to copy from the packet data area. The packet
 	 ** length field is decremented by the number of bytes that
-	 ** we succesfully removed from the packet. When this reaches
+	 ** we successfully removed from the packet. When this reaches
 	 ** zero, we reset the offset pointer to be zero, and free
 	 ** the packet from the front of the queue.
 	 */
diff -urN linux-2.6.17-rc1.orig/drivers/hwmon/asb100.c linux-2.6.17-rc1/drivers/hwmon/asb100.c
--- linux-2.6.17-rc1.orig/drivers/hwmon/asb100.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/asb100.c	2006-04-06 09:47:43.000000000 +0200
@@ -341,7 +341,7 @@
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 				size_t count, int nr)
diff -urN linux-2.6.17-rc1.orig/drivers/hwmon/lm78.c linux-2.6.17-rc1/drivers/hwmon/lm78.c
--- linux-2.6.17-rc1.orig/drivers/hwmon/lm78.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/lm78.c	2006-04-06 09:47:43.000000000 +0200
@@ -358,7 +358,7 @@
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 	size_t count, int nr)
diff -urN linux-2.6.17-rc1.orig/drivers/hwmon/lm80.c linux-2.6.17-rc1/drivers/hwmon/lm80.c
--- linux-2.6.17-rc1.orig/drivers/hwmon/lm80.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/lm80.c	2006-04-06 09:47:43.000000000 +0200
@@ -253,7 +253,7 @@
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 	size_t count, int nr)
diff -urN linux-2.6.17-rc1.orig/drivers/hwmon/lm87.c linux-2.6.17-rc1/drivers/hwmon/lm87.c
--- linux-2.6.17-rc1.orig/drivers/hwmon/lm87.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/lm87.c	2006-04-06 09:47:43.000000000 +0200
@@ -421,7 +421,7 @@
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan clock divider.  This follows the principle
-   of least suprise; the user doesn't expect the fan minimum to change just
+   of least surprise; the user doesn't expect the fan minimum to change just
    because the divider changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 		size_t count, int nr)
diff -urN linux-2.6.17-rc1.orig/drivers/hwmon/sis5595.c linux-2.6.17-rc1/drivers/hwmon/sis5595.c
--- linux-2.6.17-rc1.orig/drivers/hwmon/sis5595.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/sis5595.c	2006-04-06 09:47:43.000000000 +0200
@@ -380,7 +380,7 @@
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 	size_t count, int nr)
diff -urN linux-2.6.17-rc1.orig/drivers/hwmon/smsc47m1.c linux-2.6.17-rc1/drivers/hwmon/smsc47m1.c
--- linux-2.6.17-rc1.orig/drivers/hwmon/smsc47m1.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/smsc47m1.c	2006-04-06 09:47:43.000000000 +0200
@@ -207,7 +207,7 @@
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan clock divider.  This follows the principle
-   of least suprise; the user doesn't expect the fan minimum to change just
+   of least surprise; the user doesn't expect the fan minimum to change just
    because the divider changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 		size_t count, int nr)
diff -urN linux-2.6.17-rc1.orig/drivers/hwmon/w83627hf.c linux-2.6.17-rc1/drivers/hwmon/w83627hf.c
--- linux-2.6.17-rc1.orig/drivers/hwmon/w83627hf.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/w83627hf.c	2006-04-06 09:47:43.000000000 +0200
@@ -781,7 +781,7 @@
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t
 store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
diff -urN linux-2.6.17-rc1.orig/drivers/hwmon/w83781d.c linux-2.6.17-rc1/drivers/hwmon/w83781d.c
--- linux-2.6.17-rc1.orig/drivers/hwmon/w83781d.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/w83781d.c	2006-04-06 09:47:43.000000000 +0200
@@ -630,7 +630,7 @@
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t
 store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
diff -urN linux-2.6.17-rc1.orig/drivers/hwmon/w83792d.c linux-2.6.17-rc1/drivers/hwmon/w83792d.c
--- linux-2.6.17-rc1.orig/drivers/hwmon/w83792d.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/w83792d.c	2006-04-06 09:47:43.000000000 +0200
@@ -462,7 +462,7 @@
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t
 store_fan_div(struct device *dev, struct device_attribute *attr,
diff -urN linux-2.6.17-rc1.orig/drivers/ide/ide-disk.c linux-2.6.17-rc1/drivers/ide/ide-disk.c
--- linux-2.6.17-rc1.orig/drivers/ide/ide-disk.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/ide/ide-disk.c	2006-04-06 09:47:43.000000000 +0200
@@ -37,7 +37,7 @@
  * Version 1.15		convert all calls to ide_raw_taskfile
  *				since args will return register content.
  * Version 1.16		added suspend-resume-checkpower
- * Version 1.17		do flush on standy, do flush on ATA < ATA6
+ * Version 1.17		do flush on standby, do flush on ATA < ATA6
  *			fix wcache setup.
  */
 
diff -urN linux-2.6.17-rc1.orig/drivers/ide/ide-io.c linux-2.6.17-rc1/drivers/ide/ide-io.c
--- linux-2.6.17-rc1.orig/drivers/ide/ide-io.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/ide/ide-io.c	2006-04-06 09:47:43.000000000 +0200
@@ -1595,7 +1595,7 @@
  *	Initialize a request before we fill it in and send it down to
  *	ide_do_drive_cmd. Commands must be set up by this function. Right
  *	now it doesn't do a lot, but if that changes abusers will have a
- *	nasty suprise.
+ *	nasty surprise.
  */
 
 void ide_init_drive_cmd (struct request *rq)
diff -urN linux-2.6.17-rc1.orig/drivers/ieee1394/hosts.c linux-2.6.17-rc1/drivers/ieee1394/hosts.c
--- linux-2.6.17-rc1.orig/drivers/ieee1394/hosts.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/ieee1394/hosts.c	2006-04-06 09:47:43.000000000 +0200
@@ -102,7 +102,7 @@
  * driver specific parts, enable the controller and make it available
  * to the general subsystem using hpsb_add_host().
  *
- * Return Value: a pointer to the &hpsb_host if succesful, %NULL if
+ * Return Value: a pointer to the &hpsb_host if successful, %NULL if
  * no memory was available.
  */
 static DECLARE_MUTEX(host_num_alloc);
diff -urN linux-2.6.17-rc1.orig/drivers/ieee1394/ieee1394_core.h linux-2.6.17-rc1/drivers/ieee1394/ieee1394_core.h
--- linux-2.6.17-rc1.orig/drivers/ieee1394/ieee1394_core.h	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/ieee1394/ieee1394_core.h	2006-04-06 09:47:43.000000000 +0200
@@ -139,7 +139,7 @@
 
 /*
  * Hand over received selfid packet to the core.  Complement check (second
- * quadlet is complement of first) is expected to be done and succesful.
+ * quadlet is complement of first) is expected to be done and successful.
  */
 void hpsb_selfid_received(struct hpsb_host *host, quadlet_t sid);
 
diff -urN linux-2.6.17-rc1.orig/drivers/isdn/divert/isdn_divert.c linux-2.6.17-rc1/drivers/isdn/divert/isdn_divert.c
--- linux-2.6.17-rc1.orig/drivers/isdn/divert/isdn_divert.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/isdn/divert/isdn_divert.c	2006-04-06 09:47:43.000000000 +0200
@@ -592,7 +592,7 @@
 } /* put_address */
 
 /*************************************/
-/* report a succesfull interrogation */
+/* report a successful interrogation */
 /*************************************/
 static int interrogate_success(isdn_ctrl *ic, struct call_struc *cs)
 { char *src = ic->parm.dss1_io.data;
diff -urN linux-2.6.17-rc1.orig/drivers/media/video/bt8xx/bttv-cards.c linux-2.6.17-rc1/drivers/media/video/bt8xx/bttv-cards.c
--- linux-2.6.17-rc1.orig/drivers/media/video/bt8xx/bttv-cards.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/media/video/bt8xx/bttv-cards.c	2006-04-06 09:48:34.000000000 +0200
@@ -4846,7 +4846,7 @@
  *
  * The IVC120G security card has 4 i2c controlled TDA8540 matrix
  * swichers to provide 16 channels to MUX0. The TDA8540's have
- * 4 indepedant outputs and as such the IVC120G also has the
+ * 4 independent outputs and as such the IVC120G also has the
  * optional "Monitor Out" bus. This allows the card to be looking
  * at one input while the monitor is looking at another.
  *
diff -urN linux-2.6.17-rc1.orig/drivers/mtd/nand/nand_base.c linux-2.6.17-rc1/drivers/mtd/nand/nand_base.c
--- linux-2.6.17-rc1.orig/drivers/mtd/nand/nand_base.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/mtd/nand/nand_base.c	2006-04-06 09:48:34.000000000 +0200
@@ -1023,7 +1023,7 @@
 					if (oobdata[idx] != oob_buf[oobofs + idx] ) {
 						DEBUG (MTD_DEBUG_LEVEL0,
 					       	"%s: Failed ECC write "
-						"verify, page 0x%08x, " "%6i bytes were succesful\n", __FUNCTION__, page, i);
+						"verify, page 0x%08x, " "%6i bytes were successful\n", __FUNCTION__, page, i);
 						goto out;
 					}
 				}
diff -urN linux-2.6.17-rc1.orig/drivers/net/3c501.c linux-2.6.17-rc1/drivers/net/3c501.c
--- linux-2.6.17-rc1.orig/drivers/net/3c501.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/net/3c501.c	2006-04-06 09:48:34.000000000 +0200
@@ -508,11 +508,11 @@
  * speak of. We simply pull the packet out of its PIO buffer (which is slow)
  * and queue it for the kernel. Then we reset the card for the next packet.
  *
- * We sometimes get suprise interrupts late both because the SMP IRQ delivery
+ * We sometimes get surprise interrupts late both because the SMP IRQ delivery
  * is message passing and because the card sometimes seems to deliver late. I
  * think if it is part way through a receive and the mode is changed it carries
  * on receiving and sends us an interrupt. We have to band aid all these cases
- * to get a sensible 150kbytes/second performance. Even then you want a small
+ * to get a sensible 150kBytes/second performance. Even then you want a small
  * TCP window.
  */
 
diff -urN linux-2.6.17-rc1.orig/drivers/net/irda/irport.c linux-2.6.17-rc1/drivers/net/irda/irport.c
--- linux-2.6.17-rc1.orig/drivers/net/irda/irport.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/net/irda/irport.c	2006-04-06 09:48:34.000000000 +0200
@@ -386,7 +386,7 @@
 	/* Locking notes : this function may be called from irq context with
 	 * spinlock, via irport_write_wakeup(), or from non-interrupt without
 	 * spinlock (from the task timer). Yuck !
-	 * This is ugly, and unsafe is the spinlock is not already aquired.
+	 * This is ugly, and unsafe is the spinlock is not already acquired.
 	 * This will be fixed when irda-task get rewritten.
 	 * Jean II */
 	if (!spin_is_locked(&self->lock)) {
diff -urN linux-2.6.17-rc1.orig/drivers/net/pcmcia/smc91c92_cs.c linux-2.6.17-rc1/drivers/net/pcmcia/smc91c92_cs.c
--- linux-2.6.17-rc1.orig/drivers/net/pcmcia/smc91c92_cs.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/net/pcmcia/smc91c92_cs.c	2006-04-06 09:48:34.000000000 +0200
@@ -1883,7 +1883,7 @@
     /* Set the Window 1 control, configuration and station addr registers.
        No point in writing the I/O base register ;-> */
     SMC_SELECT_BANK(1);
-    /* Automatically release succesfully transmitted packets,
+    /* Automatically release successfully transmitted packets,
        Accept link errors, counter and Tx error interrupts. */
     outw(CTL_AUTO_RELEASE | CTL_TE_ENABLE | CTL_CR_ENABLE,
 	 ioaddr + CONTROL);
diff -urN linux-2.6.17-rc1.orig/drivers/net/wan/sdla_x25.c linux-2.6.17-rc1/drivers/net/wan/sdla_x25.c
--- linux-2.6.17-rc1.orig/drivers/net/wan/sdla_x25.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/net/wan/sdla_x25.c	2006-04-06 09:48:34.000000000 +0200
@@ -261,7 +261,7 @@
 	unsigned long i_timeout_sofar;  /* # of sec's we've been idle */
 	unsigned hold_timeout;		/* sec, before re-connecting */
 	unsigned long tick_counter;	/* counter for transmit time out */
-	char devtint;			/* Weather we should dev_tint() */
+	char devtint;			/* Whether we should dev_tint() */
 	struct sk_buff* rx_skb;		/* receive socket buffer */
 	struct sk_buff* tx_skb;		/* transmit socket buffer */
 
diff -urN linux-2.6.17-rc1.orig/drivers/net/wireless/ipw2100.c linux-2.6.17-rc1/drivers/net/wireless/ipw2100.c
--- linux-2.6.17-rc1.orig/drivers/net/wireless/ipw2100.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/net/wireless/ipw2100.c	2006-04-06 09:48:34.000000000 +0200
@@ -1485,7 +1485,7 @@
 		 *
 		 * Sending the PREPARE_FOR_POWER_DOWN will restrict the
 		 * hardware from going into standby mode and will transition
-		 * out of D0-standy if it is already in that state.
+		 * out of D0-standby if it is already in that state.
 		 *
 		 * STATUS_PREPARE_POWER_DOWN_COMPLETE will be sent by the
 		 * driver upon completion.  Once received, the driver can
diff -urN linux-2.6.17-rc1.orig/drivers/pci/pci.c linux-2.6.17-rc1/drivers/pci/pci.c
--- linux-2.6.17-rc1.orig/drivers/pci/pci.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/pci/pci.c	2006-04-06 09:48:34.000000000 +0200
@@ -368,7 +368,7 @@
 
 	/*
 	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
-	 * Firmware method after natice method ?
+	 * Firmware method after native method ?
 	 */
 	if (platform_pci_set_power_state)
 		platform_pci_set_power_state(dev, state);
diff -urN linux-2.6.17-rc1.orig/drivers/s390/scsi/zfcp_erp.c linux-2.6.17-rc1/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6.17-rc1.orig/drivers/s390/scsi/zfcp_erp.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/s390/scsi/zfcp_erp.c	2006-04-06 09:48:34.000000000 +0200
@@ -177,7 +177,7 @@
  *		initiates adapter recovery which is done
  *		asynchronously
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 int
@@ -213,7 +213,7 @@
  * purpose:	Wrappper for zfcp_erp_adapter_reopen_internal
  *              used to ensure the correct locking
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 int
@@ -503,7 +503,7 @@
  *		initiates Forced Reopen recovery which is done
  *		asynchronously
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 static int
@@ -543,7 +543,7 @@
  * purpose:	Wrappper for zfcp_erp_port_forced_reopen_internal
  *              used to ensure the correct locking
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 int
@@ -570,7 +570,7 @@
  *		initiates Reopen recovery which is done
  *		asynchronously
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 static int
@@ -639,7 +639,7 @@
  *		initiates Reopen recovery which is done
  *		asynchronously
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 static int
@@ -1901,7 +1901,7 @@
  * purpose:	Wrappper for zfcp_erp_port_reopen_all_internal
  *              used to ensure the correct locking
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 int
diff -urN linux-2.6.17-rc1.orig/drivers/scsi/aacraid/comminit.c linux-2.6.17-rc1/drivers/scsi/aacraid/comminit.c
--- linux-2.6.17-rc1.orig/drivers/scsi/aacraid/comminit.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/scsi/aacraid/comminit.c	2006-04-06 09:48:34.000000000 +0200
@@ -103,7 +103,7 @@
 	 * This assumes the memory is mapped zero->n, which isnt
 	 * always true on real computers. It also has some slight problems
 	 * with the GART on x86-64. I've btw never tried DMA from PCI space
-	 * on this platform but don't be suprised if its problematic.
+	 * on this platform but don't be surprised if its problematic.
 	 */
 #ifndef CONFIG_GART_IOMMU
 	if ((num_physpages << (PAGE_SHIFT - 12)) <= AAC_MAX_HOSTPHYSMEMPAGES) {
diff -urN linux-2.6.17-rc1.orig/drivers/scsi/advansys.c linux-2.6.17-rc1/drivers/scsi/advansys.c
--- linux-2.6.17-rc1.orig/drivers/scsi/advansys.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/scsi/advansys.c	2006-04-06 09:48:34.000000000 +0200
@@ -12374,7 +12374,7 @@
                 ASC_PRINT1(
 "AscInitFromEEP: Failed to re-write EEPROM with %d errors.\n", i);
         } else {
-                ASC_PRINT("AscInitFromEEP: Succesfully re-wrote EEPROM.");
+                ASC_PRINT("AscInitFromEEP: Successfully re-wrote EEPROM.\n");
         }
     }
     return (warn_code);
diff -urN linux-2.6.17-rc1.orig/drivers/scsi/dc395x.c linux-2.6.17-rc1/drivers/scsi/dc395x.c
--- linux-2.6.17-rc1.orig/drivers/scsi/dc395x.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/scsi/dc395x.c	2006-04-06 09:48:34.000000000 +0200
@@ -3747,7 +3747,7 @@
  * @target: The target for the new device.
  * @lun: The lun for the new device.
  *
- * Return the new device if succesfull or NULL on failure.
+ * Return the new device if successful or NULL on failure.
  **/
 static struct DeviceCtlBlk *device_alloc(struct AdapterCtlBlk *acb,
 		u8 target, u8 lun)
diff -urN linux-2.6.17-rc1.orig/drivers/scsi/ibmmca.c linux-2.6.17-rc1/drivers/scsi/ibmmca.c
--- linux-2.6.17-rc1.orig/drivers/scsi/ibmmca.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/scsi/ibmmca.c	2006-04-06 09:48:34.000000000 +0200
@@ -760,7 +760,7 @@
 		while (!got_interrupt(host_index))
 			barrier();
 
-		/*if command succesful, break */
+		/*if command successful, break */
 		if ((stat_result(host_index) == IM_SCB_CMD_COMPLETED) || (stat_result(host_index) == IM_SCB_CMD_COMPLETED_WITH_RETRIES))
 			return 1;
 	}
@@ -885,7 +885,7 @@
 		while (!got_interrupt(host_index))
 			barrier();
 
-		/*if command succesful, break */
+		/*if command successful, break */
 		if (stat_result(host_index) == IM_IMMEDIATE_CMD_COMPLETED)
 			return 1;
 	}
@@ -921,7 +921,7 @@
 			return 2;
 		} else
 			global_command_error_excuse = 0;
-		/*if command succesful, break */
+		/*if command successful, break */
 		if (stat_result(host_index) == IM_IMMEDIATE_CMD_COMPLETED)
 			return 1;
 	}
@@ -959,7 +959,7 @@
 			/* did not work, finish */
 			return 1;
 		}
-		/*if command succesful, break */
+		/*if command successful, break */
 		if (stat_result(host_index) == IM_IMMEDIATE_CMD_COMPLETED)
 			return 1;
 	}
diff -urN linux-2.6.17-rc1.orig/drivers/scsi/ips.c linux-2.6.17-rc1/drivers/scsi/ips.c
--- linux-2.6.17-rc1.orig/drivers/scsi/ips.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/scsi/ips.c	2006-04-06 09:48:34.000000000 +0200
@@ -6438,7 +6438,7 @@
 		/* VPP failure */
 		return (1);
 
-	/* check for succesful flash */
+	/* check for successful flash */
 	if (status & 0x30)
 		/* sequence error */
 		return (1);
@@ -6550,7 +6550,7 @@
 		/* VPP failure */
 		return (1);
 
-	/* check for succesful flash */
+	/* check for successful flash */
 	if (status & 0x30)
 		/* sequence error */
 		return (1);
diff -urN linux-2.6.17-rc1.orig/drivers/scsi/NCR5380.c linux-2.6.17-rc1/drivers/scsi/NCR5380.c
--- linux-2.6.17-rc1.orig/drivers/scsi/NCR5380.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/scsi/NCR5380.c	2006-04-06 09:48:34.000000000 +0200
@@ -500,7 +500,7 @@
 /* 
  * Function : int should_disconnect (unsigned char cmd)
  *
- * Purpose : decide weather a command would normally disconnect or 
+ * Purpose : decide whether a command would normally disconnect or 
  *      not, since if it won't disconnect we should go to sleep.
  *
  * Input : cmd - opcode of SCSI command
diff -urN linux-2.6.17-rc1.orig/drivers/scsi/st.c linux-2.6.17-rc1/drivers/scsi/st.c
--- linux-2.6.17-rc1.orig/drivers/scsi/st.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/drivers/scsi/st.c	2006-04-06 09:48:34.000000000 +0200
@@ -2818,7 +2818,7 @@
 		    (cmdstatp->sense_hdr.sense_key == NO_SENSE ||
 		     cmdstatp->sense_hdr.sense_key == RECOVERED_ERROR) &&
 		    undone == 0) {
-			ioctl_result = 0;	/* EOF written succesfully at EOM */
+			ioctl_result = 0;	/* EOF written successfully at EOM */
 			if (fileno >= 0)
 				fileno++;
 			STps->drv_file = fileno;
diff -urN linux-2.6.17-rc1.orig/fs/9p/mux.c linux-2.6.17-rc1/fs/9p/mux.c
--- linux-2.6.17-rc1.orig/fs/9p/mux.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/fs/9p/mux.c	2006-04-06 09:48:34.000000000 +0200
@@ -713,7 +713,7 @@
  * v9fs_send_request - send 9P request
  * The function can sleep until the request is scheduled for sending.
  * The function can be interrupted. Return from the function is not
- * a guarantee that the request is sent succesfully. Can return errors
+ * a guarantee that the request is sent successfully. Can return errors
  * that can be retrieved by PTR_ERR macros.
  *
  * @m: mux data
diff -urN linux-2.6.17-rc1.orig/fs/aio.c linux-2.6.17-rc1/fs/aio.c
--- linux-2.6.17-rc1.orig/fs/aio.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/fs/aio.c	2006-04-06 09:48:35.000000000 +0200
@@ -641,7 +641,7 @@
  *	invoked both for initial i/o submission and
  *	subsequent retries via the aio_kick_handler.
  *	Expects to be invoked with iocb->ki_ctx->lock
- *	already held. The lock is released and reaquired
+ *	already held. The lock is released and reacquired
  *	as needed during processing.
  *
  * Calls the iocb retry method (already setup for the
diff -urN linux-2.6.17-rc1.orig/fs/jffs2/summary.c linux-2.6.17-rc1/fs/jffs2/summary.c
--- linux-2.6.17-rc1.orig/fs/jffs2/summary.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/fs/jffs2/summary.c	2006-04-06 09:48:35.000000000 +0200
@@ -42,7 +42,7 @@
 		return -ENOMEM;
 	}
 
-	dbg_summary("returned succesfully\n");
+	dbg_summary("returned successfully\n");
 
 	return 0;
 }
diff -urN linux-2.6.17-rc1.orig/fs/jfs/jfs_extent.c linux-2.6.17-rc1/fs/jfs/jfs_extent.c
--- linux-2.6.17-rc1.orig/fs/jfs/jfs_extent.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/fs/jfs/jfs_extent.c	2006-04-06 09:48:35.000000000 +0200
@@ -126,7 +126,7 @@
 
 	/* allocate the disk blocks for the extent.  initially, extBalloc()
 	 * will try to allocate disk blocks for the requested size (xlen). 
-	 * if this fails (xlen contigious free blocks not avaliable), it'll
+	 * if this fails (xlen contiguous free blocks not avaliable), it'll
 	 * try to allocate a smaller number of blocks (producing a smaller
 	 * extent), with this smaller number of blocks consisting of the
 	 * requested number of blocks rounded down to the next smaller
@@ -493,7 +493,7 @@
  *
  *		initially, we will try to allocate disk blocks for the
  *		requested size (nblocks).  if this fails (nblocks 
- *		contigious free blocks not avaliable), we'll try to allocate
+ *		contiguous free blocks not avaliable), we'll try to allocate
  *		a smaller number of blocks (producing a smaller extent), with
  *		this smaller number of blocks consisting of the requested
  *		number of blocks rounded down to the next smaller power of 2
@@ -529,7 +529,7 @@
 
 	/* get the number of blocks to initially attempt to allocate.
 	 * we'll first try the number of blocks requested unless this
-	 * number is greater than the maximum number of contigious free
+	 * number is greater than the maximum number of contiguous free
 	 * blocks in the map. in that case, we'll start off with the 
 	 * maximum free.
 	 */
@@ -586,7 +586,7 @@
  *		in place.  if this fails, we'll try to move the extent
  *		to a new set of blocks. if moving the extent, we initially
  *		will try to allocate disk blocks for the requested size
- *		(nnew).  if this fails 	(nnew contigious free blocks not
+ *		(nnew).  if this fails 	(new contiguous free blocks not
  *		avaliable), we'll try  to allocate a smaller number of
  *		blocks (producing a smaller extent), with this smaller
  *		number of blocks consisting of the requested number of
diff -urN linux-2.6.17-rc1.orig/include/asm-i386/mmzone.h linux-2.6.17-rc1/include/asm-i386/mmzone.h
--- linux-2.6.17-rc1.orig/include/asm-i386/mmzone.h	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/include/asm-i386/mmzone.h	2006-04-06 09:48:42.000000000 +0200
@@ -49,11 +49,11 @@
 /*
  * generic node memory support, the following assumptions apply:
  *
- * 1) memory comes in 256Mb contigious chunks which are either present or not
- * 2) we will not have more than 64Gb in total
+ * 1) memory comes in 256Mb contiguous chunks which are either present or not
+ * 2) we will not have more than 64GB in total
  *
- * for now assume that 64Gb is max amount of RAM for whole system
- *    64Gb / 4096bytes/page = 16777216 pages
+ * for now assume that 64GB is max amount of RAM for whole system
+ *    64GB / 4096Bytes/page = 16777216 pages
  */
 #define MAX_NR_PAGES 16777216
 #define MAX_ELEMENTS 256
diff -urN linux-2.6.17-rc1.orig/include/asm-i386/system.h linux-2.6.17-rc1/include/asm-i386/system.h
--- linux-2.6.17-rc1.orig/include/asm-i386/system.h	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/include/asm-i386/system.h	2006-04-06 09:48:42.000000000 +0200
@@ -428,7 +428,7 @@
  * does not enforce ordering, since there is no data dependency between
  * the read of "a" and the read of "b".  Therefore, on some CPUs, such
  * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
- * in cases like thiswhere there are no data dependencies.
+ * in cases like this where there are no data dependencies.
  **/
 
 #define read_barrier_depends()	do { } while(0)
diff -urN linux-2.6.17-rc1.orig/include/asm-m32r/system.h linux-2.6.17-rc1/include/asm-m32r/system.h
--- linux-2.6.17-rc1.orig/include/asm-m32r/system.h	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/include/asm-m32r/system.h	2006-04-06 09:48:42.000000000 +0200
@@ -344,7 +344,7 @@
  * does not enforce ordering, since there is no data dependency between
  * the read of "a" and the read of "b".  Therefore, on some CPUs, such
  * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
- * in cases like thiswhere there are no data dependencies.
+ * in cases like this where there are no data dependencies.
  **/
 
 #define read_barrier_depends()	do { } while (0)
diff -urN linux-2.6.17-rc1.orig/include/linux/sunrpc/gss_api.h linux-2.6.17-rc1/include/linux/sunrpc/gss_api.h
--- linux-2.6.17-rc1.orig/include/linux/sunrpc/gss_api.h	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/include/linux/sunrpc/gss_api.h	2006-04-06 09:48:42.000000000 +0200
@@ -126,7 +126,7 @@
 /* Just increments the mechanism's reference count and returns its input: */
 struct gss_api_mech * gss_mech_get(struct gss_api_mech *);
 
-/* For every succesful gss_mech_get or gss_mech_get_by_* call there must be a
+/* For every successful gss_mech_get or gss_mech_get_by_* call there must be a
  * corresponding call to gss_mech_put. */
 void gss_mech_put(struct gss_api_mech *);
 
diff -urN linux-2.6.17-rc1.orig/lib/kernel_lock.c linux-2.6.17-rc1/lib/kernel_lock.c
--- linux-2.6.17-rc1.orig/lib/kernel_lock.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/lib/kernel_lock.c	2006-04-06 09:48:42.000000000 +0200
@@ -14,7 +14,7 @@
  * The 'big kernel semaphore'
  *
  * This mutex is taken and released recursively by lock_kernel()
- * and unlock_kernel().  It is transparently dropped and reaquired
+ * and unlock_kernel().  It is transparently dropped and reacquired
  * over schedule().  It is used to protect legacy code that hasn't
  * been migrated to a proper locking design yet.
  *
@@ -92,7 +92,7 @@
  * The 'big kernel lock'
  *
  * This spinlock is taken and released recursively by lock_kernel()
- * and unlock_kernel().  It is transparently dropped and reaquired
+ * and unlock_kernel().  It is transparently dropped and reacquired
  * over schedule().  It is used to protect legacy code that hasn't
  * been migrated to a proper locking design yet.
  *
diff -urN linux-2.6.17-rc1.orig/mm/page_alloc.c linux-2.6.17-rc1/mm/page_alloc.c
--- linux-2.6.17-rc1.orig/mm/page_alloc.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/mm/page_alloc.c	2006-04-06 09:48:43.000000000 +0200
@@ -260,7 +260,7 @@
  * satisfies the following equation:
  *     P = B & ~(1 << O)
  *
- * Assumption: *_mem_map is contigious at least up to MAX_ORDER
+ * Assumption: *_mem_map is contiguous at least up to MAX_ORDER
  */
 static inline struct page *
 __page_find_buddy(struct page *page, unsigned long page_idx, unsigned int order)
diff -urN linux-2.6.17-rc1.orig/mm/readahead.c linux-2.6.17-rc1/mm/readahead.c
--- linux-2.6.17-rc1.orig/mm/readahead.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/mm/readahead.c	2006-04-06 09:48:43.000000000 +0200
@@ -394,8 +394,8 @@
  * Read 'nr_to_read' pages starting at page 'offset'. If the flag 'block'
  * is set wait till the read completes.  Otherwise attempt to read without
  * blocking.
- * Returns 1 meaning 'success' if read is succesfull without switching off
- * readhaead mode. Otherwise return failure.
+ * Returns 1 meaning 'success' if read is successful without switching off
+ * readahead mode. Otherwise return failure.
  */
 static int
 blockable_page_cache_readahead(struct address_space *mapping, struct file *filp,
diff -urN linux-2.6.17-rc1.orig/net/sunrpc/auth_gss/gss_krb5_mech.c linux-2.6.17-rc1/net/sunrpc/auth_gss/gss_krb5_mech.c
--- linux-2.6.17-rc1.orig/net/sunrpc/auth_gss/gss_krb5_mech.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/net/sunrpc/auth_gss/gss_krb5_mech.c	2006-04-06 09:48:43.000000000 +0200
@@ -169,7 +169,7 @@
 	}
 
 	ctx_id->internal_ctx_id = ctx;
-	dprintk("RPC:      Succesfully imported new context.\n");
+	dprintk("RPC:      Successfully imported new context.\n");
 	return 0;
 
 out_err_free_key2:
diff -urN linux-2.6.17-rc1.orig/net/sunrpc/auth_gss/gss_spkm3_mech.c linux-2.6.17-rc1/net/sunrpc/auth_gss/gss_spkm3_mech.c
--- linux-2.6.17-rc1.orig/net/sunrpc/auth_gss/gss_spkm3_mech.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/net/sunrpc/auth_gss/gss_spkm3_mech.c	2006-04-06 09:48:43.000000000 +0200
@@ -201,7 +201,7 @@
 
 	ctx_id->internal_ctx_id = ctx;
 
-	dprintk("Succesfully imported new spkm context.\n");
+	dprintk("Successfully imported new spkm context.\n");
 	return 0;
 
 out_err_free_key2:
diff -urN linux-2.6.17-rc1.orig/sound/core/seq/seq_memory.h linux-2.6.17-rc1/sound/core/seq/seq_memory.h
--- linux-2.6.17-rc1.orig/sound/core/seq/seq_memory.h	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/sound/core/seq/seq_memory.h	2006-04-06 09:48:43.000000000 +0200
@@ -31,7 +31,7 @@
 	struct snd_seq_event_cell *next;	/* next cell */
 };
 
-/* design note: the pool is a contigious block of memory, if we dynamicly
+/* design note: the pool is a contiguous block of memory, if we dynamicly
    want to add additional cells to the pool be better store this in another
    pool as we need to know the base address of the pool when releasing
    memory. */
diff -urN linux-2.6.17-rc1.orig/sound/oss/sb_ess.c linux-2.6.17-rc1/sound/oss/sb_ess.c
--- linux-2.6.17-rc1.orig/sound/oss/sb_ess.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/sound/oss/sb_ess.c	2006-04-06 09:48:43.000000000 +0200
@@ -97,19 +97,19 @@
  *
  * The documentation is an adventure: it's close but not fully accurate. I
  * found out that after a reset some registers are *NOT* reset, though the
- * docs say the would be. Interresting ones are 0x7f, 0x7d and 0x7a. They are
- * related to the Audio 2 channel. I also was suprised about the consequenses
+ * docs say the would be. Interesting ones are 0x7f, 0x7d and 0x7a. They are
+ * related to the Audio 2 channel. I also was surprised about the consequences
  * of writing 0x00 to 0x7f (which should be done by reset): The ES1887 moves
  * into ES1888 mode. This means that it claims IRQ 11, which happens to be my
  * ISDN adapter. Needless to say it no longer worked. I now understand why
  * after rebooting 0x7f already was 0x05, the value of my choice: the BIOS
  * did it.
  *
- * Oh, and this is another trap: in ES1887 docs mixer register 0x70 is decribed
- * as if it's exactly the same as register 0xa1. This is *NOT* true. The
- * description of 0x70 in ES1869 docs is accurate however.
+ * Oh, and this is another trap: in ES1887 docs mixer register 0x70 is
+ * described as if it's exactly the same as register 0xa1. This is *NOT* true.
+ * The description of 0x70 in ES1869 docs is accurate however.
  * Well, the assumption about ES1869 was wrong: register 0x70 is very much
- * like register 0xa1, except that bit 7 is allways 1, whatever you want
+ * like register 0xa1, except that bit 7 is always 1, whatever you want
  * it to be.
  *
  * When using audio 2 mixer register 0x72 seems te be meaningless. Only 0xa2
@@ -117,10 +117,10 @@
  *
  * Software reset not being able to reset all registers is great! Especially
  * the fact that register 0x78 isn't reset is great when you wanna change back
- * to single dma operation (simplex): audio 2 is still operation, and uses the
- * same dma as audio 1: your ess changes into a funny echo machine.
+ * to single dma operation (simplex): audio 2 is still operational, and uses
+ * the same dma as audio 1: your ess changes into a funny echo machine.
  *
- * Received the new that ES1688 is detected as a ES1788. Did some thinking:
+ * Received the news that ES1688 is detected as a ES1788. Did some thinking:
  * the ES1887 detection scheme suggests in step 2 to try if bit 3 of register
  * 0x64 can be changed. This is inaccurate, first I inverted the * check: "If
  * can be modified, it's a 1688", which lead to a correct detection
@@ -135,7 +135,7 @@
  * About recognition of ESS chips
  *
  * The distinction of ES688, ES1688, ES1788, ES1887 and ES1888 is described in
- * a (preliminary ??) datasheet on ES1887. It's aim is to identify ES1887, but
+ * a (preliminary ??) datasheet on ES1887. Its aim is to identify ES1887, but
  * during detection the text claims that "this chip may be ..." when a step
  * fails. This scheme is used to distinct between the above chips.
  * It appears however that some PnP chips like ES1868 are recognized as ES1788
@@ -156,9 +156,9 @@
  *
  * The existing ES1688 support didn't take care of the ES1688+ recording
  * levels very well. Whenever a device was selected (recmask) for recording
- * it's recording level was loud, and it couldn't be changed. The fact that
+ * its recording level was loud, and it couldn't be changed. The fact that
  * internal register 0xb4 could take care of RECLEV, didn't work meaning until
- * it's value was restored every time the chip was reset; this reset the
+ * its value was restored every time the chip was reset; this reset the
  * value of 0xb4 too. I guess that's what 4front also had (have?) trouble with.
  *
  * About ES1887 support:
@@ -169,9 +169,9 @@
  * the latter case the recording volumes are 0.
  * Now recording levels of inputs can be controlled, by changing the playback
  * levels. Futhermore several devices can be recorded together (which is not
- * possible with the ES1688.
+ * possible with the ES1688).
  * Besides the separate recording level control for each input, the common
- * recordig level can also be controlled by RECLEV as described above.
+ * recording level can also be controlled by RECLEV as described above.
  *
  * Not only ES1887 have this recording mixer. I know the following from the
  * documentation:
diff -urN linux-2.6.17-rc1.orig/sound/pci/cs5535audio/cs5535audio_pcm.c linux-2.6.17-rc1/sound/pci/cs5535audio/cs5535audio_pcm.c
--- linux-2.6.17-rc1.orig/sound/pci/cs5535audio/cs5535audio_pcm.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1/sound/pci/cs5535audio/cs5535audio_pcm.c	2006-04-06 09:48:43.000000000 +0200
@@ -142,7 +142,7 @@
 	if (dma->periods == periods && dma->period_bytes == period_bytes)
 		return 0;
 
-	/* the u32 cast is okay because in snd*create we succesfully told
+	/* the u32 cast is okay because in snd*create we successfully told
    	   pci alloc that we're only 32 bit capable so the uppper will be 0 */
 	addr = (u32) substream->runtime->dma_addr;
 	desc_addr = (u32) dma->desc_buf.addr;
