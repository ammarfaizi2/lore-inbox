Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268381AbTBSC5r>; Tue, 18 Feb 2003 21:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268396AbTBSC5q>; Tue, 18 Feb 2003 21:57:46 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:45576 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268381AbTBSC5S>; Tue, 18 Feb 2003 21:57:18 -0500
Subject: [PATCH] 2.5.62 spelling fix adress/addres -> address in 33 files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 18 Feb 2003 19:58:40 -0700
Message-Id: <1045623522.5611.295.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the following spelling fixes.

adress  -> address
addres  -> address

except for in the following two files which appear
to be in French and German.  These were left as is.

./drivers/char/applicom.c:/* adresses de base des cartes, IOCTL 6 plus complet                         */
./drivers/isdn/hisax/elsa.c:/* ITAC Registeradressen (only Microlink PC) */

 Documentation/networking/alias.txt       |    2 +-
 Documentation/networking/bonding.txt     |    2 +-
 Documentation/s390/cds.txt               |    2 +-
 Documentation/scsi/ChangeLog.sym53c8xx_2 |    2 +-
 arch/cris/boot/compressed/misc.c         |    2 +-
 arch/cris/drivers/eeprom.c               |    2 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c    |    2 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_error.c  |    2 +-
 drivers/hotplug/ibmphp_pci.c             |    2 +-
 drivers/ieee1394/raw1394.c               |    2 +-
 drivers/isdn/hardware/eicon/mi_pc.h      |    2 +-
 drivers/media/dvb/av7110/saa7146_core.c  |    2 +-
 drivers/media/video/bt832.c              |    2 +-
 drivers/media/video/bt832.h              |    2 +-
 drivers/net/ac3200.c                     |    2 +-
 drivers/net/bonding.c                    |    2 +-
 drivers/net/tulip/dmfe.c                 |   12 ++++++------
 drivers/net/znet.c                       |    2 +-
 drivers/parport/parport_pc.c             |    2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.h      |    4 ++--
 drivers/scsi/sym53c8xx_2/sym_hipd.c      |    2 +-
 drivers/scsi/sym53c8xx_defs.h            |    4 ++--
 drivers/serial/8250_pnp.c                |    2 +-
 drivers/video/pm3fb.c                    |    4 ++--
 drivers/video/sstfb.c                    |    2 +-
 fs/jffs2/wbuf.c                          |    2 +-
 include/asm-arm/arch-iop310/dma.h        |    2 +-
 include/asm-m68knommu/mcfmbus.h          |    2 +-
 include/asm-m68knommu/mcfpci.h           |    2 +-
 include/asm-ppc/ppcboot.h                |    2 +-
 include/asm-s390/cio.h                   |    2 +-
 include/asm-s390x/cio.h                  |    2 +-
 sound/pci/es1968.c                       |    2 +-
 33 files changed, 41 insertions(+), 41 deletions(-)

diff -ur linux-2.5.62-1104-orig/Documentation/networking/alias.txt linux-2.5.62-1104/Documentation/networking/alias.txt
--- linux-2.5.62-1104-orig/Documentation/networking/alias.txt	Thu Jan 16 19:22:09 2003
+++ linux-2.5.62-1104/Documentation/networking/alias.txt	Tue Feb 18 18:50:37 2003
@@ -2,7 +2,7 @@
 IP-Aliasing:
 ============
 
-IP-aliases are additional IP-adresses/masks hooked up to a base 
+IP-aliases are additional IP-addresses/masks hooked up to a base 
 interface by adding a colon and a string when running ifconfig. 
 This string is usually numeric, but this is not a must.
 
diff -ur linux-2.5.62-1104-orig/Documentation/networking/bonding.txt linux-2.5.62-1104/Documentation/networking/bonding.txt
--- linux-2.5.62-1104-orig/Documentation/networking/bonding.txt	Mon Feb 10 12:22:53 2003
+++ linux-2.5.62-1104/Documentation/networking/bonding.txt	Tue Feb 18 18:50:37 2003
@@ -258,7 +258,7 @@
         Specifies the ip addresses to use when arp_interval is > 0. These are
         the targets of the ARP request sent to determine the health of the link
         to the targets. Specify these values in ddd.ddd.ddd.ddd format.
-        Multiple ip adresses must be separated by a comma. At least one ip
+        Multiple ip addresses must be separated by a comma. At least one ip
         address needs to be given for ARP monitoring to work. The maximum number
         of targets that can be specified is set at 16.
 
diff -ur linux-2.5.62-1104-orig/Documentation/s390/cds.txt linux-2.5.62-1104/Documentation/s390/cds.txt
--- linux-2.5.62-1104-orig/Documentation/s390/cds.txt	Thu Jan 16 19:22:29 2003
+++ linux-2.5.62-1104/Documentation/s390/cds.txt	Tue Feb 18 18:50:37 2003
@@ -286,7 +286,7 @@
 
 struct ccw1 {
       __u8  cmd_code;/* command code */
-      __u8  flags;   /* flags, like IDA adressing, etc. */
+      __u8  flags;   /* flags, like IDA addressing, etc. */
       __u16 count;   /* byte count */
       __u32 cda;     /* data address */
 } __attribute__ ((packed,aligned(8)));
diff -ur linux-2.5.62-1104-orig/Documentation/scsi/ChangeLog.sym53c8xx_2 linux-2.5.62-1104/Documentation/scsi/ChangeLog.sym53c8xx_2
--- linux-2.5.62-1104-orig/Documentation/scsi/ChangeLog.sym53c8xx_2	Thu Jan 16 19:22:04 2003
+++ linux-2.5.62-1104/Documentation/scsi/ChangeLog.sym53c8xx_2	Tue Feb 18 18:50:37 2003
@@ -102,7 +102,7 @@
 Sun Sep 9 18:00 2001 Gerard Roudier 
 	* version sym-2.1.12-20010909
 	- Change my email address.
-	- Add infrastructure for the forthcoming 64 bit DMA adressing support.
+	- Add infrastructure for the forthcoming 64 bit DMA addressing support.
 	  (Based on PCI 64 bit patch from David S. Miller)
 	- Donnot use anymore vm_offset_t type.
 
diff -ur linux-2.5.62-1104-orig/arch/cris/boot/compressed/misc.c linux-2.5.62-1104/arch/cris/boot/compressed/misc.c
--- linux-2.5.62-1104-orig/arch/cris/boot/compressed/misc.c	Thu Jan 16 19:22:40 2003
+++ linux-2.5.62-1104/arch/cris/boot/compressed/misc.c	Tue Feb 18 18:50:37 2003
@@ -13,7 +13,7 @@
  */
 
 /* where the piggybacked kernel image expects itself to live.
- * it is the same adress we use when we network load an uncompressed
+ * it is the same address we use when we network load an uncompressed
  * image into DRAM, and it is the address the kernel is linked to live
  * at by etrax100.ld.
  */
diff -ur linux-2.5.62-1104-orig/arch/cris/drivers/eeprom.c linux-2.5.62-1104/arch/cris/drivers/eeprom.c
--- linux-2.5.62-1104-orig/arch/cris/drivers/eeprom.c	Mon Feb 17 17:35:58 2003
+++ linux-2.5.62-1104/arch/cris/drivers/eeprom.c	Tue Feb 18 18:50:38 2003
@@ -802,7 +802,7 @@
   return 1;
 }
 
-/* Reads from current adress. */
+/* Reads from current address. */
 
 static int read_from_eeprom(char * buf, int count)
 {
diff -ur linux-2.5.62-1104-orig/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c linux-2.5.62-1104/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
--- linux-2.5.62-1104-orig/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Mon Feb 10 12:22:56 2003
+++ linux-2.5.62-1104/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Tue Feb 18 18:50:38 2003
@@ -3505,7 +3505,7 @@
     } else
 	xio_port = pcibr_dmamap->bd_xio_port;
 
-    /* If this DMA is to an addres that
+    /* If this DMA is to an address that
      * refers back to this Bridge chip,
      * reduce it back to the correct
      * PCI MEM address.
diff -ur linux-2.5.62-1104-orig/arch/ia64/sn/io/sn2/pcibr/pcibr_error.c linux-2.5.62-1104/arch/ia64/sn/io/sn2/pcibr/pcibr_error.c
--- linux-2.5.62-1104-orig/arch/ia64/sn/io/sn2/pcibr/pcibr_error.c	Thu Jan 16 19:21:37 2003
+++ linux-2.5.62-1104/arch/ia64/sn/io/sn2/pcibr/pcibr_error.c	Tue Feb 18 18:50:38 2003
@@ -1874,7 +1874,7 @@
 			BRIDGE_ERRUPPR_ADDRMASK) << 32)));
 
     /*
-     * need to ensure that the xtalk adress in ioe
+     * need to ensure that the xtalk address in ioe
      * maps to PCI error address read from bridge.
      * How to convert PCI address back to Xtalk address ?
      * (better idea: convert XTalk address to PCI address
diff -ur linux-2.5.62-1104-orig/drivers/hotplug/ibmphp_pci.c linux-2.5.62-1104/drivers/hotplug/ibmphp_pci.c
--- linux-2.5.62-1104-orig/drivers/hotplug/ibmphp_pci.c	Mon Feb 10 12:22:59 2003
+++ linux-2.5.62-1104/drivers/hotplug/ibmphp_pci.c	Tue Feb 18 18:50:38 2003
@@ -491,7 +491,7 @@
 				pci_bus_write_config_dword (ibmphp_pci_bus, devfn, address[count], func->pfmem[count]->start);
 
 				/*_______________This is for debugging purposes only______________________________*/				
-				debug ("b4 writing, start addres is %x\n", func->pfmem[count]->start);
+				debug ("b4 writing, start address is %x\n", func->pfmem[count]->start);
 				pci_bus_read_config_dword (ibmphp_pci_bus, devfn, address[count], &bar[count]);
 				debug ("after writing, start address is %x\n", bar[count]);
 				/*_________________________________________________________________________________*/
diff -ur linux-2.5.62-1104-orig/drivers/ieee1394/raw1394.c linux-2.5.62-1104/drivers/ieee1394/raw1394.c
--- linux-2.5.62-1104-orig/drivers/ieee1394/raw1394.c	Mon Feb 17 17:36:00 2003
+++ linux-2.5.62-1104/drivers/ieee1394/raw1394.c	Tue Feb 18 18:50:38 2003
@@ -238,7 +238,7 @@
                 list_del(&hi->list);
                 host_count--;
                 /* 
-                   FIXME: adressranges should be removed 
+                   FIXME: addressranges should be removed 
                    and fileinfo states should be initialized
                    (including setting generation to 
                    internal-generation ...)
diff -ur linux-2.5.62-1104-orig/drivers/isdn/hardware/eicon/mi_pc.h linux-2.5.62-1104/drivers/isdn/hardware/eicon/mi_pc.h
--- linux-2.5.62-1104-orig/drivers/isdn/hardware/eicon/mi_pc.h	Thu Jan 16 19:22:14 2003
+++ linux-2.5.62-1104/drivers/isdn/hardware/eicon/mi_pc.h	Tue Feb 18 18:50:38 2003
@@ -120,7 +120,7 @@
 #define MQ_CACHED_ADDR(x)               (((x) & 0x1fffffffL) | 0x80000000L)
 #define MQ_UNCACHED_ADDR(x)             (((x) & 0x1fffffffL) | 0xa0000000L)
 /*--------------------------------------------------------------------------------------------*/
-/* Additional definitions reflecting the different adress map of the  SERVER 4BRI V2          */
+/* Additional definitions reflecting the different address map of the  SERVER 4BRI V2          */
 #define MQ2_BREG_RISC                   0x0200      /* RISC Reset ect                         */
 #define MQ2_BREG_IRQ_TEST               0x0400      /* Interrupt request, no CPU interaction  */
 #define MQ2_BOARD_DSP_OFFSET            0x800000    /* PC relative On board DSP regs offset   */
diff -ur linux-2.5.62-1104-orig/drivers/media/dvb/av7110/saa7146_core.c linux-2.5.62-1104/drivers/media/dvb/av7110/saa7146_core.c
--- linux-2.5.62-1104-orig/drivers/media/dvb/av7110/saa7146_core.c	Thu Jan 16 19:22:27 2003
+++ linux-2.5.62-1104/drivers/media/dvb/av7110/saa7146_core.c	Tue Feb 18 18:50:38 2003
@@ -494,7 +494,7 @@
 
 	saa->revision = (rev & 0xf);
 
-	/* remap the memory from virtual to physical adress */
+	/* remap the memory from virtual to physical address */
 	saa->mem = ioremap ((saa->device->resource[0].start)
 			    &PCI_BASE_ADDRESS_MEM_MASK, 0x1000);
 
diff -ur linux-2.5.62-1104-orig/drivers/media/video/bt832.c linux-2.5.62-1104/drivers/media/video/bt832.c
--- linux-2.5.62-1104-orig/drivers/media/video/bt832.c	Thu Jan 16 19:22:26 2003
+++ linux-2.5.62-1104/drivers/media/video/bt832.c	Tue Feb 18 18:50:38 2003
@@ -1,5 +1,5 @@
 /* Driver for Bt832 CMOS Camera Video Processor
-    i2c-adresses: 0x88 or 0x8a
+    i2c-addresses: 0x88 or 0x8a
 
   The BT832 interfaces to a Quartzsight Digital Camera (352x288, 25 or 30 fps)
   via a 9 pin connector ( 4-wire SDATA, 2-wire i2c, SCLK, VCC, GND).
diff -ur linux-2.5.62-1104-orig/drivers/media/video/bt832.h linux-2.5.62-1104/drivers/media/video/bt832.h
--- linux-2.5.62-1104-orig/drivers/media/video/bt832.h	Thu Jan 16 19:22:23 2003
+++ linux-2.5.62-1104/drivers/media/video/bt832.h	Tue Feb 18 18:50:38 2003
@@ -4,7 +4,7 @@
   color digital camera directly to video capture devices via an 8-bit,
   4:2:2 YUV or YCrCb video interface.
 
- i2c adresses: 0x88 or 0x8a
+ i2c addresses: 0x88 or 0x8a
  */
 
 /* The 64 registers: */
diff -ur linux-2.5.62-1104-orig/drivers/net/ac3200.c linux-2.5.62-1104/drivers/net/ac3200.c
--- linux-2.5.62-1104-orig/drivers/net/ac3200.c	Thu Jan 16 19:22:22 2003
+++ linux-2.5.62-1104/drivers/net/ac3200.c	Tue Feb 18 18:51:34 2003
@@ -344,7 +344,7 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_AC32_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_AC32_CARDS) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_AC32_CARDS) "i");
-MODULE_PARM_DESC(io, "I/O base adress(es)");
+MODULE_PARM_DESC(io, "I/O base address(es)");
 MODULE_PARM_DESC(irq, "IRQ number(s)");
 MODULE_PARM_DESC(mem, "Memory base address(es)");
 MODULE_DESCRIPTION("Ansel AC3200 EISA ethernet driver");
diff -ur linux-2.5.62-1104-orig/drivers/net/bonding.c linux-2.5.62-1104/drivers/net/bonding.c
--- linux-2.5.62-1104-orig/drivers/net/bonding.c	Thu Jan 16 19:22:44 2003
+++ linux-2.5.62-1104/drivers/net/bonding.c	Tue Feb 18 18:50:38 2003
@@ -2547,7 +2547,7 @@
 
 /* 
  * in XOR mode, we determine the output device by performing xor on
- * the source and destination hw adresses.  If this device is not 
+ * the source and destination hw addresses.  If this device is not 
  * enabled, find the next slave following this xor slave. 
  */
 static int bond_xmit_xor(struct sk_buff *skb, struct net_device *dev)
diff -ur linux-2.5.62-1104-orig/drivers/net/tulip/dmfe.c linux-2.5.62-1104/drivers/net/tulip/dmfe.c
--- linux-2.5.62-1104-orig/drivers/net/tulip/dmfe.c	Thu Jan 16 19:22:42 2003
+++ linux-2.5.62-1104/drivers/net/tulip/dmfe.c	Tue Feb 18 18:50:38 2003
@@ -1337,7 +1337,7 @@
 
 /*
  *	Send a setup frame for DM9132
- *	This setup frame initilize DM910X addres filter mode
+ *	This setup frame initilize DM910X address filter mode
 */
 
 static void dm9132_id_table(struct DEVICE *dev, int mc_cnt)
@@ -1380,7 +1380,7 @@
 
 /*
  *	Send a setup frame for DM9102/DM9102A
- *	This setup frame initilize DM910X addres filter mode
+ *	This setup frame initilize DM910X address filter mode
  */
 
 static void send_filter_frame(struct DEVICE *dev, int mc_cnt)
@@ -1673,11 +1673,11 @@
 		phy_write_1bit(ioaddr, PHY_DATA_0);
 		phy_write_1bit(ioaddr, PHY_DATA_1);
 
-		/* Send Phy addres */
+		/* Send Phy address */
 		for (i = 0x10; i > 0; i = i >> 1)
 			phy_write_1bit(ioaddr, phy_addr & i ? PHY_DATA_1 : PHY_DATA_0);
 
-		/* Send register addres */
+		/* Send register address */
 		for (i = 0x10; i > 0; i = i >> 1)
 			phy_write_1bit(ioaddr, offset & i ? PHY_DATA_1 : PHY_DATA_0);
 
@@ -1722,11 +1722,11 @@
 		phy_write_1bit(ioaddr, PHY_DATA_1);
 		phy_write_1bit(ioaddr, PHY_DATA_0);
 
-		/* Send Phy addres */
+		/* Send Phy address */
 		for (i = 0x10; i > 0; i = i >> 1)
 			phy_write_1bit(ioaddr, phy_addr & i ? PHY_DATA_1 : PHY_DATA_0);
 
-		/* Send register addres */
+		/* Send register address */
 		for (i = 0x10; i > 0; i = i >> 1)
 			phy_write_1bit(ioaddr, offset & i ? PHY_DATA_1 : PHY_DATA_0);
 
diff -ur linux-2.5.62-1104-orig/drivers/net/znet.c linux-2.5.62-1104/drivers/net/znet.c
--- linux-2.5.62-1104-orig/drivers/net/znet.c	Thu Jan 16 19:21:33 2003
+++ linux-2.5.62-1104/drivers/net/znet.c	Tue Feb 18 18:50:38 2003
@@ -357,7 +357,7 @@
 	znet->tx_cur += sizeof(struct i82593_conf_block)/2;
 	outb(OP0_CONFIGURE | CR0_CHNL, ioaddr);
 
-	/* XXX FIXME maz : Add multicast adresses here, so having a
+	/* XXX FIXME maz : Add multicast addresses here, so having a
 	 * multicast address configured isn't equal to IFF_ALLMULTI */
 }
 
diff -ur linux-2.5.62-1104-orig/drivers/parport/parport_pc.c linux-2.5.62-1104/drivers/parport/parport_pc.c
--- linux-2.5.62-1104-orig/drivers/parport/parport_pc.c	Mon Feb 10 12:23:01 2003
+++ linux-2.5.62-1104/drivers/parport/parport_pc.c	Tue Feb 18 18:50:38 2003
@@ -1634,7 +1634,7 @@
 /*
  * Checks for port existence, all ports support SPP MODE
  * Returns: 
- *         0           :  No parallel port at this adress
+ *         0           :  No parallel port at this address
  *  PARPORT_MODE_PCSPP :  SPP port detected 
  *                        (if the user specified an ioport himself,
  *                         this shall always be the case!)
diff -ur linux-2.5.62-1104-orig/drivers/scsi/sym53c8xx_2/sym_glue.h linux-2.5.62-1104/drivers/scsi/sym53c8xx_2/sym_glue.h
--- linux-2.5.62-1104-orig/drivers/scsi/sym53c8xx_2/sym_glue.h	Mon Feb 10 12:23:03 2003
+++ linux-2.5.62-1104/drivers/scsi/sym53c8xx_2/sym_glue.h	Tue Feb 18 18:50:38 2003
@@ -263,7 +263,7 @@
 #endif
 
 /*
- *  If the CPU and the chip use same endian-ness adressing,
+ *  If the CPU and the chip use same endian-ness addressing,
  *  no byte reordering is needed for script patching.
  *  Macro cpu_to_scr() is to be used for script patching.
  *  Macro scr_to_cpu() is to be used for getting a DWORD 
@@ -297,7 +297,7 @@
  *  would have been correctly designed for PCI, this 
  *  option would be useless.
  *
- *  If the CPU and the chip use same endian-ness adressing,
+ *  If the CPU and the chip use same endian-ness addressing,
  *  no byte reordering is needed for accessing chip io 
  *  registers. Functions suffixed by '_raw' are assumed 
  *  to access the chip over the PCI without doing byte 
diff -ur linux-2.5.62-1104-orig/drivers/scsi/sym53c8xx_2/sym_hipd.c linux-2.5.62-1104/drivers/scsi/sym53c8xx_2/sym_hipd.c
--- linux-2.5.62-1104-orig/drivers/scsi/sym53c8xx_2/sym_hipd.c	Thu Jan 16 19:21:34 2003
+++ linux-2.5.62-1104/drivers/scsi/sym53c8xx_2/sym_hipd.c	Tue Feb 18 18:50:38 2003
@@ -1235,7 +1235,7 @@
  *  	s4:	scntl4 (see the manual)
  *
  *  current script command:
- *  	dsp:	script adress (relative to start of script).
+ *  	dsp:	script address (relative to start of script).
  *  	dbc:	first word of script command.
  *
  *  First 24 register of the chip:
diff -ur linux-2.5.62-1104-orig/drivers/scsi/sym53c8xx_defs.h linux-2.5.62-1104/drivers/scsi/sym53c8xx_defs.h
--- linux-2.5.62-1104-orig/drivers/scsi/sym53c8xx_defs.h	Thu Jan 16 19:22:28 2003
+++ linux-2.5.62-1104/drivers/scsi/sym53c8xx_defs.h	Tue Feb 18 18:50:38 2003
@@ -487,7 +487,7 @@
 #endif
 
 /*
- *  If the CPU and the NCR use same endian-ness adressing,
+ *  If the CPU and the NCR use same endian-ness addressing,
  *  no byte reordering is needed for script patching.
  *  Macro cpu_to_scr() is to be used for script patching.
  *  Macro scr_to_cpu() is to be used for getting a DWORD 
@@ -521,7 +521,7 @@
  *  would have been correctly designed for PCI, this 
  *  option would be useless.
  *
- *  If the CPU and the NCR use same endian-ness adressing,
+ *  If the CPU and the NCR use same endian-ness addressing,
  *  no byte reordering is needed for accessing chip io 
  *  registers. Functions suffixed by '_raw' are assumed 
  *  to access the chip over the PCI without doing byte 
diff -ur linux-2.5.62-1104-orig/drivers/serial/8250_pnp.c linux-2.5.62-1104/drivers/serial/8250_pnp.c
--- linux-2.5.62-1104-orig/drivers/serial/8250_pnp.c	Thu Jan 16 19:21:36 2003
+++ linux-2.5.62-1104/drivers/serial/8250_pnp.c	Tue Feb 18 18:50:38 2003
@@ -348,7 +348,7 @@
  * Given a complete unknown PnP device, try to use some heuristics to
  * detect modems. Currently use such heuristic set:
  *     - dev->name or dev->bus->name must contain "modem" substring;
- *     - device must have only one IO region (8 byte long) with base adress
+ *     - device must have only one IO region (8 byte long) with base address
  *       0x2e8, 0x3e8, 0x2f8 or 0x3f8.
  *
  * Such detection looks very ugly, but can detect at least some of numerous
diff -ur linux-2.5.62-1104-orig/drivers/video/pm3fb.c linux-2.5.62-1104/drivers/video/pm3fb.c
--- linux-2.5.62-1104-orig/drivers/video/pm3fb.c	Thu Jan 16 19:21:45 2003
+++ linux-2.5.62-1104/drivers/video/pm3fb.c	Tue Feb 18 18:50:38 2003
@@ -2325,7 +2325,7 @@
 	PM3_WRITE_REG(PM3ForegroundColor, fgx);
 	PM3_WRITE_REG(PM3FillBackgroundColor, bgx);
 
-	/* WARNING : adress select X need to specify 8 bits for fontwidth <= 8 */
+	/* WARNING : address select X need to specify 8 bits for fontwidth <= 8 */
 	/* and 16 bits for fontwidth <= 16 */
 	/* same in _putcs, same for Y and fontheight */
 	if (fontwidth(p) <= 8)
@@ -2438,7 +2438,7 @@
 	PM3_WRITE_REG(PM3ForegroundColor, fgx);
 	PM3_WRITE_REG(PM3FillBackgroundColor, bgx);
 
-	/* WARNING : adress select X need to specify 8 bits for fontwidth <= 8 */
+	/* WARNING : address select X need to specify 8 bits for fontwidth <= 8 */
 	/* and 16 bits for fontwidth <= 16 */
 	/* same in _putc, same for Y and fontheight */
 	if (fontwidth(p) <= 8)
diff -ur linux-2.5.62-1104-orig/drivers/video/sstfb.c linux-2.5.62-1104/drivers/video/sstfb.c
--- linux-2.5.62-1104-orig/drivers/video/sstfb.c	Thu Jan 16 19:22:20 2003
+++ linux-2.5.62-1104/drivers/video/sstfb.c	Tue Feb 18 18:50:38 2003
@@ -21,7 +21,7 @@
  */
 
 /*
- * The voodoo1 has the following memory mapped adress space:
+ * The voodoo1 has the following memory mapped address space:
  * 0x000000 - 0x3fffff : registers              (4MB)
  * 0x400000 - 0x7fffff : linear frame buffer    (4MB)
  * 0x800000 - 0xffffff : texture memory         (8MB)
diff -ur linux-2.5.62-1104-orig/fs/jffs2/wbuf.c linux-2.5.62-1104/fs/jffs2/wbuf.c
--- linux-2.5.62-1104-orig/fs/jffs2/wbuf.c	Thu Jan 16 19:21:47 2003
+++ linux-2.5.62-1104/fs/jffs2/wbuf.c	Tue Feb 18 18:50:38 2003
@@ -256,7 +256,7 @@
 	if (!c->wbuf)
 		return jffs2_flash_direct_writev(c, invecs, count, to, retlen);
 	
-	/* If wbuf_ofs is not initialized, set it to target adress */
+	/* If wbuf_ofs is not initialized, set it to target address */
 	if (c->wbuf_ofs == 0xFFFFFFFF) {
 		c->wbuf_ofs = PAGE_DIV(to);
 		c->wbuf_len = PAGE_MOD(to);			
diff -ur linux-2.5.62-1104-orig/include/asm-arm/arch-iop310/dma.h linux-2.5.62-1104/include/asm-arm/arch-iop310/dma.h
--- linux-2.5.62-1104-orig/include/asm-arm/arch-iop310/dma.h	Thu Jan 16 19:22:27 2003
+++ linux-2.5.62-1104/include/asm-arm/arch-iop310/dma.h	Tue Feb 18 18:50:38 2003
@@ -69,7 +69,7 @@
  */
 typedef struct _dma_desc
 {
-	u32 NDAR;					/* next descriptor adress */
+	u32 NDAR;					/* next descriptor address */
 	u32 PDAR;					/* PCI address */
 	u32 PUADR;					/* upper PCI address */
 	u32 LADR;					/* local address */
diff -ur linux-2.5.62-1104-orig/include/asm-m68knommu/mcfmbus.h linux-2.5.62-1104/include/asm-m68knommu/mcfmbus.h
--- linux-2.5.62-1104-orig/include/asm-m68knommu/mcfmbus.h	Thu Jan 16 19:22:06 2003
+++ linux-2.5.62-1104/include/asm-m68knommu/mcfmbus.h	Tue Feb 18 18:50:38 2003
@@ -23,7 +23,7 @@
 

 /*
-*	Define the 5307 MBUS register set adresses
+*	Define the 5307 MBUS register set addresses
 */
 
 #define MCFMBUS_MADR	0x00
diff -ur linux-2.5.62-1104-orig/include/asm-m68knommu/mcfpci.h linux-2.5.62-1104/include/asm-m68knommu/mcfpci.h
--- linux-2.5.62-1104-orig/include/asm-m68knommu/mcfpci.h	Thu Jan 16 19:22:20 2003
+++ linux-2.5.62-1104/include/asm-m68knommu/mcfpci.h	Tue Feb 18 18:50:38 2003
@@ -17,7 +17,7 @@
 #ifdef CONFIG_PCI
 
 /*
- *	Address regions in the PCI addres space are not mapped into the
+ *	Address regions in the PCI address space are not mapped into the
  *	normal memory space of the ColdFire. They must be accessed via
  *	handler routines. This is easy for I/O space (inb/outb/etc) but
  *	needs some code changes to support ordinary memory. Interrupts
diff -ur linux-2.5.62-1104-orig/include/asm-ppc/ppcboot.h linux-2.5.62-1104/include/asm-ppc/ppcboot.h
--- linux-2.5.62-1104-orig/include/asm-ppc/ppcboot.h	Thu Jan 16 19:22:43 2003
+++ linux-2.5.62-1104/include/asm-ppc/ppcboot.h	Tue Feb 18 18:50:38 2003
@@ -57,7 +57,7 @@
 #endif
 	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
 	unsigned long	bi_ip_addr;	/* IP Address */
-	unsigned char	bi_enetaddr[6];	/* Ethernet adress */
+	unsigned char	bi_enetaddr[6];	/* Ethernet address */
 	unsigned short	bi_ethspeed;	/* Ethernet speed in Mbps */
 	unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
 	unsigned long	bi_busfreq;	/* Bus Freq, in MHz */
diff -ur linux-2.5.62-1104-orig/include/asm-s390/cio.h linux-2.5.62-1104/include/asm-s390/cio.h
--- linux-2.5.62-1104-orig/include/asm-s390/cio.h	Thu Jan 16 19:22:42 2003
+++ linux-2.5.62-1104/include/asm-s390/cio.h	Tue Feb 18 18:50:38 2003
@@ -111,7 +111,7 @@
 
 struct ccw1 {
 	__u8  cmd_code;		/* command code */
-	__u8  flags;   		/* flags, like IDA adressing, etc. */
+	__u8  flags;   		/* flags, like IDA addressing, etc. */
 	__u16 count;   		/* byte count */
 	__u32 cda;     		/* data address */
 } __attribute__ ((packed,aligned(8)));
diff -ur linux-2.5.62-1104-orig/include/asm-s390x/cio.h linux-2.5.62-1104/include/asm-s390x/cio.h
--- linux-2.5.62-1104-orig/include/asm-s390x/cio.h	Thu Jan 16 19:22:10 2003
+++ linux-2.5.62-1104/include/asm-s390x/cio.h	Tue Feb 18 18:50:38 2003
@@ -111,7 +111,7 @@
 
 struct ccw1 {
 	__u8  cmd_code;		/* command code */
-	__u8  flags;   		/* flags, like IDA adressing, etc. */
+	__u8  flags;   		/* flags, like IDA addressing, etc. */
 	__u16 count;   		/* byte count */
 	__u32 cda;     		/* data address */
 } __attribute__ ((packed,aligned(8)));
diff -ur linux-2.5.62-1104-orig/sound/pci/es1968.c linux-2.5.62-1104/sound/pci/es1968.c
--- linux-2.5.62-1104-orig/sound/pci/es1968.c	Mon Feb 10 12:23:10 2003
+++ linux-2.5.62-1104/sound/pci/es1968.c	Tue Feb 18 18:50:38 2003
@@ -1414,7 +1414,7 @@
    * DMA memory management *
    *************************/
 
-/* Because the Maestro can only take addresses relative to the PCM base adress
+/* Because the Maestro can only take addresses relative to the PCM base address
    register :( */
 
 static int calc_available_memory_size(es1968_t *chip)

