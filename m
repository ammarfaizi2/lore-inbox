Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTLTLz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 06:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLTLz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 06:55:58 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:9919 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S264126AbTLTLzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 06:55:23 -0500
Message-ID: <004b01c3c6f0$1a09dad0$0e25fe0a@southpark.ae.poznan.pl>
From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
To: <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL PATCH BEAVER] paramter -> parameter typos
Date: Sat, 20 Dec 2003 12:54:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

trivial 'paramter -> parameter' typos in:
 Documentation/networking/sk98lin.txt |    2 +-
 arch/ppc64/kernel/setup.c            |    2 +-
 drivers/char/hangcheck-timer.c       |    2 +-
 drivers/media/video/tea6420.c        |    2 +-
 drivers/net/appletalk/ltpc.c         |    2 +-
 drivers/net/dl2k.c                   |    2 +-
 drivers/net/e1000/e1000_param.c      |    2 +-
 drivers/net/ixgb/ixgb_param.c        |    2 +-
 drivers/net/skfp/h/smt.h             |    2 +-
 drivers/net/tokenring/3c359.c        |    2 +-
 drivers/net/tokenring/lanstreamer.c  |    2 +-
 drivers/net/tokenring/olympic.c      |    2 +-
 drivers/s390/net/iucv.h              |    2 +-
 drivers/scsi/aic7xxx/aic79xx_pci.c   |    4 ++--
 fs/block_dev.c                       |    4 ++--
 include/asm-sh/bigsur.h              |    2 +-
 include/asm-sh/bigsur/bigsur.h       |    2 +-
 include/linux/ethtool.h              |    2 +-
 include/net/ip6_tunnel.h             |    2 +-
 sound/core/seq/seq_dummy.c           |    2 +-
 20 files changed, 22 insertions(+), 22 deletions(-)

Available at

http://www.soltysiak.com/patches/2.6/2.6.0/typos/patch-2.6.0-typos.diff

and in the body of the email.

Best Regards,
Maciej

diff -ru linux.orig/arch/ppc64/kernel/setup.c
linux/arch/ppc64/kernel/setup.c
--- linux.orig/arch/ppc64/kernel/setup.c2003-12-19 23:55:34.000000000 +0100
+++ linux/arch/ppc64/kernel/setup.c2003-12-20 00:05:06.330429680 +0100
@@ -137,7 +137,7 @@
 }

 /*
- * Do some initial setup of the system.  The paramters are those which
+ * Do some initial setup of the system.  The parameters are those which
  * were passed in from the bootloader.
  */
 void setup_system(unsigned long r3, unsigned long r4, unsigned long r5,
diff -ru linux.orig/Documentation/networking/sk98lin.txt
linux/Documentation/networking/sk98lin.txt
--- linux.orig/Documentation/networking/sk98lin.txt2003-12-19
23:56:30.000000000 +0100
+++ linux/Documentation/networking/sk98lin.txt2003-12-20 00:04:55.000000000
+0100
@@ -365,7 +365,7 @@
 Default:      2000

 This parameter is only used, if either static or dynamic interrupt
moderation
-is used on a network adapter card. Using this paramter if no moderation is
+is used on a network adapter card. Using this parameter if no moderation is
 applied, will lead to no action performed.

 This parameter determines the length of any interrupt moderation interval.
diff -ru linux.orig/drivers/char/hangcheck-timer.c
linux/drivers/char/hangcheck-timer.c
--- linux.orig/drivers/char/hangcheck-timer.c2003-12-19 23:56:07.000000000
+0100
+++ linux/drivers/char/hangcheck-timer.c2003-12-20 00:02:50.745041792 +0100
@@ -26,7 +26,7 @@
  * The hangcheck-timer driver uses the TSC to catch delays that
  * jiffies does not notice.  A timer is set.  When the timer fires, it
  * checks whether it was delayed and if that delay exceeds a given
- * margin of error.  The hangcheck_tick module paramter takes the timer
+ * margin of error.  The hangcheck_tick module parameter takes the timer
  * duration in seconds.  The hangcheck_margin parameter defines the
  * margin of error, in seconds.  The defaults are 60 seconds for the
  * timer and 180 seconds for the margin of error.  IOW, a timer is set
diff -ru linux.orig/drivers/media/video/tea6420.c
linux/drivers/media/video/tea6420.c
--- linux.orig/drivers/media/video/tea6420.c2003-12-19 23:56:15.000000000
+0100
+++ linux/drivers/media/video/tea6420.c2003-12-20 00:01:57.968065112 +0100
@@ -62,7 +62,7 @@

 dprintk("tea6420.o: tea6420_switch: adr:0x%02x, i:%d, o:%d,
g:%d\n",client->addr,i,o,g);

-/* check if the paramters are valid */
+/* check if the parameters are valid */
 if ( i < 1 || i > 6 || o < 1 || o > 4 || g < 0 || g > 6 || g%2 != 0 )
 return -1;

diff -ru linux.orig/drivers/net/appletalk/ltpc.c
linux/drivers/net/appletalk/ltpc.c
--- linux.orig/drivers/net/appletalk/ltpc.c2003-12-19 23:55:49.000000000
+0100
+++ linux/drivers/net/appletalk/ltpc.c2003-12-20 00:03:54.000000000 +0100
@@ -1244,7 +1244,7 @@
 if (ints[0] > 2) {
 dma = ints[3];
 }
-/* ignore any other paramters */
+/* ignore any other parameters */
 }
 return 1;
 }
diff -ru linux.orig/drivers/net/dl2k.c linux/drivers/net/dl2k.c
--- linux.orig/drivers/net/dl2k.c2003-12-19 23:55:51.000000000 +0100
+++ linux/drivers/net/dl2k.c2003-12-20 00:03:40.000000000 +0100
@@ -24,7 +24,7 @@
     1.052001/11/22Fixed Tx stopped when unidirectional tx busy.
     1.062001/12/13Fixed disconnect bug at 10Mbps mode.
     Fixed tx_full flag incorrect.
-Added tx_coalesce paramter.
+Added tx_coalesce parameter.
     1.072002/01/03Fixed miscount of RX frame error.
     1.082002/01/17Fixed the multicast bug.
     1.092002/03/07Move rx-poll-now to re-fill loop.
diff -ru linux.orig/drivers/net/e1000/e1000_param.c
linux/drivers/net/e1000/e1000_param.c
--- linux.orig/drivers/net/e1000/e1000_param.c2003-12-19 23:55:49.000000000
+0100
+++ linux/drivers/net/e1000/e1000_param.c2003-12-20 00:04:07.000000000 +0100
@@ -299,7 +299,7 @@
  * e1000_check_options - Range Checking for Command Line Parameters
  * @adapter: board private structure
  *
- * This routine checks all command line paramters for valid user
+ * This routine checks all command line parameters for valid user
  * input.  If an invalid value is given, or if no user specified
  * value exists, a default value is used.  The final value is stored
  * in a variable in the adapter structure.
diff -ru linux.orig/drivers/net/ixgb/ixgb_param.c
linux/drivers/net/ixgb/ixgb_param.c
--- linux.orig/drivers/net/ixgb/ixgb_param.c2003-12-19 23:55:49.000000000
+0100
+++ linux/drivers/net/ixgb/ixgb_param.c2003-12-20 00:04:41.000000000 +0100
@@ -286,7 +286,7 @@
  * ixgb_check_options - Range Checking for Command Line Parameters
  * @adapter: board private structure
  *
- * This routine checks all command line paramters for valid user
+ * This routine checks all command line parameters for valid user
  * input.  If an invalid value is given, or if no user specified
  * value exists, a default value is used.  The final value is stored
  * in a variable in the adapter structure.
diff -ru linux.orig/drivers/net/skfp/h/smt.h linux/drivers/net/skfp/h/smt.h
--- linux.orig/drivers/net/skfp/h/smt.h2003-12-19 23:55:49.000000000 +0100
+++ linux/drivers/net/skfp/h/smt.h2003-12-20 00:04:29.000000000 +0100
@@ -413,7 +413,7 @@
 #define SMT_RDF_SUCCESS0x00000003/* success (PMF) */
 #define SMT_RDF_BADSET0x00000004/* bad set count (PMF) */
 #define SMT_RDF_ILLEGAL 0x00000005/* read only (PMF) */
-#define SMT_RDF_NOPARAM0x6/* paramter not supported (PMF) */
+#define SMT_RDF_NOPARAM0x6/* parameter not supported (PMF) */
 #define SMT_RDF_RANGE0x8/* out of range */
 #define SMT_RDF_AUTHOR0x9/* not autohorized */
 #define SMT_RDF_LENGTH0x0a/* length error */
diff -ru linux.orig/drivers/net/tokenring/3c359.c
linux/drivers/net/tokenring/3c359.c
--- linux.orig/drivers/net/tokenring/3c359.c2003-12-19 23:55:51.000000000
+0100
+++ linux/drivers/net/tokenring/3c359.c2003-12-20 00:03:31.000000000 +0100
@@ -76,7 +76,7 @@
 MODULE_AUTHOR("Mike Phillips <mikep@linuxtr.net>") ;
 MODULE_DESCRIPTION("3Com 3C359 Velocity XL Token Ring Adapter Driver \n") ;

-/* Module paramters */
+/* Module parameters */

 /* Ring Speed 0,4,16
  * 0 = Autosense
diff -ru linux.orig/drivers/net/tokenring/lanstreamer.c
linux/drivers/net/tokenring/lanstreamer.c
--- linux.orig/drivers/net/tokenring/lanstreamer.c2003-12-19
23:55:51.000000000 +0100
+++ linux/drivers/net/tokenring/lanstreamer.c2003-12-20 00:03:19.000000000
+0100
@@ -163,7 +163,7 @@
 "Monitor Contention failer for RPL", "FDX Protocol Error"
 };

-/* Module paramters */
+/* Module parameters */

 /* Ring Speed 0,4,16
  * 0 = Autosense
diff -ru linux.orig/drivers/net/tokenring/olympic.c
linux/drivers/net/tokenring/olympic.c
--- linux.orig/drivers/net/tokenring/olympic.c2003-12-19 23:55:51.000000000
+0100
+++ linux/drivers/net/tokenring/olympic.c2003-12-20 00:03:01.000000000 +0100
@@ -131,7 +131,7 @@
    "Reserved", "Reserved", "No Monitor Detected for RPL",
    "Monitor Contention failer for RPL", "FDX Protocol Error"};

-/* Module paramters */
+/* Module parameters */

 MODULE_AUTHOR("Mike Phillips <mikep@linuxtr.net>") ;
 MODULE_DESCRIPTION("Olympic PCI/Cardbus Chipset Driver") ;
diff -ru linux.orig/drivers/s390/net/iucv.h linux/drivers/s390/net/iucv.h
--- linux.orig/drivers/s390/net/iucv.h2003-12-19 23:56:09.000000000 +0100
+++ linux/drivers/s390/net/iucv.h2003-12-20 00:02:32.000000000 +0100
@@ -25,7 +25,7 @@
  *             (-EINVAL) Invalid value
  *             (-ENOMEM) storage allocation failed
  *pgmask defined in iucv_register_program will be set depending on input
- *paramters.
+ *parameters.
  *
  */

diff -ru linux.orig/drivers/scsi/aic7xxx/aic79xx_pci.c
linux/drivers/scsi/aic7xxx/aic79xx_pci.c
--- linux.orig/drivers/scsi/aic7xxx/aic79xx_pci.c2003-12-19
23:56:12.000000000 +0100
+++ linux/drivers/scsi/aic7xxx/aic79xx_pci.c2003-12-20 00:02:15.000000000
+0100
@@ -958,7 +958,7 @@
   |  AHD_FAINT_LED_BUG;

 /*
- * IO Cell paramter setup.
+ * IO Cell parameter setup.
  */
 AHD_SET_PRECOMP(ahd, AHD_PRECOMP_CUTBACK_29);

@@ -973,7 +973,7 @@
   |  AHD_INTCOLLISION_BUG|AHD_EARLY_REQ_BUG;

 /*
- * IO Cell paramter setup.
+ * IO Cell parameter setup.
  */
 AHD_SET_PRECOMP(ahd, AHD_PRECOMP_CUTBACK_29);
 AHD_SET_SLEWRATE(ahd, AHD_SLEWRATE_DEF_REVB);
diff -ru linux.orig/fs/block_dev.c linux/fs/block_dev.c
--- linux.orig/fs/block_dev.c2003-12-19 23:55:08.000000000 +0100
+++ linux/fs/block_dev.c2003-12-20 00:01:36.000000000 +0100
@@ -846,7 +846,7 @@
  *
  * @path:special file representing the block device
  * @flags:%MS_RDONLY for opening read-only
- * @kind:usage (same as the 4th paramter to blkdev_get)
+ * @kind:usage (same as the 4th parameter to blkdev_get)
  * @holder:owner for exclusion
  *
  * Open the blockdevice described by the special file at @path, claim it
@@ -888,7 +888,7 @@
  * close_bdev_excl  -  release a blockdevice openen by open_bdev_excl()
  *
  * @bdev:blockdevice to close
- * @kind:usage (same as the 4th paramter to blkdev_get)
+ * @kind:usage (same as the 4th parameter to blkdev_get)
  *
  * This is the counterpart to open_bdev_excl().
  */
diff -ru linux.orig/include/asm-sh/bigsur/bigsur.h
linux/include/asm-sh/bigsur/bigsur.h
--- linux.orig/include/asm-sh/bigsur/bigsur.h2003-12-19 23:56:40.000000000
+0100
+++ linux/include/asm-sh/bigsur/bigsur.h2003-12-20 00:01:05.000000000 +0100
@@ -66,7 +66,7 @@
 /* SMC ethernet card parameters */
 #define BIGSUR_ETHER_IOPORT0x220

-/* IDE register paramters */
+/* IDE register parameters */
 #define BIGSUR_IDECMD_IOPORT0x1f0
 #define BIGSUR_IDECTL_IOPORT0x1f8

diff -ru linux.orig/include/asm-sh/bigsur.h linux/include/asm-sh/bigsur.h
--- linux.orig/include/asm-sh/bigsur.h2003-12-19 23:56:40.000000000 +0100
+++ linux/include/asm-sh/bigsur.h2003-12-20 00:00:46.000000000 +0100
@@ -66,7 +66,7 @@
 /* SMC ethernet card parameters */
 #define BIGSUR_ETHER_IOPORT0x220

-/* IDE register paramters */
+/* IDE register parameters */
 #define BIGSUR_IDECMD_IOPORT0x1f0
 #define BIGSUR_IDECTL_IOPORT0x1f8

diff -ru linux.orig/include/linux/ethtool.h linux/include/linux/ethtool.h
--- linux.orig/include/linux/ethtool.h2003-12-19 23:56:39.000000000 +0100
+++ linux/include/linux/ethtool.h2003-12-20 00:01:15.000000000 +0100
@@ -280,7 +280,7 @@
  * get_ringparam: Report ring sizes
  * set_ringparam: Set ring sizes
  * get_pauseparam: Report pause parameters
- * set_pauseparam: Set pause paramters
+ * set_pauseparam: Set pause parameters
  * get_rx_csum: Report whether receive checksums are turned on or off
  * set_rx_csum: Turn receive checksum on or off
  * get_tx_csum: Report whether transmit checksums are turned on or off
diff -ru linux.orig/include/net/ip6_tunnel.h linux/include/net/ip6_tunnel.h
--- linux.orig/include/net/ip6_tunnel.h2003-12-19 23:56:31.000000000 +0100
+++ linux/include/net/ip6_tunnel.h2003-12-20 00:01:25.000000000 +0100
@@ -23,7 +23,7 @@
 struct net_device *dev;/* virtual device associated with tunnel */
 struct net_device_stats stat;/* statistics for tunnel device */
 int recursion;/* depth of hard_start_xmit recursion */
-struct ip6_tnl_parm parms;/* tunnel configuration paramters */
+struct ip6_tnl_parm parms;/* tunnel configuration parameters */
 struct flowi fl;/* flowi template for xmit */
 struct dst_entry *dst_cache;    /* cached dst */
 u32 dst_cookie;
diff -ru linux.orig/sound/core/seq/seq_dummy.c
linux/sound/core/seq/seq_dummy.c
--- linux.orig/sound/core/seq/seq_dummy.c2003-12-19 23:55:43.000000000 +0100
+++ linux/sound/core/seq/seq_dummy.c2003-12-19 23:57:36.000000000 +0100
@@ -45,7 +45,7 @@
   snd-seq-client-62 as "off".  This will help modprobe.

   The number of ports to be created can be specified via the module
-  paramter "ports".  For example, to create four ports, add the
+  parameter "ports".  For example, to create four ports, add the
   following option in /etc/modules.conf:

 option snd-seq-dummy ports=4

