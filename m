Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263252AbVCDVXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbVCDVXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbVCDVTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:19:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:63393 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263152AbVCDUy2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:28 -0500
Cc: gregkh@suse.de
Subject: [PATCH] I2C: fixed up the i2c-id.h algo ids.
In-Reply-To: <11099685973684@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:37 -0800
Message-Id: <11099685971064@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2114, 2005/03/02 15:50:42-08:00, gregkh@suse.de

[PATCH] I2C: fixed up the i2c-id.h algo ids.

Thanks to Jean Delvare <khali@linux-fr.org> for the help with this.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/i2c-id.h |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)


diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	2005-03-04 12:22:52 -08:00
+++ b/include/linux/i2c-id.h	2005-03-04 12:22:52 -08:00
@@ -20,8 +20,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.68 2003/02/25 02:55:18 mds Exp $ */
-
 #ifndef LINUX_I2C_ID_H
 #define LINUX_I2C_ID_H
 
@@ -196,11 +194,15 @@
 #define I2C_ALGO_OCP    0x120000	/* IBM or otherwise On-chip I2C algorithm */
 #define I2C_ALGO_BITHS	0x130000	/* enhanced bit style adapters	*/
 #define I2C_ALGO_IOP3XX	0x140000	/* XSCALE IOP3XX On-chip I2C alg */
-#define I2C_ALGO_PCA	0x150000	/* PCA 9564 style adapters	*/
-
 #define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
-#define I2C_ALGO_SGI	0x160000        /* SGI algorithm                */
-#define I2C_ALGO_AU1550	0x170000        /* Au1550 PSC algorithm		*/
+#define I2C_ALGO_SGI	0x160000	/* SGI algorithm		*/
+
+#define I2C_ALGO_USB	0x170000	/* USB algorithm		*/
+#define I2C_ALGO_VIRT	0x180000	/* Virtual bus adapter		*/
+
+#define I2C_ALGO_MV64XXX 0x190000	/* Marvell mv64xxx i2c ctlr	*/
+#define I2C_ALGO_PCA	0x1a0000	/* PCA 9564 style adapters	*/
+#define I2C_ALGO_AU1550	0x1b0000        /* Au1550 PSC algorithm		*/
 
 #define I2C_ALGO_EXP	0x800000	/* experimental			*/
 
@@ -240,6 +242,7 @@
 #define I2C_HW_B_IXP4XX 0x17	/* GPIO on IXP4XX systems		*/
 #define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 #define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
+#define I2C_HW_B_PCILYNX 0x1a	/* TI PCILynx I2C adapter		*/
 #define I2C_HW_B_CX2388x 0x1b	/* connexant 2388x based tv cards	*/
 
 /* --- PCF 8584 based algorithms					*/

