Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291613AbSBHPdf>; Fri, 8 Feb 2002 10:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291611AbSBHPdZ>; Fri, 8 Feb 2002 10:33:25 -0500
Received: from ns.suse.de ([213.95.15.193]:4 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287359AbSBHPdJ>;
	Fri, 8 Feb 2002 10:33:09 -0500
Date: Fri, 8 Feb 2002 16:33:07 +0100
From: Hubert Mantel <mantel@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: Re: Linux 2.4.18-pre9
Message-ID: <20020208163307.Y20154@suse.de>
In-Reply-To: <Pine.LNX.4.21.0202071646550.17201-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.21.0202071646550.17201-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
Organization: SuSE Labs, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.4.17-4GB
X-GPG-Key: 1024D/B0DFF780
X-Message-Flag: Your mailbox is corrupt. Upgrade your mail software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Feb 07, Marcelo Tosatti wrote:

> So here it goes.

There are still some module license tags missing. I only looked explicitly 
for GPL modules; others might be ok as well.

Patch is against 2.4.18-pre9; I assume 2.5.x also needs this one.
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v

--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=module-license
Content-Transfer-Encoding: 8bit

diff -urN linux-2.4.18-pre9/drivers/block/DAC960.c linux/drivers/block/DAC960.c
--- linux-2.4.18-pre9/drivers/block/DAC960.c	Thu Oct 25 22:58:35 2001
+++ linux/drivers/block/DAC960.c	Fri Feb  8 16:27:14 2002
@@ -7013,3 +7013,5 @@
 
 module_init(DAC960_Initialize);
 module_exit(DAC960_Finalize);
+
+MODULE_LICENSE("GPL");
diff -urN linux-2.4.18-pre9/drivers/isdn/hisax/hisax_fcpcipnp.c linux/drivers/isdn/hisax/hisax_fcpcipnp.c
--- linux-2.4.18-pre9/drivers/isdn/hisax/hisax_fcpcipnp.c	Fri Feb  8 16:26:45 2002
+++ linux/drivers/isdn/hisax/hisax_fcpcipnp.c	Fri Feb  8 16:27:18 2002
@@ -65,6 +65,7 @@
 
 static int protocol = 2;       /* EURO-ISDN Default */
 MODULE_PARM(protocol, "i");
+MODULE_LICENSE("GPL");
 
 // ----------------------------------------------------------------------
 
diff -urN linux-2.4.18-pre9/drivers/isdn/hisax/hisax_isac.c linux/drivers/isdn/hisax/hisax_isac.c
--- linux-2.4.18-pre9/drivers/isdn/hisax/hisax_isac.c	Fri Dec 21 18:41:54 2001
+++ linux/drivers/isdn/hisax/hisax_isac.c	Fri Feb  8 16:27:18 2002
@@ -44,6 +44,7 @@
 
 MODULE_AUTHOR("Kai Germaschewski <kai.germaschewski@gmx.de>/Karsten Keil <kkeil@suse.de>");
 MODULE_DESCRIPTION("ISAC/ISAC-SX driver");
+MODULE_LICENSE("GPL");
 
 #define DBG_WARN      0x0001
 #define DBG_IRQ       0x0002
diff -urN linux-2.4.18-pre9/drivers/mtd/nand/nand_ecc.c linux/drivers/mtd/nand/nand_ecc.c
--- linux-2.4.18-pre9/drivers/mtd/nand/nand_ecc.c	Thu Jun 28 23:43:02 2001
+++ linux/drivers/mtd/nand/nand_ecc.c	Fri Feb  8 16:27:18 2002
@@ -207,3 +207,5 @@
 
 EXPORT_SYMBOL(nand_calculate_ecc);
 EXPORT_SYMBOL(nand_correct_data);
+
+MODULE_LICENSE("GPL");
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/arc-rawmode.c linux/drivers/net/arcnet/arc-rawmode.c
--- linux-2.4.18-pre9/drivers/net/arcnet/arc-rawmode.c	Tue Feb 13 22:15:05 2001
+++ linux/drivers/net/arcnet/arc-rawmode.c	Fri Feb  8 16:27:18 2002
@@ -83,6 +83,7 @@
 	arcnet_unregister_proto(&rawmode_proto);
 }
 
+MODULE_LICENSE("GPL");
 #endif				/* MODULE */
 
 
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/arc-rimi.c linux/drivers/net/arcnet/arc-rimi.c
--- linux-2.4.18-pre9/drivers/net/arcnet/arc-rimi.c	Sun Nov  4 18:31:58 2001
+++ linux/drivers/net/arcnet/arc-rimi.c	Fri Feb  8 16:27:18 2002
@@ -297,6 +297,7 @@
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
 MODULE_PARM(device, "s");
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/arcnet.c linux/drivers/net/arcnet/arcnet.c
--- linux-2.4.18-pre9/drivers/net/arcnet/arcnet.c	Sun Nov  4 18:31:58 2001
+++ linux/drivers/net/arcnet/arcnet.c	Fri Feb  8 16:27:19 2002
@@ -163,6 +163,7 @@
 
 static int debug = ARCNET_DEBUG;
 MODULE_PARM(debug, "i");
+MODULE_LICENSE("GPL");
 
 int __init init_module(void)
 {
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/com20020-isa.c linux/drivers/net/arcnet/com20020-isa.c
--- linux-2.4.18-pre9/drivers/net/arcnet/com20020-isa.c	Sun Nov  4 18:31:58 2001
+++ linux/drivers/net/arcnet/com20020-isa.c	Fri Feb  8 16:27:19 2002
@@ -133,6 +133,7 @@
 MODULE_PARM(backplane, "i");
 MODULE_PARM(clockp, "i");
 MODULE_PARM(clockm, "i");
+MODULE_LICENSE("GPL");
 
 static void com20020isa_open_close(struct net_device *dev, bool open)
 {
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/com20020-pci.c linux/drivers/net/arcnet/com20020-pci.c
--- linux-2.4.18-pre9/drivers/net/arcnet/com20020-pci.c	Fri Dec 21 18:41:54 2001
+++ linux/drivers/net/arcnet/com20020-pci.c	Fri Feb  8 16:27:19 2002
@@ -57,6 +57,7 @@
 MODULE_PARM(backplane, "i");
 MODULE_PARM(clockp, "i");
 MODULE_PARM(clockm, "i");
+MODULE_LICENSE("GPL");
 
 static void com20020pci_open_close(struct net_device *dev, bool open)
 {
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/com20020.c linux/drivers/net/arcnet/com20020.c
--- linux-2.4.18-pre9/drivers/net/arcnet/com20020.c	Sun Nov  4 18:31:58 2001
+++ linux/drivers/net/arcnet/com20020.c	Fri Feb  8 16:27:19 2002
@@ -356,6 +356,8 @@
 EXPORT_SYMBOL(com20020_found);
 EXPORT_SYMBOL(com20020_remove);
 
+MODULE_LICENSE("GPL");
+
 int init_module(void)
 {
 	BUGLVL(D_NORMAL) printk(VERSION);
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/com90io.c linux/drivers/net/arcnet/com90io.c
--- linux-2.4.18-pre9/drivers/net/arcnet/com90io.c	Fri Feb  8 16:26:46 2002
+++ linux/drivers/net/arcnet/com90io.c	Fri Feb  8 16:27:19 2002
@@ -383,6 +383,7 @@
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
 MODULE_PARM(device, "s");
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/com90xx.c linux/drivers/net/arcnet/com90xx.c
--- linux-2.4.18-pre9/drivers/net/arcnet/com90xx.c	Sun Nov  4 18:31:58 2001
+++ linux/drivers/net/arcnet/com90xx.c	Fri Feb  8 16:27:19 2002
@@ -619,6 +619,7 @@
 MODULE_PARM(irq, "i");
 MODULE_PARM(shmem, "i");
 MODULE_PARM(device, "s");
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/rfc1051.c linux/drivers/net/arcnet/rfc1051.c
--- linux-2.4.18-pre9/drivers/net/arcnet/rfc1051.c	Tue Feb 13 22:15:05 2001
+++ linux/drivers/net/arcnet/rfc1051.c	Fri Feb  8 16:27:19 2002
@@ -68,6 +68,8 @@
 
 #ifdef MODULE
 
+MODULE_LICENSE("GPL");
+
 int __init init_module(void)
 {
 	printk(VERSION);
diff -urN linux-2.4.18-pre9/drivers/net/arcnet/rfc1201.c linux/drivers/net/arcnet/rfc1201.c
--- linux-2.4.18-pre9/drivers/net/arcnet/rfc1201.c	Tue Feb 13 22:15:05 2001
+++ linux/drivers/net/arcnet/rfc1201.c	Fri Feb  8 16:27:19 2002
@@ -70,6 +70,8 @@
 
 #ifdef MODULE
 
+MODULE_LICENSE("GPL");
+
 int __init init_module(void)
 {
 	printk(VERSION);
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/6pack.c linux/drivers/net/hamradio/6pack.c
--- linux-2.4.18-pre9/drivers/net/hamradio/6pack.c	Fri Feb  8 16:26:46 2002
+++ linux/drivers/net/hamradio/6pack.c	Fri Feb  8 16:27:19 2002
@@ -1062,6 +1062,7 @@
 
 MODULE_AUTHOR("Andreas Könsgen <ajk@ccac.rwth-aachen.de>");
 MODULE_DESCRIPTION("6pack driver for AX.25");
+MODULE_LICENSE("GPL");
 
 module_init(sixpack_init_driver);
 module_exit(sixpack_exit_driver);
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/baycom_epp.c linux/drivers/net/hamradio/baycom_epp.c
--- linux-2.4.18-pre9/drivers/net/hamradio/baycom_epp.c	Mon Sep 10 18:04:53 2001
+++ linux/drivers/net/hamradio/baycom_epp.c	Fri Feb  8 16:27:19 2002
@@ -1414,6 +1414,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Baycom epp amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/baycom_par.c linux/drivers/net/hamradio/baycom_par.c
--- linux-2.4.18-pre9/drivers/net/hamradio/baycom_par.c	Wed Aug 15 10:22:15 2001
+++ linux/drivers/net/hamradio/baycom_par.c	Fri Feb  8 16:27:19 2002
@@ -493,6 +493,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Baycom par96 and picpar amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/baycom_ser_fdx.c linux/drivers/net/hamradio/baycom_ser_fdx.c
--- linux-2.4.18-pre9/drivers/net/hamradio/baycom_ser_fdx.c	Wed Aug 15 10:22:15 2001
+++ linux/drivers/net/hamradio/baycom_ser_fdx.c	Fri Feb  8 16:27:19 2002
@@ -609,6 +609,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Baycom ser12 full duplex amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/baycom_ser_hdx.c linux/drivers/net/hamradio/baycom_ser_hdx.c
--- linux-2.4.18-pre9/drivers/net/hamradio/baycom_ser_hdx.c	Wed Aug 15 10:22:15 2001
+++ linux/drivers/net/hamradio/baycom_ser_hdx.c	Fri Feb  8 16:27:19 2002
@@ -649,6 +649,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Baycom ser12 half duplex amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/bpqether.c linux/drivers/net/hamradio/bpqether.c
--- linux-2.4.18-pre9/drivers/net/hamradio/bpqether.c	Fri Sep 14 01:04:43 2001
+++ linux/drivers/net/hamradio/bpqether.c	Fri Feb  8 16:27:19 2002
@@ -645,5 +645,6 @@
 
 MODULE_AUTHOR("Joerg Reuter DL1BKE <jreuter@yaina.de>");
 MODULE_DESCRIPTION("Transmit and receive AX.25 packets over Ethernet");
+MODULE_LICENSE("GPL");
 module_init(bpq_init_driver);
 module_exit(bpq_cleanup_driver);
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/dmascc.c linux/drivers/net/hamradio/dmascc.c
--- linux-2.4.18-pre9/drivers/net/hamradio/dmascc.c	Wed Apr 18 23:40:06 2001
+++ linux/drivers/net/hamradio/dmascc.c	Fri Feb  8 16:27:19 2002
@@ -306,6 +306,7 @@
 MODULE_AUTHOR("Klaus Kudielka");
 MODULE_DESCRIPTION("Driver for high-speed SCC boards");
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NUM_DEVS) "i");
+MODULE_LICENSE("GPL");
 
 
 int init_module(void) {
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/hdlcdrv.c linux/drivers/net/hamradio/hdlcdrv.c
--- linux-2.4.18-pre9/drivers/net/hamradio/hdlcdrv.c	Wed Aug 15 10:22:15 2001
+++ linux/drivers/net/hamradio/hdlcdrv.c	Fri Feb  8 16:27:19 2002
@@ -901,6 +901,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Packet Radio network interface HDLC encoder/decoder");
+MODULE_LICENSE("GPL");
 module_init(hdlcdrv_init_driver);
 module_exit(hdlcdrv_cleanup_driver);
 
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/mkiss.c linux/drivers/net/hamradio/mkiss.c
--- linux-2.4.18-pre9/drivers/net/hamradio/mkiss.c	Fri Sep 14 01:04:43 2001
+++ linux/drivers/net/hamradio/mkiss.c	Fri Feb  8 16:27:19 2002
@@ -1008,6 +1008,7 @@
 MODULE_DESCRIPTION("KISS driver for AX.25 over TTYs");
 MODULE_PARM(ax25_maxdev, "i");
 MODULE_PARM_DESC(ax25_maxdev, "number of MKISS devices");
+MODULE_LICENSE("GPL");
 
 module_init(mkiss_init_driver);
 module_exit(mkiss_exit_driver);
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/scc.c linux/drivers/net/hamradio/scc.c
--- linux-2.4.18-pre9/drivers/net/hamradio/scc.c	Thu Oct 25 22:58:15 2001
+++ linux/drivers/net/hamradio/scc.c	Fri Feb  8 16:27:19 2002
@@ -2179,5 +2179,6 @@
 MODULE_AUTHOR("Joerg Reuter <jreuter@yaina.de>");
 MODULE_DESCRIPTION("AX.25 Device Driver for Z8530 based HDLC cards");
 MODULE_SUPPORTED_DEVICE("Z8530 based SCC cards for Amateur Radio");
+MODULE_LICENSE("GPL");
 module_init(scc_init_driver);
 module_exit(scc_cleanup_driver);
diff -urN linux-2.4.18-pre9/drivers/net/hamradio/yam.c linux/drivers/net/hamradio/yam.c
--- linux-2.4.18-pre9/drivers/net/hamradio/yam.c	Fri Feb  8 16:26:46 2002
+++ linux/drivers/net/hamradio/yam.c	Fri Feb  8 16:27:19 2002
@@ -1177,6 +1177,7 @@
 
 MODULE_AUTHOR("Frederic Rible F1OAT frible@teaser.fr");
 MODULE_DESCRIPTION("Yam amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 module_init(yam_init_driver);
 module_exit(yam_cleanup_driver);
diff -urN linux-2.4.18-pre9/drivers/net/irda/irda-usb.c linux/drivers/net/irda/irda-usb.c
--- linux-2.4.18-pre9/drivers/net/irda/irda-usb.c	Fri Feb  8 16:26:46 2002
+++ linux/drivers/net/irda/irda-usb.c	Fri Feb  8 16:27:19 2002
@@ -1582,3 +1582,4 @@
 MODULE_PARM_DESC(qos_mtt_bits, "Minimum Turn Time");
 MODULE_AUTHOR("Roman Weissgaerber <weissg@vienna.at>, Dag Brattli <dag@brattli.net> and Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("IrDA-USB Dongle Driver"); 
+MODULE_LICENSE("GPL");
diff -urN linux-2.4.18-pre9/drivers/net/pcmcia/com20020_cs.c linux/drivers/net/pcmcia/com20020_cs.c
--- linux-2.4.18-pre9/drivers/net/pcmcia/com20020_cs.c	Wed Apr 18 23:40:05 2001
+++ linux/drivers/net/pcmcia/com20020_cs.c	Fri Feb  8 16:27:23 2002
@@ -122,6 +122,7 @@
 
 MODULE_PARM(irq_mask, "i");
 MODULE_PARM(irq_list, "1-4i");
+MODULE_LICENSE("GPL");
 
 /*====================================================================*/
 
diff -urN linux-2.4.18-pre9/drivers/net/rrunner.c linux/drivers/net/rrunner.c
--- linux-2.4.18-pre9/drivers/net/rrunner.c	Fri Nov  9 22:45:35 2001
+++ linux/drivers/net/rrunner.c	Fri Feb  8 16:27:23 2002
@@ -269,6 +269,7 @@
 #if LINUX_VERSION_CODE > 0x20118
 MODULE_AUTHOR("Jes Sorensen <Jes.Sorensen@cern.ch>");
 MODULE_DESCRIPTION("Essential RoadRunner HIPPI driver");
+MODULE_LICENSE("GPL");
 #endif
 
 int init_module(void)
diff -urN linux-2.4.18-pre9/drivers/scsi/ips.c linux/drivers/scsi/ips.c
--- linux-2.4.18-pre9/drivers/scsi/ips.c	Fri Feb  8 16:26:48 2002
+++ linux/drivers/scsi/ips.c	Fri Feb  8 16:27:33 2002
@@ -191,6 +191,7 @@
 #ifdef MODULE
    static char *ips = NULL;
    MODULE_PARM(ips, "s");
+   MODULE_LICENSE("GPL");
 #endif
 
 /*
diff -urN linux-2.4.18-pre9/fs/hfs/super.c linux/fs/hfs/super.c
--- linux-2.4.18-pre9/fs/hfs/super.c	Fri Feb  8 16:26:51 2002
+++ linux/fs/hfs/super.c	Fri Feb  8 16:27:39 2002
@@ -32,6 +32,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
+MODULE_LICENSE("GPL");
+
 /*================ Forward declarations ================*/
 
 static void hfs_read_inode(struct inode *);
diff -urN linux-2.4.18-pre9/net/8021q/vlan.c linux/net/8021q/vlan.c
--- linux-2.4.18-pre9/net/8021q/vlan.c	Fri Dec 21 18:42:05 2001
+++ linux/net/8021q/vlan.c	Fri Feb  8 16:27:39 2002
@@ -636,4 +636,4 @@
 	return err;
 }
 
-
+MODULE_LICENSE("GPL");
diff -urN linux-2.4.18-pre9/net/atm/pppoatm.c linux/net/atm/pppoatm.c
--- linux-2.4.18-pre9/net/atm/pppoatm.c	Fri Nov  9 23:11:15 2001
+++ linux/net/atm/pppoatm.c	Fri Feb  8 16:27:39 2002
@@ -363,3 +363,4 @@
 
 MODULE_AUTHOR("Mitchell Blank Jr <mitch@sfgoth.com>");
 MODULE_DESCRIPTION("RFC2364 PPP over ATM/AAL5");
+MODULE_LICENSE("GPL");
diff -urN linux-2.4.18-pre9/net/ax25/af_ax25.c linux/net/ax25/af_ax25.c
--- linux-2.4.18-pre9/net/ax25/af_ax25.c	Fri Feb  8 16:26:53 2002
+++ linux/net/ax25/af_ax25.c	Fri Feb  8 16:27:39 2002
@@ -1863,6 +1863,7 @@
 
 MODULE_AUTHOR("Jonathan Naylor G4KLX <g4klx@g4klx.demon.co.uk>");
 MODULE_DESCRIPTION("The amateur radio AX.25 link layer protocol");
+MODULE_LICENSE("GPL");
 
 static void __exit ax25_exit(void)
 {
diff -urN linux-2.4.18-pre9/net/econet/af_econet.c linux/net/econet/af_econet.c
--- linux-2.4.18-pre9/net/econet/af_econet.c	Sat Jun 30 04:38:26 2001
+++ linux/net/econet/af_econet.c	Fri Feb  8 16:27:39 2002
@@ -1128,3 +1128,5 @@
 
 module_init(econet_proto_init);
 module_exit(econet_proto_exit);
+
+MODULE_LICENSE("GPL");
diff -urN linux-2.4.18-pre9/net/khttpd/main.c linux/net/khttpd/main.c
--- linux-2.4.18-pre9/net/khttpd/main.c	Mon Mar 26 04:14:25 2001
+++ linux/net/khttpd/main.c	Fri Feb  8 16:27:39 2002
@@ -390,3 +390,5 @@
 
 	module_init(khttpd_init)
 	module_exit(khttpd_cleanup)
+
+	MODULE_LICENSE("GPL");
diff -urN linux-2.4.18-pre9/net/lapb/lapb_iface.c linux/net/lapb/lapb_iface.c
--- linux-2.4.18-pre9/net/lapb/lapb_iface.c	Fri Sep  7 18:28:38 2001
+++ linux/net/lapb/lapb_iface.c	Fri Feb  8 16:27:39 2002
@@ -407,5 +407,6 @@
 
 MODULE_AUTHOR("Jonathan Naylor <g4klx@g4klx.demon.co.uk>");
 MODULE_DESCRIPTION("The X.25 Link Access Procedure B link layer protocol");
+MODULE_LICENSE("GPL");
 
 module_init(lapb_init);
diff -urN linux-2.4.18-pre9/net/netlink/netlink_dev.c linux/net/netlink/netlink_dev.c
--- linux-2.4.18-pre9/net/netlink/netlink_dev.c	Fri Dec 21 18:42:06 2001
+++ linux/net/netlink/netlink_dev.c	Fri Feb  8 16:27:39 2002
@@ -211,6 +211,8 @@
 
 #ifdef MODULE
 
+MODULE_LICENSE("GPL");
+
 int init_module(void)
 {
 	printk(KERN_INFO "Network Kernel/User communications module 0.04\n");
diff -urN linux-2.4.18-pre9/net/netrom/af_netrom.c linux/net/netrom/af_netrom.c
--- linux-2.4.18-pre9/net/netrom/af_netrom.c	Fri Feb  8 16:26:53 2002
+++ linux/net/netrom/af_netrom.c	Fri Feb  8 16:27:39 2002
@@ -1336,6 +1336,7 @@
 
 MODULE_AUTHOR("Jonathan Naylor G4KLX <g4klx@g4klx.demon.co.uk>");
 MODULE_DESCRIPTION("The amateur radio NET/ROM network and transport layer protocol");
+MODULE_LICENSE("GPL");
 
 static void __exit nr_exit(void)
 {
diff -urN linux-2.4.18-pre9/net/rose/af_rose.c linux/net/rose/af_rose.c
--- linux-2.4.18-pre9/net/rose/af_rose.c	Fri Feb  8 16:26:53 2002
+++ linux/net/rose/af_rose.c	Fri Feb  8 16:27:39 2002
@@ -1488,6 +1488,7 @@
 
 MODULE_AUTHOR("Jonathan Naylor G4KLX <g4klx@g4klx.demon.co.uk>");
 MODULE_DESCRIPTION("The amateur radio ROSE network layer protocol");
+MODULE_LICENSE("GPL");
 
 static void __exit rose_exit(void)
 {
diff -urN linux-2.4.18-pre9/net/x25/af_x25.c linux/net/x25/af_x25.c
--- linux-2.4.18-pre9/net/x25/af_x25.c	Mon Sep 10 16:58:35 2001
+++ linux/net/x25/af_x25.c	Fri Feb  8 16:27:39 2002
@@ -1357,6 +1357,7 @@
 
 MODULE_AUTHOR("Jonathan Naylor <g4klx@g4klx.demon.co.uk>");
 MODULE_DESCRIPTION("The X.25 Packet Layer network layer protocol");
+MODULE_LICENSE("GPL");
 
 static void __exit x25_exit(void)
 {

--A9z/3b/E4MkkD+7G--
