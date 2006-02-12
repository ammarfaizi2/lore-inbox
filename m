Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWBLRwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWBLRwF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWBLRwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:52:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59397 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751347AbWBLRwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:52:03 -0500
Date: Sun, 12 Feb 2006 18:52:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] CONFIG_FORCEDETH updates
Message-ID: <20060212175202.GK30922@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible updates:
- let FORCEDETH no longer depend on EXPERIMENTAL
- remove the "Reverse Engineered" from the option text:
  for the user it's important which hardware the driver supports, not
  how it was developed


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc2-mm1-full/drivers/net/Kconfig.old	2006-02-12 02:23:31.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/net/Kconfig	2006-02-12 02:24:04.000000000 +0100
@@ -1370,10 +1370,10 @@
 	  <file:Documentation/networking/net-modules.txt>.  The module will be
 	  called b44.
 
 config FORCEDETH
-	tristate "Reverse Engineered nForce Ethernet support (EXPERIMENTAL)"
-	depends on NET_PCI && PCI && EXPERIMENTAL
+	tristate "nForce Ethernet support"
+	depends on NET_PCI && PCI
 	help
 	  If you have a network (Ethernet) controller of this type, say Y and
 	  read the Ethernet-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.

