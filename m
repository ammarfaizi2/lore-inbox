Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVBXVmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVBXVmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVBXVmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:42:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35846 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262497AbVBXVm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:42:27 -0500
Date: Thu, 24 Feb 2005 22:42:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] net/ieee80211/Kconfig: don't describe what gets selected
Message-ID: <20050224214223.GJ8651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The information what gets selected doesn't belong into the helh text 
(and at least "make menuconfig" already displays this information).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc4-mm1-full/net/ieee80211/Kconfig.old	2005-02-24 22:31:07.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/net/ieee80211/Kconfig	2005-02-24 22:32:02.000000000 +0100
@@ -5,3 +5,3 @@
 	This option enables the hardware independent IEEE 802.11 
-	networking stack.  This option will also select NET_RADIO.
+	networking stack.
 
@@ -38,5 +38,3 @@
 	Include software based cipher suites in support of IEEE 
-	802.11's WEP.  This is needed for WEP as well as 802.1x.  This 
-	selects ARC4 under kernel crypto libraries, and CRC32 under 
-	kernel libraries. 
+	802.11's WEP.  This is needed for WEP as well as 802.1x.
 
@@ -52,4 +50,3 @@
 	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with CCMP enabled 
-	networks.  This selects AES support under kernel crypto 
-	libraries.
+	networks.
 
@@ -65,4 +62,3 @@
 	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with TKIP enabled 
-	networks.  This selects Michael Mic support under kernel crypto 
-	libraries. 
+	networks.
 

