Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312921AbSCZBwn>; Mon, 25 Mar 2002 20:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312918AbSCZBwg>; Mon, 25 Mar 2002 20:52:36 -0500
Received: from mail.mesatop.com ([208.164.122.9]:8721 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S312920AbSCZBw2>;
	Mon, 25 Mar 2002 20:52:28 -0500
Subject: [PATCH] 2.5.7-dj1 add 6 help texts to arch/cris/drivers/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 25 Mar 2002 18:40:53 -0700
Message-Id: <1017106854.2679.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 6 help texts to arch/cris/drivers/Config.help.
The texts were obtained from ESR's v2.97 Configure.help.

Steven

--- linux-2.5.7-dj1/arch/cris/drivers/Config.help.orig	Mon Mar 25 13:52:21 2002
+++ linux-2.5.7-dj1/arch/cris/drivers/Config.help	Mon Mar 25 13:52:59 2002
@@ -572,3 +572,39 @@
 CONFIG_ETRAX_PARALLEL_PORT1
   Say Y here to enable parallel port 1.
 
+CONFIG_ETRAX_ETHERNET_LPSLAVE
+  This option enables a slave ETRAX 100 or ETRAX 100LX, connected to a
+  master ETRAX 100 or ETRAX 100LX through par0 and par1, to act as an
+  Ethernet controller.
+
+CONFIG_ETRAX_ETHERNET_LPSLAVE_HAS_LEDS
+  Enable if the slave has it's own LEDs.
+
+CONFIG_ETRAX_IDE
+  Enable this to get support for ATA/IDE.  You can't use parallel
+  ports or SCSI ports at the same time.
+
+CONFIG_ETRAX_NETWORK_LED_ON_WHEN_ACTIVITY
+  Selecting LED_on_when_link will light the LED when there is a
+  connection and will flash off when there is activity.
+
+  Selecting LED_on_when_activity will light the LED only when
+  there is activity.
+
+  This setting will also affect the behaviour of other activity LEDs
+  e.g. Bluetooth.
+
+CONFIG_ETRAX_NETWORK_LED_ON_WHEN_LINK
+  Selecting LED_on_when_link will light the LED when there is a
+  connection and will flash off when there is activity.
+
+  Selecting LED_on_when_activity will light the LED only when
+  there is activity.
+
+  This setting will also affect the behaviour of other activity LEDs
+  e.g. Bluetooth.
+
+CONFIG_ETRAX_SERIAL_PORT0
+  Enables the ETRAX 100 serial driver for ser0 (ttyS0)
+  Normally you want this on, unless you use external DMA 1 that uses
+  the same DMA channels.






