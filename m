Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSGSOCw>; Fri, 19 Jul 2002 10:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318511AbSGSOCw>; Fri, 19 Jul 2002 10:02:52 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:63423 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S316614AbSGSOCv>; Fri, 19 Jul 2002 10:02:51 -0400
Message-ID: <3D381CBD.8D92F0B@bellsouth.net>
Date: Fri, 19 Jul 2002 10:05:49 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 1/9]2.5.26 i2c id update
Content-Type: multipart/mixed;
 boundary="------------4CFD4F5867947C0C165C58E5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4CFD4F5867947C0C165C58E5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
The i2c & lm_sensors group would like to submit these 9
patches from our stable 2.6.3 package.

This group of patches adds hardware sensor for boards and
chips.  They are considered stable and have been in use
since March 2002.

Over the next weeks we will be updating the kernel with our
beta release 2.6.4 and documentation patches.
Thanks,
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------4CFD4F5867947C0C165C58E5
Content-Type: text/plain; charset=us-ascii;
 name="2.5.26-i2c-id-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.26-i2c-id-patch"

--- linux-2.5.26.clean/include/linux/i2c-id.h.orig	2002-07-10 19:12:15.000000000 -0400
+++ linux/include/linux/i2c-id.h	2002-07-10 19:13:42.000000000 -0400
@@ -90,7 +90,11 @@
 #define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
 #define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
 #define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/
-#define I2C_DRIVERID_SAA7108    46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_SAA7108	46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_DS1307	47     /* DS1307 real time clock	*/
+#define I2C_DRIVERID_ADV717x	48     /* ADV 7175/7176 video encoder	*/
+#define I2C_DRIVERID_ZR36067	49     /* Zoran 36067 video encoder	*/
+#define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
 
 
 

--------------4CFD4F5867947C0C165C58E5--

