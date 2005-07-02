Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVGBV4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVGBV4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 17:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVGBV4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 17:56:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7946 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261295AbVGBVwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:52:34 -0400
Date: Sat, 2 Jul 2005 23:52:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ipw2100-admin@linux.intel.com, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC: -mm patch] remove unused IPW2100_PROMISC option
Message-ID: <20050702215230.GF5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a completely unsed option.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc1-mm1-full/drivers/net/wireless/Kconfig.old	2005-07-02 22:41:09.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/drivers/net/wireless/Kconfig	2005-07-02 22:41:17.000000000 +0200
@@ -164,15 +164,6 @@
           say M here and read <file:Documentation/modules.txt>.  The module
           will be called ipw2100.ko.
 	
-config IPW2100_PROMISC
-        bool "Enable promiscuous mode"
-        depends on IPW2100
-        ---help---
-	  Enables promiscuous/monitor mode support for the ipw2100 driver.
-	  With this feature compiled into the driver, you can switch to 
-	  promiscuous mode via the Wireless Tool's Monitor mode.  While in this
-	  mode, no packets can be sent.
-
 config IPW_DEBUG
 	bool "Enable full debugging output in IPW2100 module."
 	depends on IPW2100

