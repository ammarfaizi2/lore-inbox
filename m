Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSGAOC6>; Mon, 1 Jul 2002 10:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSGAOC5>; Mon, 1 Jul 2002 10:02:57 -0400
Received: from mail305.mail.bellsouth.net ([205.152.58.165]:38307 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S315595AbSGAOCz>; Mon, 1 Jul 2002 10:02:55 -0400
Message-ID: <3D20619B.ABE9D0CF@bellsouth.net>
Date: Mon, 01 Jul 2002 10:05:15 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c-id.h updates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Please include this small change into i2c-id.h that
bring existing video devices out of experimental
category.  It is already included in the i2c repository.
Thanks,
Albert

--- linux/include/linux/i2c-id.h.orig   2002-06-22 13:41:34.000000000 -0400
+++ linux/include/linux/i2c-id.h        2002-06-22 16:24:28.000000000 -0400
@@ -90,8 +90,11 @@
 #define I2C_DRIVERID_DRP3510   43     /* ADR decoder (Astra Radio)     */
 #define I2C_DRIVERID_SP5055    44     /* Satellite tuner               */
 #define I2C_DRIVERID_STV0030   45     /* Multipurpose switch           */
-#define I2C_DRIVERID_SAA7108    46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_SAA7108   46     /* video decoder, image scaler   */
 #define I2C_DRIVERID_DS1307    47     /* DS1307 real time clock        */
+#define I2C_DRIVERID_ADV717x   48     /* ADV 7175/7176 video encoder   */
+#define I2C_DRIVERID_ZR36067   49     /* Zoran 36067 video encoder     */
+#define I2C_DRIVERID_ZR36120   50     /* Zoran 36120 video decoder     */
 
 
 

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
