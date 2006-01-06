Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752474AbWAFQdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbWAFQdp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbWAFQdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:33:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55819 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752474AbWAFQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:33:28 -0500
Date: Fri, 6 Jan 2006 17:33:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] spelling: s/retreive/retrieve/
Message-ID: <20060106163323.GN12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/i2o/ioctl                      |    2 +-
 arch/powerpc/kernel/prom.c                   |    2 +-
 arch/powerpc/kernel/rtas.c                   |    2 +-
 arch/powerpc/kernel/setup_64.c               |    2 +-
 arch/powerpc/mm/hash_utils_64.c              |    2 +-
 arch/powerpc/platforms/powermac/cpufreq_64.c |    2 +-
 drivers/macintosh/therm_pm72.c               |    4 ++--
 drivers/macintosh/windfarm_pm81.c            |    2 +-
 drivers/message/i2o/README.ioctl             |    2 +-
 drivers/net/hp100.c                          |    2 +-
 drivers/usb/serial/cypress_m8.c              |    2 +-
 drivers/video/aty/radeon_monitor.c           |    2 +-
 drivers/video/logo/Makefile                  |    2 +-
 fs/9p/vfs_inode.c                            |    2 +-
 include/asm-powerpc/smu.h                    |    6 +++---
 scripts/Makefile.modpost                     |    2 +-
 scripts/mksysmap                             |    2 +-
 17 files changed, 20 insertions(+), 20 deletions(-)

--- linux-2.6.15-mm1-full/arch/powerpc/kernel/prom.c.old	2006-01-06 16:46:53.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/powerpc/kernel/prom.c	2006-01-06 16:47:04.000000000 +0100
@@ -972,7 +972,7 @@
 #endif
 
 #ifdef CONFIG_PPC_RTAS
-	/* To help early debugging via the front panel, we retreive a minimal
+	/* To help early debugging via the front panel, we retrieve a minimal
 	 * set of RTAS infos now if available
 	 */
 	{
--- linux-2.6.15-mm1-full/arch/powerpc/kernel/rtas.c.old	2006-01-06 16:47:12.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/powerpc/kernel/rtas.c	2006-01-06 16:47:18.000000000 +0100
@@ -632,7 +632,7 @@
 }
 
 /*
- * Call early during boot, before mem init or bootmem, to retreive the RTAS
+ * Call early during boot, before mem init or bootmem, to retrieve the RTAS
  * informations from the device-tree and allocate the RMO buffer for userland
  * accesses.
  */
--- linux-2.6.15-mm1-full/arch/powerpc/kernel/setup_64.c.old	2006-01-06 16:47:34.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/powerpc/kernel/setup_64.c	2006-01-06 16:47:39.000000000 +0100
@@ -438,7 +438,7 @@
 
 	/*
 	 * Fill the ppc64_caches & systemcfg structures with informations
-	 * retreived from the device-tree. Need to be called before
+	 * retrieved from the device-tree. Need to be called before
 	 * finish_device_tree() since the later requires some of the
 	 * informations filled up here to properly parse the interrupt
 	 * tree.
--- linux-2.6.15-mm1-full/arch/powerpc/mm/hash_utils_64.c.old	2006-01-06 16:47:47.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/powerpc/mm/hash_utils_64.c	2006-01-06 16:47:52.000000000 +0100
@@ -368,7 +368,7 @@
 	unsigned long mem_size, rnd_mem_size, pteg_count;
 
 	/* If hash size isn't already provided by the platform, we try to
-	 * retreive it from the device-tree. If it's not there neither, we
+	 * retrieve it from the device-tree. If it's not there neither, we
 	 * calculate it now based on the total RAM size
 	 */
 	if (ppc64_pft_size == 0)
--- linux-2.6.15-mm1-full/arch/powerpc/platforms/powermac/cpufreq_64.c.old	2006-01-06 16:48:00.000000000 +0100
+++ linux-2.6.15-mm1-full/arch/powerpc/platforms/powermac/cpufreq_64.c	2006-01-06 16:48:05.000000000 +0100
@@ -79,7 +79,7 @@
 };
 
 /* Power mode data is an array of the 32 bits PCR values to use for
- * the various frequencies, retreived from the device-tree
+ * the various frequencies, retrieved from the device-tree
  */
 static u32 *g5_pmode_data;
 static int g5_pmode_max;
--- linux-2.6.15-mm1-full/Documentation/i2o/ioctl.old	2006-01-06 16:48:14.000000000 +0100
+++ linux-2.6.15-mm1-full/Documentation/i2o/ioctl	2006-01-06 16:48:19.000000000 +0100
@@ -185,7 +185,7 @@
       ENOMEM      Kernel memory allocation error
 
    A return value of 0 does not mean that the value was actually
-   properly retreived.  The user should check the result list
+   properly retrieved.  The user should check the result list
    to determine the specific status of the transaction.
 
 VIII. Downloading Software
--- linux-2.6.15-mm1-full/drivers/macintosh/therm_pm72.c.old	2006-01-06 16:48:27.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/macintosh/therm_pm72.c	2006-01-06 16:48:39.000000000 +0100
@@ -630,12 +630,12 @@
 	sprintf(nodename, "/u3@0,f8000000/i2c@f8001000/cpuid@a%d", cpu ? 2 : 0);
 	np = of_find_node_by_path(nodename);
 	if (np == NULL) {
-		printk(KERN_ERR "therm_pm72: Failed to retreive cpuid node from device-tree\n");
+		printk(KERN_ERR "therm_pm72: Failed to retrieve cpuid node from device-tree\n");
 		return -ENODEV;
 	}
 	data = (u8 *)get_property(np, "cpuid", &len);
 	if (data == NULL) {
-		printk(KERN_ERR "therm_pm72: Failed to retreive cpuid property from device-tree\n");
+		printk(KERN_ERR "therm_pm72: Failed to retrieve cpuid property from device-tree\n");
 		of_node_put(np);
 		return -ENODEV;
 	}
--- linux-2.6.15-mm1-full/drivers/macintosh/windfarm_pm81.c.old	2006-01-06 16:48:48.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/macintosh/windfarm_pm81.c	2006-01-06 16:48:52.000000000 +0100
@@ -26,7 +26,7 @@
  *    (typically the drive fan)
  *  - the main control (first control) gets the target value scaled with
  *    the first pair of factors, and is then modified as below
- *  - the value of the target of the CPU Fan control loop is retreived,
+ *  - the value of the target of the CPU Fan control loop is retrieved,
  *    scaled with the second pair of factors, and the max of that and
  *    the scaled target is applied to the main control.
  *
--- linux-2.6.15-mm1-full/drivers/message/i2o/README.ioctl.old	2006-01-06 16:49:00.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/message/i2o/README.ioctl	2006-01-06 16:49:05.000000000 +0100
@@ -185,7 +185,7 @@
       ENOMEM      Kernel memory allocation error
 
    A return value of 0 does not mean that the value was actually
-   properly retreived.  The user should check the result list 
+   properly retrieved.  The user should check the result list 
    to determine the specific status of the transaction.
 
 VIII. Downloading Software
--- linux-2.6.15-mm1-full/drivers/net/hp100.c.old	2006-01-06 16:49:18.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/net/hp100.c	2006-01-06 16:49:23.000000000 +0100
@@ -277,7 +277,7 @@
  * Convert an address in a kernel buffer to a bus/phys/dma address.
  * This work *only* for memory fragments part of lp->page_vaddr,
  * because it was properly DMA allocated via pci_alloc_consistent(),
- * so we just need to "retreive" the original mapping to bus/phys/dma
+ * so we just need to "retrieve" the original mapping to bus/phys/dma
  * address - Jean II */
 static inline dma_addr_t virt_to_whatever(struct net_device *dev, u32 * ptr)
 {
--- linux-2.6.15-mm1-full/drivers/usb/serial/cypress_m8.c.old	2006-01-06 16:49:31.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/usb/serial/cypress_m8.c	2006-01-06 16:49:37.000000000 +0100
@@ -357,7 +357,7 @@
 			} while (retval != 5 && retval != ENODEV);
 
 			if (retval != 5) {
-				err("%s - failed to retreive serial line settings - %d", __FUNCTION__, retval);
+				err("%s - failed to retrieve serial line settings - %d", __FUNCTION__, retval);
 				return retval;
 			} else {
 				spin_lock_irqsave(&priv->lock, flags);
--- linux-2.6.15-mm1-full/drivers/video/aty/radeon_monitor.c.old	2006-01-06 16:49:47.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/video/aty/radeon_monitor.c	2006-01-06 16:49:51.000000000 +0100
@@ -423,7 +423,7 @@
 /*
  * Probe display on both primary and secondary card's connector (if any)
  * by various available techniques (i2c, OF device tree, BIOS, ...) and
- * try to retreive EDID. The algorithm here comes from XFree's radeon
+ * try to retrieve EDID. The algorithm here comes from XFree's radeon
  * driver
  */
 void __devinit radeon_probe_screens(struct radeonfb_info *rinfo,
--- linux-2.6.15-mm1-full/drivers/video/logo/Makefile.old	2006-01-06 16:49:59.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/video/logo/Makefile	2006-01-06 16:50:04.000000000 +0100
@@ -16,7 +16,7 @@
 
 # How to generate logo's
 
-# Use logo-cfiles to retreive list of .c files to be built
+# Use logo-cfiles to retrieve list of .c files to be built
 logo-cfiles = $(notdir $(patsubst %.$(2), %.c, \
               $(wildcard $(srctree)/$(src)/*$(1).$(2))))
 
--- linux-2.6.15-mm1-full/fs/9p/vfs_inode.c.old	2006-01-06 16:50:12.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/9p/vfs_inode.c	2006-01-06 16:50:17.000000000 +0100
@@ -663,7 +663,7 @@
 }
 
 /**
- * v9fs_vfs_getattr - retreive file metadata
+ * v9fs_vfs_getattr - retrieve file metadata
  * @mnt - mount information
  * @dentry - file to get attributes on
  * @stat - metadata structure to populate
--- linux-2.6.15-mm1-full/include/asm-powerpc/smu.h.old	2006-01-06 16:50:26.000000000 +0100
+++ linux-2.6.15-mm1-full/include/asm-powerpc/smu.h	2006-01-06 16:50:44.000000000 +0100
@@ -22,7 +22,7 @@
 /*
  * Partition info commands
  *
- * These commands are used to retreive the sdb-partition-XX datas from
+ * These commands are used to retrieve the sdb-partition-XX datas from
  * the SMU. The lenght is always 2. First byte is the subcommand code
  * and second byte is the partition ID.
  *
@@ -225,7 +225,7 @@
  *
  * SMU_CMD_MISC_ee_GET_DATABLOCK_REC is used, among others, to
  * transfer blocks of data from the SMU. So far, I've decrypted it's
- * usage to retreive partition data. In order to do that, you have to
+ * usage to retrieve partition data. In order to do that, you have to
  * break your transfer in "chunks" since that command cannot transfer
  * more than a chunk at a time. The chunk size used by OF is 0xe bytes,
  * but it seems that the darwin driver will let you do 0x1e bytes if
@@ -556,7 +556,7 @@
 	__u32		cmdtype;
 #define SMU_CMDTYPE_SMU			0	/* SMU command */
 #define SMU_CMDTYPE_WANTS_EVENTS	1	/* switch fd to events mode */
-#define SMU_CMDTYPE_GET_PARTITION	2	/* retreive an sdb partition */
+#define SMU_CMDTYPE_GET_PARTITION	2	/* retrieve an sdb partition */
 
 	__u8		cmd;			/* SMU command byte */
 	__u8		pad[3];			/* padding */
--- linux-2.6.15-mm1-full/scripts/Makefile.modpost.old	2006-01-06 16:50:52.000000000 +0100
+++ linux-2.6.15-mm1-full/scripts/Makefile.modpost	2006-01-06 16:50:57.000000000 +0100
@@ -30,7 +30,7 @@
 #     - See include/linux/module.h for more details
 
 # Step 4 is solely used to allow module versioning in external modules,
-# where the CRC of each module is retreived from the Module.symers file.
+# where the CRC of each module is retrieved from the Module.symers file.
 
 .PHONY: _modpost
 _modpost: __modpost
--- linux-2.6.15-mm1-full/scripts/mksysmap.old	2006-01-06 16:51:05.000000000 +0100
+++ linux-2.6.15-mm1-full/scripts/mksysmap	2006-01-06 16:51:13.000000000 +0100
@@ -1,7 +1,7 @@
 #!/bin/sh -x
 # Based on the vmlinux file create the System.map file
 # System.map is used by module-init tools and some debugging
-# tools to retreive the actual addresses of symbols in the kernel.
+# tools to retrieve the actual addresses of symbols in the kernel.
 #
 # Usage
 # mksysmap vmlinux System.map

