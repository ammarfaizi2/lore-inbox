Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314783AbSFITUc>; Sun, 9 Jun 2002 15:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSFITUb>; Sun, 9 Jun 2002 15:20:31 -0400
Received: from mail215.mail.bellsouth.net ([205.152.58.155]:52062 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S314783AbSFITUa>; Sun, 9 Jun 2002 15:20:30 -0400
Message-ID: <3D03AA77.BEC5606C@bellsouth.net>
Date: Sun, 09 Jun 2002 15:20:23 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.21 i2c updates 1/4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/4 updates I2C for 2.5.21
--- linux/drivers/i2c/Config.in.orig	2002-05-05 23:38:06.000000000 -0400
+++ linux/drivers/i2c/Config.in	2002-05-16 01:00:36.000000000 -0400
@@ -43,7 +43,7 @@
 # This is needed for automatic patch generation: sensors code ends here
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
-   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
+   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
 
 fi
 endmenu

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
