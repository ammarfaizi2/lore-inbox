Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276957AbRJNRrC>; Sun, 14 Oct 2001 13:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277048AbRJNRqy>; Sun, 14 Oct 2001 13:46:54 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:58633 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S276957AbRJNRqm>;
	Sun, 14 Oct 2001 13:46:42 -0400
Message-ID: <3BC9CFE1.80800@si.rr.com>
Date: Sun, 14 Oct 2001 13:48:17 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.12-ac1: more MODULE_LICENSE patches
Content-Type: multipart/mixed;
 boundary="------------090408050308090301090709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090408050308090301090709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
     I've attached a few more drivers/net MODULE_LICENSE patches against 
2.4.12-ac1 . Pleae review.
Regards,
Frank

--------------090408050308090301090709
Content-Type: text/plain;
 name="HYDRA"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HYDRA"

--- drivers/net/hydra.c.old	Thu Apr 12 15:15:25 2001
+++ drivers/net/hydra.c	Sun Oct 14 12:53:13 2001
@@ -254,3 +254,4 @@
 
 module_init(hydra_probe);
 module_exit(hydra_cleanup);
+MODULE_LICENSE("GPL");

--------------090408050308090301090709
Content-Type: text/plain;
 name="IBMLANA"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IBMLANA"

--- drivers/net/ibmlana.c.old	Wed Jun 20 14:10:53 2001
+++ drivers/net/ibmlana.c	Sun Oct 14 12:54:45 2001
@@ -1199,6 +1199,7 @@
 MODULE_PARM(io, "i");
 MODULE_PARM_DESC(irq, "IBM LAN/A IRQ number");
 MODULE_PARM_DESC(io, "IBM LAN/A I/O base address");
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {

--------------090408050308090301090709
Content-Type: text/plain;
 name="IOC3-ETH"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IOC3-ETH"

--- drivers/net/ioc3-eth.c.old	Sun Sep 30 20:39:01 2001
+++ drivers/net/ioc3-eth.c	Sun Oct 14 12:55:53 2001
@@ -1817,6 +1817,7 @@
 
 MODULE_AUTHOR("Ralf Baechle <ralf@oss.sgi.com>");
 MODULE_DESCRIPTION("SGI IOC3 Ethernet driver");
+MODULE_LICENSE("GPL");
 
 module_init(ioc3_init_module);
 module_exit(ioc3_cleanup_module);

--------------090408050308090301090709
Content-Type: text/plain;
 name="ISA-SKEL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ISA-SKEL"

--- drivers/net/isa-skeleton.c.old	Tue Jul 17 21:53:55 2001
+++ drivers/net/isa-skeleton.c	Sun Oct 14 12:56:54 2001
@@ -636,6 +636,7 @@
 static int irq;
 static int dma;
 static int mem;
+MODULE_LICENSE("GPL");
 
 int init_module(void)
 {

--------------090408050308090301090709
Content-Type: text/plain;
 name="LASI_825"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="LASI_825"

--- drivers/net/lasi_82596.c.old	Mon Aug 27 11:53:07 2001
+++ drivers/net/lasi_82596.c	Sun Oct 14 12:58:05 2001
@@ -180,6 +180,7 @@
 
 MODULE_AUTHOR("Richard Hirst");
 MODULE_DESCRIPTION("i82596 driver");
+MODULE_LICENSE("GPL");
 MODULE_PARM(i596_debug, "i");
 MODULE_PARM_DESC(i596_debug, "lasi_82596 debug mask");
 

--------------090408050308090301090709
Content-Type: text/plain;
 name="NE2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="NE2"

--- drivers/net/ne2.c.old	Sun Aug  5 16:12:40 2001
+++ drivers/net/ne2.c	Sun Oct 14 13:00:49 2001
@@ -744,6 +744,7 @@
 static int io[MAX_NE_CARDS];
 static int irq[MAX_NE_CARDS];
 static int bad[MAX_NE_CARDS];	/* 0xbad = bad sig or no reset ack */
+MODULE_LICENSE("GPL");
 
 #ifdef MODULE_PARM
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");

--------------090408050308090301090709
Content-Type: text/plain;
 name="OAKNET"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="OAKNET"

--- drivers/net/oaknet.c.old	Sat Mar  3 13:55:47 2001
+++ drivers/net/oaknet.c	Sun Oct 14 13:02:19 2001
@@ -696,3 +696,4 @@
 
 module_init(oaknet_init_module);
 module_exit(oaknet_cleanup_module);
+MODULE_LICENSE("GPL");

--------------090408050308090301090709
Content-Type: text/plain;
 name="PCI-SKEL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PCI-SKEL"

--- drivers/net/pci-skeleton.c.old	Tue Aug  7 11:30:50 2001
+++ drivers/net/pci-skeleton.c	Sun Oct 14 13:04:30 2001
@@ -484,6 +484,7 @@
 
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@mandrakesoft.com>");
 MODULE_DESCRIPTION ("Skeleton for a PCI Fast Ethernet driver");
+MODULE_LICENSE("GPL");
 MODULE_PARM (multicast_filter_limit, "i");
 MODULE_PARM (max_interrupt_work, "i");
 MODULE_PARM (debug, "i");

--------------090408050308090301090709
Content-Type: text/plain;
 name="RRUNNER"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RRUNNER"

--- drivers/net/rrunner.c.old	Wed Jul  4 14:50:39 2001
+++ drivers/net/rrunner.c	Sun Oct 14 13:06:12 2001
@@ -269,6 +269,7 @@
 #if LINUX_VERSION_CODE > 0x20118
 MODULE_AUTHOR("Jes Sorensen <Jes.Sorensen@cern.ch>");
 MODULE_DESCRIPTION("Essential RoadRunner HIPPI driver");
+MODULE_LICENSE("GPL");
 #endif
 
 int init_module(void)

--------------090408050308090301090709
Content-Type: text/plain;
 name="SAA9730"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SAA9730"

--- drivers/net/saa9730.c.old	Mon Jul  2 17:03:04 2001
+++ drivers/net/saa9730.c	Sun Oct 14 13:07:33 2001
@@ -1080,3 +1080,5 @@
 }
 
 module_init(saa9730_probe);
+//Shouldn't this have a module_exit ? 
+MODULE_LICENSE("GPL");

--------------090408050308090301090709
Content-Type: text/plain;
 name="SEEQ8005"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SEEQ8005"

--- drivers/net/seeq8005.c.old	Wed Jun 20 14:10:53 2001
+++ drivers/net/seeq8005.c	Sun Oct 14 13:09:01 2001
@@ -711,6 +711,7 @@
 static struct net_device dev_seeq = { init: seeq8005_probe };
 static int io = 0x320;
 static int irq = 10;
+MODULE_LICENSE("GPL");
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
 MODULE_PARM_DESC(io, "SEEQ 8005 I/O base address");

--------------090408050308090301090709
Content-Type: text/plain;
 name="SK_G16"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SK_G16"

--- drivers/net/sk_g16.c.old	Wed Jul  4 14:50:39 2001
+++ drivers/net/sk_g16.c	Sun Oct 14 13:10:28 2001
@@ -616,6 +616,7 @@
 
 MODULE_AUTHOR("Patrick J.D. Weichmann");
 MODULE_DESCRIPTION("Schneider & Koch G16 Ethernet Device Driver");
+MODULE_LICENSE("GPL");
 MODULE_PARM(io, "i");
 MODULE_PARM_DESC(io, "0 to probe common ports (unsafe), or the I/O base of the board");
 

--------------090408050308090301090709
Content-Type: text/plain;
 name="SK_MCA"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SK_MCA"

--- drivers/net/sk_mca.c.old	Wed Jul  4 14:50:39 2001
+++ drivers/net/sk_mca.c	Sun Oct 14 13:11:41 2001
@@ -1229,6 +1229,7 @@
  * ------------------------------------------------------------------------ */
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
 
 #define DEVMAX 5
 

--------------090408050308090301090709
Content-Type: text/plain;
 name="SMC9194"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SMC9194"

--- drivers/net/smc9194.c.old	Sun Sep 30 20:39:05 2001
+++ drivers/net/smc9194.c	Sun Oct 14 13:14:40 2001
@@ -1558,6 +1558,7 @@
 static int io;
 static int irq;
 static int ifport;
+MODULE_LICENSE("GPL");
 
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");

--------------090408050308090301090709
Content-Type: text/plain;
 name="SMC-MCA"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SMC-MCA"

--- drivers/net/smc-mca.c.old	Mon Aug 27 11:53:08 2001
+++ drivers/net/smc-mca.c	Sun Oct 14 13:13:30 2001
@@ -437,6 +437,7 @@
 static struct net_device dev_ultra[MAX_ULTRAMCA_CARDS];
 static int io[MAX_ULTRAMCA_CARDS];
 static int irq[MAX_ULTRAMCA_CARDS];
+MODULE_LICENSE("GPL");
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_ULTRAMCA_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_ULTRAMCA_CARDS) "i");

--------------090408050308090301090709
Content-Type: text/plain;
 name="STNIC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="STNIC"

--- drivers/net/stnic.c.old	Tue Jul 10 23:16:30 2001
+++ drivers/net/stnic.c	Sun Oct 14 13:15:48 2001
@@ -316,3 +316,4 @@
 
 module_init(stnic_probe);
 /* No cleanup routine. */
+MODULE_LICENSE("GPL");

--------------090408050308090301090709
Content-Type: text/plain;
 name="SUN3LANC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SUN3LANC"

--- drivers/net/sun3lance.c.old	Wed Jul  4 14:50:39 2001
+++ drivers/net/sun3lance.c	Sun Oct 14 13:20:54 2001
@@ -71,6 +71,7 @@
 #endif
 MODULE_PARM(lance_debug, "i");
 MODULE_PARM_DESC(lance_debug, "SUN3 Lance debug level (0-3)");
+MODULE_LICENSE("GPL");
 
 #define	DPRINTK(n,a) \
 	do {  \

--------------090408050308090301090709
Content-Type: text/plain;
 name="SUNBMAC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SUNBMAC"

--- drivers/net/sunbmac.c.old	Fri Apr 27 01:17:25 2001
+++ drivers/net/sunbmac.c	Sun Oct 14 13:19:45 2001
@@ -1301,3 +1301,4 @@
 
 module_init(bigmac_probe);
 module_exit(bigmac_cleanup);
+MODULE_LICENSE("GPL");

--------------090408050308090301090709
Content-Type: text/plain;
 name="SUNLANCE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SUNLANCE"

--- drivers/net/sunlance.c.old	Fri Apr 27 01:17:26 2001
+++ drivers/net/sunlance.c	Sun Oct 14 13:18:20 2001
@@ -1603,3 +1603,4 @@
 
 module_init(sparc_lance_probe);
 module_exit(sparc_lance_cleanup);
+MODULE_LICENSE("GPL");

--------------090408050308090301090709
Content-Type: text/plain;
 name="SUNQE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SUNQE"

--- drivers/net/sunqe.c.old	Fri Apr 27 01:17:26 2001
+++ drivers/net/sunqe.c	Sun Oct 14 13:17:15 2001
@@ -1041,3 +1041,4 @@
 
 module_init(qec_probe);
 module_exit(qec_cleanup);
+MODULE_LICENSE("GPL");

--------------090408050308090301090709--

