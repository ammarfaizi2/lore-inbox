Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVCVCJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVCVCJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVCVCHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:07:52 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:17035 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262328AbVCVBfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:31 -0500
Message-Id: <20050322013457.986119000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:00 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibcom-readme.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 27/48] corrected links to firmware files
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corrected links to firmware files (reported by Stefan Frings)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 README.dibusb    |   19 +++++++++++++------
 get_dvb_firmware |    2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

Index: linux-2.6.12-rc1-mm1/Documentation/dvb/README.dibusb
===================================================================
--- linux-2.6.12-rc1-mm1.orig/Documentation/dvb/README.dibusb	2005-03-22 00:16:19.000000000 +0100
+++ linux-2.6.12-rc1-mm1/Documentation/dvb/README.dibusb	2005-03-22 00:18:18.000000000 +0100
@@ -157,13 +157,20 @@ You can either use "get_dvb_firmware dib
 can get it directly via
 
 for USB1.1 (AN2135)
-http://linuxtv.org/cgi-bin/cvsweb.cgi/dvb-kernel/firmware/dvb-dibusb-5.0.0.11.fw?rev=1.1&content-type=text/plain
+http://www.linuxtv.org/downloads/firmware/dvb-dibusb-5.0.0.11.fw
 
 for USB1.1 (AN2235) (a few Artec T1 devices)
-http://linuxtv.org/cgi-bin/cvsweb.cgi/dvb-kernel/firmware/dvb-dibusb-an2235-1.fw?rev=1.1&content-type=text/plain
+http://www.linuxtv.org/downloads/firmware/dvb-dibusb-an2235-1.fw
+
+for USB2.0 (FX2) Hauppauge, DiBcom
+http://www.linuxtv.org/downloads/firmware/dvb-dibusb-6.0.0.5.fw
+
+for USB2.0 ADSTech/Kworld USB2.0
+http://www.linuxtv.org/downloads/firmware/dvb-dibusb-adstech-usb2-1.fw
+
+for USB2.0 HanfTek
+http://www.linuxtv.org/downloads/firmware/dvb-dibusb-an2235-1.fw
 
-for USB2.0 (FX2)
-http://linuxtv.org/cgi-bin/cvsweb.cgi/dvb-kernel/firmware/dvb-dibusb-6.0.0.5.fw?rev=1.1&content-type=text/plain
 
 1.2. Compiling
 
@@ -203,7 +210,7 @@ in vdr is working now also.
 
 2. Known problems and bugs
 
-- none this time
+- Don't remove the USB device while running an DVB application, your system will die.
 
 2.1. Adding support for devices
 
@@ -242,7 +249,7 @@ now use the dmx_sw_filter function inste
 linux-dvb software filter is able to get the best of the garbled TS.
 
 The bug, where the TS is distorted by a heavy usage of the device is gone
-definitely.  All dibusb-devices I was using (Twinhan, Kworld, DiBcom) are
+definitely. All dibusb-devices I was using (Twinhan, Kworld, DiBcom) are
 working like charm now with VDR. Sometimes I even was able to record a channel
 and watch another one.
 
Index: linux-2.6.12-rc1-mm1/Documentation/dvb/get_dvb_firmware
===================================================================
--- linux-2.6.12-rc1-mm1.orig/Documentation/dvb/get_dvb_firmware	2005-03-22 00:15:20.000000000 +0100
+++ linux-2.6.12-rc1-mm1/Documentation/dvb/get_dvb_firmware	2005-03-22 00:18:18.000000000 +0100
@@ -222,7 +222,7 @@ sub vp7041 {
 }
 
 sub dibusb {
-	my $url = "http://linuxtv.org/cgi-bin/cvsweb.cgi/dvb-kernel/firmware/dvb-dibusb-5.0.0.11.fw?rev=1.1&content-type=text/plain";
+	my $url = "http://www.linuxtv.org/downloads/firmware/dvb-dibusb-5.0.0.11.fw";
 	my $outfile = "dvb-dibusb-5.0.0.11.fw";
 	my $hash = "fa490295a527360ca16dcdf3224ca243";
 

--

