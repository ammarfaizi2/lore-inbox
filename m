Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVJJRTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVJJRTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVJJRTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:19:10 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:7059
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751078AbVJJRTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:19:08 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, jketreno@linux.intel.com, jgarzik@pobox.com
Subject: [PATCH] Documentation/networking/README.ipw2200
Date: Mon, 10 Oct 2005 13:18:05 -0400
Message-Id: <20051010171138.M48039@linuxwireless.org>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is different from the previous one. This is for IPW2200. ;-)

It updates the information/README to match the Kconfig info of the IPW2200.

Please apply to have a better documented 2.6.14

I dunno if this is either handled by Netdev or LKML because is about
Documentation/

Thanks,

.Alejandro

Signed-off-by: Alejandro Bonilla <abonilla@linuxwireless.org>

diff --git a/Documentation/networking/README.ipw2200
b/Documentation/networking/README.ipw2200
--- a/Documentation/networking/README.ipw2200
+++ b/Documentation/networking/README.ipw2200
@@ -1,5 +1,5 @@
 
-Intel(R) PRO/Wireless 2915ABG Driver for Linux in support of:
+Intel(R) PRO/Wireless 2200BG Driver for Linux in support of:
 
 Intel(R) PRO/Wireless 2200BG Network Connection 
 Intel(R) PRO/Wireless 2915ABG Network Connection 
@@ -27,7 +27,8 @@ Index
 1.4. Sysfs Helper Files
 2.   About the Version Numbers
 3.   Support
-4.   License
+4.   Firmware
+5.   License
 
 
 1.   Introduction
@@ -272,7 +273,24 @@ For general information and support, go 
     http://ipw2200.sf.net/
 
 
-4.  License
+4.  Firmware
+-----------------------------------------------
+
+As the firmware is licensed under a restricted use license, it can not be    
+included within the kernel sources.  To enable the IPW2200 you will need a    
+firmware image to load into the wireless NIC's processors.
+
+You can obtain these images from <http://ipw2200.sf.net/firmware.php>.
+
+The firmware package should be extracted where your hotplug firmware agent      
+is looking:
+
+% grep FIRMWARE /etc/hotplug/firmware.agent
+
+The most common path is /lib/firmware but the firmware.agent will tell.
+
+
+5.  License
 -----------------------------------------------
 
   Copyright(c) 2003 - 2005 Intel Corporation. All rights reserved.

