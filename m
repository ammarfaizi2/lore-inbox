Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVGBB60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVGBB60 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 21:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVGBB6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 21:58:05 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:14572 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261687AbVGBBzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 21:55:22 -0400
Message-Id: <20050702015619.602668000@abc>
References: <20050702015506.631451000@abc>
Date: Sat, 02 Jul 2005 03:55:14 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-readme-update.patch
X-SA-Exim-Connect-IP: 84.189.246.3
Subject: [DVB patch 8/8] usb: README update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Updated the readme file to point to the DVB USB wikipage to find
out which firmware necessary, + minor updates.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Documentation/dvb/README.dvb-usb |   28 ++++++++++------------------
 1 files changed, 10 insertions(+), 18 deletions(-)

Index: linux-2.6.13-rc1-mm1/Documentation/dvb/README.dvb-usb
===================================================================
--- linux-2.6.13-rc1-mm1.orig/Documentation/dvb/README.dvb-usb	2005-07-02 03:22:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1/Documentation/dvb/README.dvb-usb	2005-07-02 03:22:34.000000000 +0200
@@ -48,6 +48,7 @@ cards/drivers/firmwares:
 http://www.linuxtv.org/wiki/index.php/DVB_USB
 
 0. History & News:
+  2005-06-30 - added support for WideView WT-220U (Thanks to Steve Chang)
   2005-05-30 - added basic isochronous support to the dvb-usb-framework
                added support for Conexant Hybrid reference design and Nebula DigiTV USB
   2005-04-17 - all dibusb devices ported to make use of the dvb-usb-framework
@@ -64,7 +65,7 @@ http://www.linuxtv.org/wiki/index.php/DV
   2005-01-31 - distorted streaming is gone for USB1.1 devices
   2005-01-13 - moved the mirrored pid_filter_table back to dvb-dibusb
              - first almost working version for HanfTek UMT-010
-             - found out, that Yakumo/HAMA/Typhoon are predessors of the HanfTek UMT-010
+             - found out, that Yakumo/HAMA/Typhoon are predecessors of the HanfTek UMT-010
   2005-01-10 - refactoring completed, now everything is very delightful
              - tuner quirks for some weird devices (Artec T1 AN2235 device has sometimes a
                Panasonic Tuner assembled). Tunerprobing implemented. Thanks a lot to Gunnar Wittich.
@@ -114,25 +115,13 @@ http://www.linuxtv.org/wiki/index.php/DV
 1. How to use?
 1.1. Firmware
 
-Most of the USB drivers need to download a firmware to start working.
+Most of the USB drivers need to download a firmware to the device before start
+working.
 
-for USB1.1 (AN2135) you need: dvb-usb-dibusb-5.0.0.11.fw
-for USB2.0 HanfTek: dvb-usb-umt-010-02.fw
-for USB2.0 DiBcom: dvb-usb-dibusb-6.0.0.8.fw
-for USB2.0 AVerMedia AverTV DVB-T USB2: dvb-usb-avertv-a800-01.fw
-for USB2.0 TwinhanDTV Alpha/MagicBox II: dvb-usb-vp7045-01.fw
+Have a look at the Wikipage for the DVB-USB-drivers to find out, which firmware
+you need for your device:
 
-The files can be found on http://www.linuxtv.org/download/firmware/ .
-
-We do not have the permission (yet) to publish the following firmware-files.
-You'll need to extract them from the windows drivers.
-
-You should be able to use "get_dvb_firmware dvb-usb" to get the firmware:
-
-for USB1.1 (AN2235) (a few Artec T1 devices): dvb-usb-dibusb-an2235-01.fw
-for USB2.0 Hauppauge: dvb-usb-nova-t-usb2-01.fw
-for USB2.0 ADSTech/Kworld USB2.0: dvb-usb-adstech-usb2-01.fw
-for USB2.0 Yakumo/Typhoon/Hama: dvb-usb-dtt200u-01.fw
+http://www.linuxtv.org/wiki/index.php/DVB_USB
 
 1.2. Compiling
 
@@ -226,6 +215,9 @@ Patches, comments and suggestions are ve
    Jennifer Chen, Jeff and Jack from Twinhan for kindly supporting by
 	writing the vp7045-driver.
 
+   Steve Chang from WideView for providing information for new devices and
+	firmware files.
+
    Michael Paxton for submitting remote control keymaps.
 
    Some guys on the linux-dvb mailing list for encouraging me.

--

