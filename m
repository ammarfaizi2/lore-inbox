Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265075AbUFVSC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbUFVSC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUFVSCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:02:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:45749 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265075AbUFVRnb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:31 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261111963@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:51 -0700
Message-Id: <10879261112687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.102.2, 2004/06/04 14:46:39-07:00, khali@linux-fr.org

[PATCH] I2C: update I2C IDs

> > Greg, should I send a patch to you with these?
>
> Sure, if it's needed.

Just noticed that I never sent the promised patch. Here it is. I also
added a few other IDs, since we have them in our (2.4) i2c CVS
repository. Having them in 2.6 as well will at least prevent collisions.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/i2c-id.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)


diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	Tue Jun 22 09:48:15 2004
+++ b/include/linux/i2c-id.h	Tue Jun 22 09:48:15 2004
@@ -101,6 +101,14 @@
 #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
 #define I2C_DRIVERID_ADV7170	54	/* video encoder		*/
 #define I2C_DRIVERID_RADEON	55	/* I2C bus on Radeon boards	*/
+#define I2C_DRIVERID_MAX1617	56	/* temp sensor			*/
+#define I2C_DRIVERID_SAA7191	57	/* video encoder		*/
+#define I2C_DRIVERID_INDYCAM	58	/* SGI IndyCam			*/
+#define I2C_DRIVERID_BT832	59	/* CMOS camera video processor	*/
+#define I2C_DRIVERID_TDA9887	60	/* TDA988x IF-PLL demodulator	*/
+#define I2C_DRIVERID_OVCAMCHIP	61	/* OmniVision CMOS image sens.	*/
+#define I2C_DRIVERID_TDA7313	62	/* TDA7313 audio processor	*/
+#define I2C_DRIVERID_MAX6900	63	/* MAX6900 real-time clock	*/
 
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
@@ -264,6 +272,10 @@
 #define I2C_HW_SMBUS_SCX200	0x0b
 #define I2C_HW_SMBUS_NFORCE2	0x0c
 #define I2C_HW_SMBUS_W9968CF	0x0d
+#define I2C_HW_SMBUS_OV511	0x0e	/* OV511(+) USB 1.1 webcam ICs	*/
+#define I2C_HW_SMBUS_OV518	0x0f	/* OV518(+) USB 1.1 webcam ICs	*/
+#define I2C_HW_SMBUS_OV519	0x10	/* OV519 USB 1.1 webcam IC	*/
+#define I2C_HW_SMBUS_OVFX2	0x11	/* Cypress/OmniVision FX2 webcam */
 
 /* --- ISA pseudo-adapter						*/
 #define I2C_HW_ISA 0x00

