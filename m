Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312920AbSCZBzO>; Mon, 25 Mar 2002 20:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312918AbSCZBzA>; Mon, 25 Mar 2002 20:55:00 -0500
Received: from mail.mesatop.com ([208.164.122.9]:10769 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S312925AbSCZByU>;
	Mon, 25 Mar 2002 20:54:20 -0500
Subject: [PATCH] 2.5.7-dj1 add 5 help texts to arch/cris/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 25 Mar 2002 18:42:45 -0700
Message-Id: <1017106967.2680.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 5 help texts to arch/cris/Config.help.
The texts were obtained from ESR's v2.97 Configure.help.

Steven

--- linux-2.5.7-dj1/arch/cris/Config.help.orig	Mon Mar 25 13:53:25 2002
+++ linux-2.5.7-dj1/arch/cris/Config.help	Mon Mar 25 13:53:59 2002
@@ -392,3 +392,26 @@
 CONFIG_ETRAX_RESCUE_SER3
   Use serial port 3 as the rescue port.
 
+CONFIG_ETRAX_POWERBUTTON_BIT
+  Configure where power button is connected.
+
+CONFIG_ETRAX_ROOT_DEVICE
+  Specifies the device that should be mounted as root file system
+  when booting from flash. The axisflashmap driver adds an additional
+  mtd partition for the appended root file system image, so this option
+  should normally be the mtdblock device for the partition after the
+  last partition in the partition table.
+
+CONFIG_ETRAX_SHUTDOWN_BIT
+  Configure what pin on CSPO-port that is used for controlling power
+  supply.
+
+CONFIG_ETRAX_SOFT_SHUTDOWN
+  Enable this if Etrax is used with a power-supply that can be turned
+  off and on with PS_ON signal. Gives the possibility to detect
+  powerbutton and then do a power off after unmounting disks.
+
+CONFIG_ETRAX_WATCHDOG_NICE_DOGGY
+  By enabling this you make sure that the watchdog does not bite while
+  printing oopses. Recommended for development systems but not for
+  production releases.





