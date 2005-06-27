Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVF0N0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVF0N0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVF0NY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:24:59 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:17637 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262062AbVF0MQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:39 -0400
Message-Id: <20050627121419.015924000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:47 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-doc-update2.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 47/51] usb Kconfig help text update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

o corrected some typos
o added the Wikilink pointing to the USB device list

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/Kconfig |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/Kconfig
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/Kconfig	2005-06-27 13:26:10.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/Kconfig	2005-06-27 13:26:19.000000000 +0200
@@ -3,19 +3,22 @@ config DVB_USB
 	depends on DVB_CORE && USB
 	select FW_LOADER
 	help
-	  By enabling this you will be able to choose the various USB 1.1 and
-	  USB2.0 DVB devices.
+	  By enabling this you will be able to choose the various supported
+	  USB1.1 and USB2.0 DVB devices.
 
 	  Almost every USB device needs a firmware, please look into
-	  <file:Documentation/dvb/README.dvb-usb>
+	  <file:Documentation/dvb/README.dvb-usb>.
 
-	  Say Y if you own an USB DVB device.
+	  For a complete list of supported USB devices see the LinuxTV DVB Wiki:
+	  <http://www.linuxtv.org/wiki/index.php/DVB_USB>
+
+	  Say Y if you own a USB DVB device.
 
 config DVB_USB_DEBUG
 	bool "Enable extended debug support for all DVB-USB devices"
 	depends on DVB_USB
 	help
-	  Say Y if you want to enable debuging. See modinfo dvb-usb (and the
+	  Say Y if you want to enable debugging. See modinfo dvb-usb (and the
 	  appropriate drivers) for debug levels.
 
 config DVB_USB_A800
@@ -79,8 +82,7 @@ config DVB_USB_CXUSB
 	select DVB_CX22702
 	help
 	  Say Y here to support the Medion MD95700 hybrid USB2.0 device. Currently
-	  only the DVB-T part is supported and MPEG2 data transfer are not working
-	  :(.
+	  only the DVB-T part is supported.
 
 config DVB_USB_DIGITV
 	tristate "Nebula Electronics uDigiTV DVB-T USB2.0 support"

--

