Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264864AbTFEUuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbTFEUt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:49:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23221 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265127AbTFEUqv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:46:51 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548465592180@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.70
In-Reply-To: <10548465592488@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 13:55:59 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1259.3.4, 2003/06/05 13:14:37-07:00, greg@kroah.com

[PATCH] I2C: sync i2c-id.h with cvs version.


 include/linux/i2c-id.h |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	Thu Jun  5 13:50:01 2003
+++ b/include/linux/i2c-id.h	Thu Jun  5 13:50:01 2003
@@ -98,6 +98,7 @@
 #define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
 #define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
 #define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
+#define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
 
 
 
@@ -178,6 +179,7 @@
 #define I2C_ALGO_MPC8XX 0x110000	/* MPC8xx PowerPC I2C algorithm */
 #define I2C_ALGO_OCP    0x120000	/* IBM or otherwise On-chip I2C algorithm */
 #define I2C_ALGO_BITHS	0x130000	/* enhanced bit style adapters	*/
+#define I2C_ALGO_OCP_IOP3XX  0x140000	/* XSCALE IOP3XX On-chip I2C alg */
 
 #define I2C_ALGO_EXP	0x800000	/* experimental			*/
 
@@ -213,6 +215,9 @@
 #define I2C_HW_B_FRODO  0x13    /* 2d3D, Inc. SA-1110 Development Board */
 #define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface (ARM)		*/
 #define I2C_HW_B_GUIDE  0x15    /* Guide bit-basher			*/
+#define I2C_HW_B_IXP2000 0x16	/* GPIO on IXP2000 systems              */
+#define I2C_HW_B_IXP425 0x17	/* GPIO on IXP425 systems		*/
+#define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
@@ -234,6 +239,8 @@
 /* --- PowerPC on-chip adapters						*/
 #define I2C_HW_OCP 0x00	/* IBM on-chip I2C adapter 	*/
 
+/* --- XSCALE on-chip adapters                          */
+#define I2C_HW_IOP321 0x00
 
 /* --- SMBus only adapters						*/
 #define I2C_HW_SMBUS_PIIX4	0x00

