Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWF1Q4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWF1Q4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWF1Qzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:55:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43268 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751453AbWF1QzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:13 -0400
Date: Wed, 28 Jun 2006 18:55:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo fixes: infomation -> information
Message-ID: <20060628165512.GA13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/dl2k.c          |    2 +-
 drivers/net/mv643xx_eth.h   |    2 +-
 drivers/net/s2io.h          |    2 +-
 drivers/net/sk98lin/skvpd.c |    2 +-
 drivers/scsi/initio.h       |   12 ++++++------
 include/linux/dqblk_xfs.h   |    4 ++--
 include/linux/udp.h         |    2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

--- linux-2.6.17-mm3-full/drivers/net/dl2k.c.old	2006-06-27 20:33:26.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/net/dl2k.c	2006-06-27 20:33:45.000000000 +0200
@@ -390,7 +390,7 @@
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = psrom->mac_addr[i];
 
-	/* Parse Software Infomation Block */
+	/* Parse Software Information Block */
 	i = 0x30;
 	psib = (u8 *) sromdata;
 	do {
--- linux-2.6.17-mm3-full/drivers/net/mv643xx_eth.h.old	2006-06-27 20:33:56.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/net/mv643xx_eth.h	2006-06-27 20:34:01.000000000 +0200
@@ -258,7 +258,7 @@
 	struct sk_buff *return_info;	/* User resource return information */
 };
 
-/* Ethernet port specific infomation */
+/* Ethernet port specific information */
 
 struct mv643xx_mib_counters {
 	u64 good_octets_received;
--- linux-2.6.17-mm3-full/drivers/net/s2io.h.old	2006-06-27 20:34:10.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/net/s2io.h	2006-06-27 20:34:14.000000000 +0200
@@ -652,7 +652,7 @@
 	nic_t *nic;
 }fifo_info_t;
 
-/* Infomation related to the Tx and Rx FIFOs and Rings of Xena
+/* Information related to the Tx and Rx FIFOs and Rings of Xena
  * is maintained in this structure.
  */
 typedef struct mac_info {
--- linux-2.6.17-mm3-full/drivers/net/sk98lin/skvpd.c.old	2006-06-27 20:34:21.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/net/sk98lin/skvpd.c	2006-06-27 20:34:25.000000000 +0200
@@ -22,7 +22,7 @@
  ******************************************************************************/
 
 /*
-	Please refer skvpd.txt for infomation how to include this module
+	Please refer skvpd.txt for information how to include this module
  */
 static const char SysKonnectFileId[] =
 	"@(#)$Id: skvpd.c,v 1.37 2003/01/13 10:42:45 rschmidt Exp $ (C) SK";
--- linux-2.6.17-mm3-full/drivers/scsi/initio.h.old	2006-06-27 20:34:33.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/scsi/initio.h	2006-06-27 20:34:36.000000000 +0200
@@ -193,13 +193,13 @@
 #define TSC_SEL_ATN_DIRECT_OUT  0x15	/* Select With ATN Sequence     */
 #define TSC_SEL_ATN3_DIRECT_IN  0xB5	/* Select With ATN3 Sequence    */
 #define TSC_SEL_ATN3_DIRECT_OUT 0x35	/* Select With ATN3 Sequence    */
-#define TSC_XF_DMA_OUT_DIRECT   0x06	/* DMA Xfer Infomation out      */
-#define TSC_XF_DMA_IN_DIRECT    0x86	/* DMA Xfer Infomation in       */
+#define TSC_XF_DMA_OUT_DIRECT   0x06	/* DMA Xfer Information out      */
+#define TSC_XF_DMA_IN_DIRECT    0x86	/* DMA Xfer Information in       */
 
-#define TSC_XF_DMA_OUT  0x43	/* DMA Xfer Infomation out              */
-#define TSC_XF_DMA_IN   0xC3	/* DMA Xfer Infomation in               */
-#define TSC_XF_FIFO_OUT 0x03	/* FIFO Xfer Infomation out             */
-#define TSC_XF_FIFO_IN  0x83	/* FIFO Xfer Infomation in              */
+#define TSC_XF_DMA_OUT  0x43	/* DMA Xfer Information out              */
+#define TSC_XF_DMA_IN   0xC3	/* DMA Xfer Information in               */
+#define TSC_XF_FIFO_OUT 0x03	/* FIFO Xfer Information out             */
+#define TSC_XF_FIFO_IN  0x83	/* FIFO Xfer Information in              */
 
 #define TSC_MSG_ACCEPT  0x0F	/* Message Accept                       */
 
--- linux-2.6.17-mm3-full/include/linux/dqblk_xfs.h.old	2006-06-27 20:34:50.000000000 +0200
+++ linux-2.6.17-mm3-full/include/linux/dqblk_xfs.h	2006-06-27 20:34:54.000000000 +0200
@@ -125,14 +125,14 @@
 
 /*
  * fs_quota_stat is the struct returned in Q_XGETQSTAT for a given file system.
- * Provides a centralized way to get meta infomation about the quota subsystem.
+ * Provides a centralized way to get meta information about the quota subsystem.
  * eg. space taken up for user and group quotas, number of dquots currently
  * incore.
  */
 #define FS_QSTAT_VERSION	1	/* fs_quota_stat.qs_version */
 
 /*
- * Some basic infomation about 'quota files'.
+ * Some basic information about 'quota files'.
  */
 typedef struct fs_qfilestat {
 	__u64		qfs_ino;	/* inode number */
--- linux-2.6.17-mm3-full/include/linux/udp.h.old	2006-06-27 20:36:07.000000000 +0200
+++ linux-2.6.17-mm3-full/include/linux/udp.h	2006-06-27 20:36:13.000000000 +0200
@@ -46,7 +46,7 @@
 	unsigned int	 corkflag;	/* Cork is required */
   	__u16		 encap_type;	/* Is this an Encapsulation socket? */
 	/*
-	 * Following member retains the infomation to create a UDP header
+	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
 	 */
 	__u16		 len;		/* total length of pending frames */

