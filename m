Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315421AbSFTTbx>; Thu, 20 Jun 2002 15:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSFTTbw>; Thu, 20 Jun 2002 15:31:52 -0400
Received: from mail301.mail.bellsouth.net ([205.152.58.161]:59231 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S315421AbSFTTbv>; Thu, 20 Jun 2002 15:31:51 -0400
Message-ID: <3D122D9B.B51BC0BD@bellsouth.net>
Date: Thu, 20 Jun 2002 15:31:39 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.23 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.23 i2c updates 1/4
Content-Type: multipart/mixed;
 boundary="------------301A3C8A3B94357729A37EA6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------301A3C8A3B94357729A37EA6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
Please apply patch 1/4 for i2c updates against 2.5.23
Thanks,
Albert

http://personal.atl.bellsouth.net/mia/a/c/ac9410/albert/albert.html
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------301A3C8A3B94357729A37EA6
Content-Type: text/plain; charset=us-ascii;
 name="2.5.23-i2c-1-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.23-i2c-1-patch"

# leave CONFIG names as in kernel
--- linux/drivers/i2c/Config.in.orig	2002-05-05 23:38:06.000000000 -0400
+++ linux/drivers/i2c/Config.in	2002-05-16 01:00:36.000000000 -0400
@@ -43,7 +43,7 @@
 # This is needed for automatic patch generation: sensors code ends here
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
-   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
+   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
 
 fi
 endmenu

--------------301A3C8A3B94357729A37EA6--

