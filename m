Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274505AbRJNGgT>; Sun, 14 Oct 2001 02:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274509AbRJNGgK>; Sun, 14 Oct 2001 02:36:10 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:44048 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S274505AbRJNGgA>;
	Sun, 14 Oct 2001 02:36:00 -0400
Message-ID: <3BC932B1.60701@si.rr.com>
Date: Sun, 14 Oct 2001 02:37:37 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.12-ac1: more MODULE_LICENSE patches for net
Content-Type: multipart/mixed;
 boundary="------------080407010509080303090606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080407010509080303090606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   I have attached some MODULE_LICENSE patches against 2.4.12-ac1 . 
These are some of the patches for drivers/net . Please review.
Regards,
Frank

--------------080407010509080303090606
Content-Type: text/plain;
 name="6PACK"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="6PACK"

--- drivers/net/hamradio/6pack.c.old	Sun Sep 30 20:39:00 2001
+++ drivers/net/hamradio/6pack.c	Sun Oct 14 01:48:37 2001
@@ -1063,6 +1063,7 @@
 
 MODULE_AUTHOR("Andreas Könsgen <ajk@ccac.rwth-aachen.de>");
 MODULE_DESCRIPTION("6pack driver for AX.25");
+MODULE_LICENSE("GPL");
 
 module_init(sixpack_init_driver);
 module_exit(sixpack_exit_driver);

--------------080407010509080303090606
Content-Type: text/plain;
 name="ARCNET"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ARCNET"

--- drivers/net/arcnet/arcnet.c.old	Wed Apr 18 17:40:06 2001
+++ drivers/net/arcnet/arcnet.c	Sun Oct 14 01:34:36 2001
@@ -163,6 +163,7 @@
 
 static int debug = ARCNET_DEBUG;
 MODULE_PARM(debug, "i");
+MODULE_LICENSE("GPL");
 
 int __init init_module(void)
 {

--------------080407010509080303090606
Content-Type: text/plain;
 name="ARC-RAWM"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ARC-RAWM"

--- drivers/net/arcnet/arc-rawmode.c.old	Tue Feb 13 16:15:05 2001
+++ drivers/net/arcnet/arc-rawmode.c	Sun Oct 14 01:31:23 2001
@@ -70,6 +70,7 @@
 
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
 
 int __init init_module(void)
 {

--------------080407010509080303090606
Content-Type: text/plain;
 name="ARC-RIMI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ARC-RIMI"

--- drivers/net/arcnet/arc-rimi.c.old	Tue Feb 13 16:15:05 2001
+++ drivers/net/arcnet/arc-rimi.c	Sun Oct 14 01:33:11 2001
@@ -297,6 +297,7 @@
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
 MODULE_PARM(device, "s");
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {

--------------080407010509080303090606
Content-Type: text/plain;
 name="BAYCOM_E"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BAYCOM_E"

--- drivers/net/hamradio/baycom_epp.c.old	Sun Sep 30 20:39:00 2001
+++ drivers/net/hamradio/baycom_epp.c	Sun Oct 14 01:50:00 2001
@@ -1414,6 +1414,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Baycom epp amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 

--------------080407010509080303090606
Content-Type: text/plain;
 name="BAYCOM_P"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BAYCOM_P"

--- drivers/net/hamradio/baycom_par.c.old	Sun Sep 16 17:46:11 2001
+++ drivers/net/hamradio/baycom_par.c	Sun Oct 14 01:51:24 2001
@@ -493,6 +493,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Baycom par96 and picpar amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 

--------------080407010509080303090606
Content-Type: text/plain;
 name="BAYCOM1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BAYCOM1"

--- drivers/net/hamradio/baycom_ser_fdx.c.old	Sun Sep 16 17:46:11 2001
+++ drivers/net/hamradio/baycom_ser_fdx.c	Sun Oct 14 01:59:44 2001
@@ -609,6 +609,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Baycom ser12 full duplex amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 

--------------080407010509080303090606
Content-Type: text/plain;
 name="BAYCOM2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BAYCOM2"

--- drivers/net/hamradio/baycom_ser_hdx.c.old	Sun Sep 16 17:46:11 2001
+++ drivers/net/hamradio/baycom_ser_hdx.c	Sun Oct 14 02:01:19 2001
@@ -649,6 +649,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Baycom ser12 half duplex amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 

--------------080407010509080303090606
Content-Type: text/plain;
 name="BPQETHER"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BPQETHER"

--- drivers/net/hamradio/bpqether.c.old	Sun Sep 30 20:39:00 2001
+++ drivers/net/hamradio/bpqether.c	Sun Oct 14 01:58:25 2001
@@ -645,5 +645,6 @@
 
 MODULE_AUTHOR("Joerg Reuter DL1BKE <jreuter@yaina.de>");
 MODULE_DESCRIPTION("Transmit and receive AX.25 packets over Ethernet");
+MODULE_LICENSE("GPL");
 module_init(bpq_init_driver);
 module_exit(bpq_cleanup_driver);

--------------080407010509080303090606
Content-Type: text/plain;
 name="COM90IO"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="COM90IO"

--- drivers/net/arcnet/com90io.c.old	Wed Apr 18 17:40:05 2001
+++ drivers/net/arcnet/com90io.c	Sun Oct 14 01:41:06 2001
@@ -380,6 +380,7 @@
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
 MODULE_PARM(device, "s");
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {

--------------080407010509080303090606
Content-Type: text/plain;
 name="COMM1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="COMM1"

--- drivers/net/arcnet/com20020.c.old	Tue Feb 13 16:15:05 2001
+++ drivers/net/arcnet/com20020.c	Sun Oct 14 01:39:45 2001
@@ -355,6 +355,7 @@
 EXPORT_SYMBOL(com20020_check);
 EXPORT_SYMBOL(com20020_found);
 EXPORT_SYMBOL(com20020_remove);
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {

--------------080407010509080303090606
Content-Type: text/plain;
 name="COMM2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="COMM2"

--- drivers/net/arcnet/com20020-isa.c.old	Tue Feb 13 16:15:05 2001
+++ drivers/net/arcnet/com20020-isa.c	Sun Oct 14 01:36:10 2001
@@ -133,6 +133,7 @@
 MODULE_PARM(backplane, "i");
 MODULE_PARM(clockp, "i");
 MODULE_PARM(clockm, "i");
+MODULE_LICENSE("GPL");
 
 static void com20020isa_open_close(struct net_device *dev, bool open)
 {

--------------080407010509080303090606
Content-Type: text/plain;
 name="COMM3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="COMM3"

--- drivers/net/arcnet/com20020-pci.c.old	Wed Apr 18 17:40:05 2001
+++ drivers/net/arcnet/com20020-pci.c	Sun Oct 14 01:38:03 2001
@@ -177,5 +177,6 @@
 	pci_unregister_driver(&com20020pci_driver);
 }
 
-module_init(com20020pci_init)
-module_exit(com20020pci_cleanup)
+module_init(com20020pci_init);
+module_exit(com20020pci_cleanup);
+MODULE_LICENSE("GPL");

--------------080407010509080303090606
Content-Type: text/plain;
 name="DMASCC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMASCC"

--- drivers/net/hamradio/dmascc.c.old	Wed Apr 18 17:40:06 2001
+++ drivers/net/hamradio/dmascc.c	Sun Oct 14 01:57:22 2001
@@ -305,6 +305,7 @@
 
 MODULE_AUTHOR("Klaus Kudielka");
 MODULE_DESCRIPTION("Driver for high-speed SCC boards");
+MODULE_LICENSE("GPL");
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NUM_DEVS) "i");
 
 

--------------080407010509080303090606
Content-Type: text/plain;
 name="HDLCDRV"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HDLCDRV"

--- drivers/net/hamradio/hdlcdrv.c.old	Sun Sep 16 17:46:11 2001
+++ drivers/net/hamradio/hdlcdrv.c	Sun Oct 14 01:56:09 2001
@@ -901,6 +901,7 @@
 
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Packet Radio network interface HDLC encoder/decoder");
+MODULE_LICENSE("GPL");
 module_init(hdlcdrv_init_driver);
 module_exit(hdlcdrv_cleanup_driver);
 

--------------080407010509080303090606
Content-Type: text/plain;
 name="MKISS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MKISS"

--- drivers/net/hamradio/mkiss.c.old	Sun Sep 30 20:39:00 2001
+++ drivers/net/hamradio/mkiss.c	Sun Oct 14 01:54:57 2001
@@ -1008,6 +1008,7 @@
 MODULE_DESCRIPTION("KISS driver for AX.25 over TTYs");
 MODULE_PARM(ax25_maxdev, "i");
 MODULE_PARM_DESC(ax25_maxdev, "number of MKISS devices");
+MODULE_LICENSE("GPL");
 
 module_init(mkiss_init_driver);
 module_exit(mkiss_exit_driver);

--------------080407010509080303090606
Content-Type: text/plain;
 name="RFC1051"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RFC1051"

--- drivers/net/arcnet/rfc1051.c.old	Tue Feb 13 16:15:05 2001
+++ drivers/net/arcnet/rfc1051.c	Sun Oct 14 01:42:54 2001
@@ -67,6 +67,7 @@
 
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
 
 int __init init_module(void)
 {

--------------080407010509080303090606
Content-Type: text/plain;
 name="RFC1201"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RFC1201"

--- drivers/net/arcnet/rfc1201.c.old	Tue Feb 13 16:15:05 2001
+++ drivers/net/arcnet/rfc1201.c	Sun Oct 14 01:44:08 2001
@@ -69,6 +69,7 @@
 
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
 
 int __init init_module(void)
 {

--------------080407010509080303090606
Content-Type: text/plain;
 name="SCC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SCC"

--- drivers/net/hamradio/scc.c.old	Sun Sep 30 20:39:00 2001
+++ drivers/net/hamradio/scc.c	Sun Oct 14 01:53:55 2001
@@ -2179,5 +2179,6 @@
 MODULE_AUTHOR("Joerg Reuter <jreuter@yaina.de>");
 MODULE_DESCRIPTION("AX.25 Device Driver for Z8530 based HDLC cards");
 MODULE_SUPPORTED_DEVICE("Z8530 based SCC cards for Amateur Radio");
+MODULE_LICENSE("GPL");
 module_init(scc_init_driver);
 module_exit(scc_cleanup_driver);

--------------080407010509080303090606
Content-Type: text/plain;
 name="SM"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SM"

--- drivers/net/hamradio/soundmodem/sm.c.old	Wed Apr 18 17:40:05 2001
+++ drivers/net/hamradio/soundmodem/sm.c	Sun Oct 14 01:46:57 2001
@@ -714,6 +714,7 @@
 
 module_init(init_soundmodem);
 module_exit(cleanup_soundmodem);
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 

--------------080407010509080303090606
Content-Type: text/plain;
 name="YAM"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="YAM"

--- drivers/net/hamradio/yam.c.old	Fri Oct 12 18:37:11 2001
+++ drivers/net/hamradio/yam.c	Sun Oct 14 01:52:43 2001
@@ -1177,6 +1177,7 @@
 
 MODULE_AUTHOR("Frederic Rible F1OAT frible@teaser.fr");
 MODULE_DESCRIPTION("Yam amateur radio modem driver");
+MODULE_LICENSE("GPL");
 
 module_init(yam_init_driver);
 module_exit(yam_cleanup_driver);

--------------080407010509080303090606--

