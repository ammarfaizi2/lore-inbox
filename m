Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUIOTE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUIOTE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUIOTE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:04:59 -0400
Received: from mail.broadpark.no ([217.13.4.2]:56254 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S267326AbUIOTEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:04:45 -0400
Message-ID: <414892C8.6050100@student.matnat.uio.no>
Date: Wed, 15 Sep 2004 21:06:48 +0200
From: Daniel Andersen <dskander@student.matnat.uio.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - Spell fixes - adress to address
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed some typos. From adress to address. Only touched comments in English.

Daniel Andersen

--

diff -ruN linux-2.6.8/arch/mips/mm/pg-r4k.c linux-2.6.8-edited/arch/mips/mm/pg-r4k.c
--- linux-2.6.8/arch/mips/mm/pg-r4k.c	2004-08-14 07:36:58.000000000 +0200
+++ linux-2.6.8-edited/arch/mips/mm/pg-r4k.c	2004-09-15 19:37:00.156106688 +0200
@@ -59,7 +59,7 @@

  /*
   * An address fits into a single register so it's safe to use 64-bit registers
- * if we have 64-bit adresses.
+ * if we have 64-bit addresses.
   */
  #define cpu_has_64bit_registers	cpu_has_64bit_addresses

diff -ruN linux-2.6.8/arch/x86_64/kernel/head.S linux-2.6.8-edited/arch/x86_64/kernel/head.S
--- linux-2.6.8/arch/x86_64/kernel/head.S	2004-08-14 07:37:25.000000000 +0200
+++ linux-2.6.8-edited/arch/x86_64/kernel/head.S	2004-09-15 19:37:02.278783992 +0200
@@ -18,7 +18,7 @@
  #include <asm/msr.h>
  #include <asm/cache.h>
  	
-/* we are not able to switch in one step to the final KERNEL ADRESS SPACE
+/* we are not able to switch in one step to the final KERNEL ADDRESS SPACE
   * because we need identity-mapped pages on setup so define __START_KERNEL to
   * 0x100000 for this stage
   *
diff -ruN linux-2.6.8/Documentation/networking/bonding.txt linux-2.6.8-edited/Documentation/networking/bonding.txt
--- linux-2.6.8/Documentation/networking/bonding.txt	2004-08-14 07:36:32.000000000 +0200
+++ linux-2.6.8-edited/Documentation/networking/bonding.txt	2004-09-15 19:37:45.702182632 +0200
@@ -216,7 +216,7 @@
  	Specifies the ip addresses to use when arp_interval is > 0. These
  	are the targets of the ARP request sent to determine the health of
  	the link to the targets. Specify these values in ddd.ddd.ddd.ddd
-	format. Multiple ip adresses must be seperated by a comma. At least
+	format. Multiple ip addresses must be seperated by a comma. At least
  	one ip address needs to be given for ARP monitoring to work. The
  	maximum number of targets that can be specified is set at 16.

diff -ruN linux-2.6.8/drivers/media/common/saa7146_core.c linux-2.6.8-edited/drivers/media/common/saa7146_core.c
--- linux-2.6.8/drivers/media/common/saa7146_core.c	2004-08-14 07:37:27.000000000 +0200
+++ linux-2.6.8-edited/drivers/media/common/saa7146_core.c	2004-09-15 19:37:31.603325984 +0200
@@ -359,7 +359,7 @@
  	}
  	dev->revision &= 0xf;

-	/* remap the memory from virtual to physical adress */
+	/* remap the memory from virtual to physical address */
  	adr = pci_resource_start(pci,0);
  	len = pci_resource_len(pci,0);

diff -ruN linux-2.6.8/drivers/media/video/tea6420.c linux-2.6.8-edited/drivers/media/video/tea6420.c
--- linux-2.6.8/drivers/media/video/tea6420.c	2004-08-14 07:36:58.000000000 +0200
+++ linux-2.6.8-edited/drivers/media/video/tea6420.c	2004-09-15 19:37:31.742304856 +0200
@@ -5,7 +5,7 @@

      The tea6420 is a bus controlled audio-matrix with 5 stereo inputs,
      4 stereo outputs and gain control for each output.
-    It is cascadable, i.e. it can be found at the adresses 0x98
+    It is cascadable, i.e. it can be found at the addresses 0x98
      and 0x9a on the i2c-bus.

      For detailed informations download the specifications directly
diff -ruN linux-2.6.8/drivers/mtd/nand/autcpu12.c linux-2.6.8-edited/drivers/mtd/nand/autcpu12.c
--- linux-2.6.8/drivers/mtd/nand/autcpu12.c	2004-08-14 07:36:17.000000000 +0200
+++ linux-2.6.8-edited/drivers/mtd/nand/autcpu12.c	2004-09-15 19:37:32.608173224 +0200
@@ -20,7 +20,7 @@
   *
   *	02-12-2002 TG	Cleanup of module params
   *
- *	02-20-2002 TG	adjusted for different rd/wr adress support
+ *	02-20-2002 TG	adjusted for different rd/wr address support
   *			added support for read device ready/busy line
   *			added page_cache
   *
@@ -149,7 +149,7 @@
  		goto out;
  	}

-	/* map physical adress */
+	/* map physical address */
  	autcpu12_fio_base=(unsigned long)ioremap(autcpu12_fio_pbase,SZ_1K);
  	if(!autcpu12_fio_base){
  		printk("Ioremap autcpu12 SmartMedia Card failed\n");
@@ -221,7 +221,7 @@
  	/* Release resources, unregister device */
  	nand_release (autcpu12_mtd);

-	/* unmap physical adress */
+	/* unmap physical address */
  	iounmap((void *)autcpu12_fio_base);
  	
  	/* Free the MTD device structure */
diff -ruN linux-2.6.8/drivers/mtd/nand/edb7312.c linux-2.6.8-edited/drivers/mtd/nand/edb7312.c
--- linux-2.6.8/drivers/mtd/nand/edb7312.c	2004-08-14 07:38:08.000000000 +0200
+++ linux-2.6.8-edited/drivers/mtd/nand/edb7312.c	2004-09-15 19:37:32.629170032 +0200
@@ -142,7 +142,7 @@
  		return -ENOMEM;
  	}
  	
-	/* map physical adress */
+	/* map physical address */
  	ep7312_fio_base = (unsigned long)ioremap(ep7312_fio_pbase, SZ_1K);
  	if(!ep7312_fio_base) {
  		printk("ioremap EDB7312 NAND flash failed\n");
diff -ruN linux-2.6.8/drivers/net/bonding/bond_main.c linux-2.6.8-edited/drivers/net/bonding/bond_main.c
--- linux-2.6.8/drivers/net/bonding/bond_main.c	2004-08-14 07:37:56.000000000 +0200
+++ linux-2.6.8-edited/drivers/net/bonding/bond_main.c	2004-09-15 19:37:22.828659936 +0200
@@ -4105,7 +4105,7 @@

  /*
   * in XOR mode, we determine the output device by performing xor on
- * the source and destination hw adresses.  If this device is not
+ * the source and destination hw addresses.  If this device is not
   * enabled, find the next slave following this xor slave.
   */
  static int bond_xmit_xor(struct sk_buff *skb, struct net_device *bond_dev)
diff -ruN linux-2.6.8/fs/freevxfs/vxfs_immed.c linux-2.6.8-edited/fs/freevxfs/vxfs_immed.c
--- linux-2.6.8/fs/freevxfs/vxfs_immed.c	2004-08-14 07:37:25.000000000 +0200
+++ linux-2.6.8-edited/fs/freevxfs/vxfs_immed.c	2004-09-15 19:37:12.602214592 +0200
@@ -54,7 +54,7 @@
  };

  /*
- * Adress space operations for immed files and directories.
+ * Address space operations for immed files and directories.
   */
  struct address_space_operations vxfs_immed_aops = {
  	.readpage =		vxfs_immed_readpage,
diff -ruN linux-2.6.8/include/asm-arm/arch-pxa/pxa-regs.h linux-2.6.8-edited/include/asm-arm/arch-pxa/pxa-regs.h
--- linux-2.6.8/include/asm-arm/arch-pxa/pxa-regs.h	2004-08-14 07:37:15.000000000 +0200
+++ linux-2.6.8-edited/include/asm-arm/arch-pxa/pxa-regs.h	2004-09-15 19:37:57.305418672 +0200
@@ -953,7 +953,7 @@
  #define ICSR0		__REG(0x40800014)  /* ICP Status Register 0 */
  #define ICSR1		__REG(0x40800018)  /* ICP Status Register 1 */

-#define ICCR0_AME	(1 << 7)	/* Adress match enable */
+#define ICCR0_AME	(1 << 7)	/* Address match enable */
  #define ICCR0_TIE	(1 << 6)	/* Transmit FIFO interrupt enable */
  #define ICCR0_RIE	(1 << 5)	/* Recieve FIFO interrupt enable */
  #define ICCR0_RXE	(1 << 4)	/* Receive enable */
diff -ruN linux-2.6.8/include/asm-m68knommu/m5249sim.h linux-2.6.8-edited/include/asm-m68knommu/m5249sim.h
--- linux-2.6.8/include/asm-m68knommu/m5249sim.h	2004-08-14 07:37:40.000000000 +0200
+++ linux-2.6.8-edited/include/asm-m68knommu/m5249sim.h	2004-09-15 19:37:54.064911304 +0200
@@ -43,10 +43,10 @@
  #define MCFSIM_CSAR1		0x8c		/* CS 1 Address reg (r/w) */
  #define MCFSIM_CSMR1		0x90		/* CS 1 Mask reg (r/w) */
  #define MCFSIM_CSCR1		0x96		/* CS 1 Control reg (r/w) */
-#define MCFSIM_CSAR2		0x98		/* CS 2 Adress reg (r/w) */
+#define MCFSIM_CSAR2		0x98		/* CS 2 Address reg (r/w) */
  #define MCFSIM_CSMR2		0x9c		/* CS 2 Mask reg (r/w) */
  #define MCFSIM_CSCR2		0xa2		/* CS 2 Control reg (r/w) */
-#define MCFSIM_CSAR3		0xa4		/* CS 3 Adress reg (r/w) */
+#define MCFSIM_CSAR3		0xa4		/* CS 3 Address reg (r/w) */
  #define MCFSIM_CSMR3		0xa8		/* CS 3 Mask reg (r/w) */
  #define MCFSIM_CSCR3		0xae		/* CS 3 Control reg (r/w) */

diff -ruN linux-2.6.8/include/asm-m68knommu/m5307sim.h linux-2.6.8-edited/include/asm-m68knommu/m5307sim.h
--- linux-2.6.8/include/asm-m68knommu/m5307sim.h	2004-08-14 07:36:56.000000000 +0200
+++ linux-2.6.8-edited/include/asm-m68knommu/m5307sim.h	2004-09-15 19:37:53.875940032 +0200
@@ -64,22 +64,22 @@
  #define MCFSIM_CSMR7		0xda		/* CS 7 Mask reg (r/w) */
  #define MCFSIM_CSCR7		0xde		/* CS 7 Control reg (r/w) */
  #else
-#define MCFSIM_CSAR2		0x98		/* CS 2 Adress reg (r/w) */
+#define MCFSIM_CSAR2		0x98		/* CS 2 Address reg (r/w) */
  #define MCFSIM_CSMR2		0x9c		/* CS 2 Mask reg (r/w) */
  #define MCFSIM_CSCR2		0xa2		/* CS 2 Control reg (r/w) */
-#define MCFSIM_CSAR3		0xa4		/* CS 3 Adress reg (r/w) */
+#define MCFSIM_CSAR3		0xa4		/* CS 3 Address reg (r/w) */
  #define MCFSIM_CSMR3		0xa8		/* CS 3 Mask reg (r/w) */
  #define MCFSIM_CSCR3		0xae		/* CS 3 Control reg (r/w) */
-#define MCFSIM_CSAR4		0xb0		/* CS 4 Adress reg (r/w) */
+#define MCFSIM_CSAR4		0xb0		/* CS 4 Address reg (r/w) */
  #define MCFSIM_CSMR4		0xb4		/* CS 4 Mask reg (r/w) */
  #define MCFSIM_CSCR4		0xba		/* CS 4 Control reg (r/w) */
-#define MCFSIM_CSAR5		0xbc		/* CS 5 Adress reg (r/w) */
+#define MCFSIM_CSAR5		0xbc		/* CS 5 Address reg (r/w) */
  #define MCFSIM_CSMR5		0xc0		/* CS 5 Mask reg (r/w) */
  #define MCFSIM_CSCR5		0xc6		/* CS 5 Control reg (r/w) */
-#define MCFSIM_CSAR6		0xc8		/* CS 6 Adress reg (r/w) */
+#define MCFSIM_CSAR6		0xc8		/* CS 6 Address reg (r/w) */
  #define MCFSIM_CSMR6		0xcc		/* CS 6 Mask reg (r/w) */
  #define MCFSIM_CSCR6		0xd2		/* CS 6 Control reg (r/w) */
-#define MCFSIM_CSAR7		0xd4		/* CS 7 Adress reg (r/w) */
+#define MCFSIM_CSAR7		0xd4		/* CS 7 Address reg (r/w) */
  #define MCFSIM_CSMR7		0xd8		/* CS 7 Mask reg (r/w) */
  #define MCFSIM_CSCR7		0xde		/* CS 7 Control reg (r/w) */
  #endif /* CONFIG_OLDMASK */
diff -ruN linux-2.6.8/include/asm-m68knommu/m5407sim.h linux-2.6.8-edited/include/asm-m68knommu/m5407sim.h
--- linux-2.6.8/include/asm-m68knommu/m5407sim.h	2004-08-14 07:37:38.000000000 +0200
+++ linux-2.6.8-edited/include/asm-m68knommu/m5407sim.h	2004-09-15 19:37:54.184893064 +0200
@@ -48,22 +48,22 @@
  #define MCFSIM_CSMR1		0x90		/* CS 1 Mask reg (r/w) */
  #define MCFSIM_CSCR1		0x96		/* CS 1 Control reg (r/w) */

-#define MCFSIM_CSAR2		0x98		/* CS 2 Adress reg (r/w) */
+#define MCFSIM_CSAR2		0x98		/* CS 2 Address reg (r/w) */
  #define MCFSIM_CSMR2		0x9c		/* CS 2 Mask reg (r/w) */
  #define MCFSIM_CSCR2		0xa2		/* CS 2 Control reg (r/w) */
-#define MCFSIM_CSAR3		0xa4		/* CS 3 Adress reg (r/w) */
+#define MCFSIM_CSAR3		0xa4		/* CS 3 Address reg (r/w) */
  #define MCFSIM_CSMR3		0xa8		/* CS 3 Mask reg (r/w) */
  #define MCFSIM_CSCR3		0xae		/* CS 3 Control reg (r/w) */
-#define MCFSIM_CSAR4		0xb0		/* CS 4 Adress reg (r/w) */
+#define MCFSIM_CSAR4		0xb0		/* CS 4 Address reg (r/w) */
  #define MCFSIM_CSMR4		0xb4		/* CS 4 Mask reg (r/w) */
  #define MCFSIM_CSCR4		0xba		/* CS 4 Control reg (r/w) */
-#define MCFSIM_CSAR5		0xbc		/* CS 5 Adress reg (r/w) */
+#define MCFSIM_CSAR5		0xbc		/* CS 5 Address reg (r/w) */
  #define MCFSIM_CSMR5		0xc0		/* CS 5 Mask reg (r/w) */
  #define MCFSIM_CSCR5		0xc6		/* CS 5 Control reg (r/w) */
-#define MCFSIM_CSAR6		0xc8		/* CS 6 Adress reg (r/w) */
+#define MCFSIM_CSAR6		0xc8		/* CS 6 Address reg (r/w) */
  #define MCFSIM_CSMR6		0xcc		/* CS 6 Mask reg (r/w) */
  #define MCFSIM_CSCR6		0xd2		/* CS 6 Control reg (r/w) */
-#define MCFSIM_CSAR7		0xd4		/* CS 7 Adress reg (r/w) */
+#define MCFSIM_CSAR7		0xd4		/* CS 7 Address reg (r/w) */
  #define MCFSIM_CSMR7		0xd8		/* CS 7 Mask reg (r/w) */
  #define MCFSIM_CSCR7		0xde		/* CS 7 Control reg (r/w) */

diff -ruN linux-2.6.8/include/linux/mtd/nand.h linux-2.6.8-edited/include/linux/mtd/nand.h
--- linux-2.6.8/include/linux/mtd/nand.h	2004-08-14 07:37:40.000000000 +0200
+++ linux-2.6.8-edited/include/linux/mtd/nand.h	2004-09-15 19:37:56.128597576 +0200
@@ -26,7 +26,7 @@
   *   10-24-2000 SJH     Added prototype for 'nand_scan' function
   *   10-29-2001 TG	changed nand_chip structure to support
   *			hardwarespecific function for accessing control lines
- *   02-21-2002 TG	added support for different read/write adress and
+ *   02-21-2002 TG	added support for different read/write address and
   *			ready/busy line access function
   *   02-26-2002 TG	added chip_delay to nand_chip structure to optimize
   *			command delay times for different chips
diff -ruN linux-2.6.8/sound/parisc/harmony.c linux-2.6.8-edited/sound/parisc/harmony.c
--- linux-2.6.8/sound/parisc/harmony.c	2004-08-14 07:36:56.000000000 +0200
+++ linux-2.6.8-edited/sound/parisc/harmony.c	2004-09-15 19:37:43.673491040 +0200
@@ -30,7 +30,7 @@
   * Harmony chipset 'modus operandi'.
   * - This chipset is found in some HP 32bit workstations, like 712, or B132 class.
   * most of controls are done through registers. Register are found at a fixed offset
- * from the hard physical adress, given in struct dev by register_parisc_driver.
+ * from the hard physical address, given in struct dev by register_parisc_driver.
   *
   * Playback and recording use 4kb pages (dma or not, depending on the machine).
   *
@@ -39,12 +39,12 @@
   * Bits 2 and 10 of DSTATUS register are '1' when harmony needs respectively
   * a new page for recording and playing.
   * Interrupt are disabled/enabled by writing to bit 32 of DSTATUS.
- * Adresses of next page to be played is put in PNXTADD register, next page
+ * Addresses of next page to be played is put in PNXTADD register, next page
   * to be recorded is put in RNXTADD. There is 2 read-only registers, PCURADD and
- * RCURADD that provides adress of current page.
+ * RCURADD that provides address of current page.
   *
   * Harmony has no way to controll full duplex or half duplex mode. It means
- * that we always need to provide adresses of playback and capture data, even
+ * that we always need to provide addresses of playback and capture data, even
   * when this is not needed. That's why we statically alloc one graveyard
   * buffer (to put recorded data in play-only mode) and a silence buffer.
   *
@@ -328,7 +328,7 @@

  /*
   * interruption routine:
- * The interrupt routine must provide adresse of next physical pages
+ * The interrupt routine must provide addresse of next physical pages
   * used by harmony
   */
  static int snd_card_harmony_interrupt(int irq, void *dev, struct pt_regs *regs)
