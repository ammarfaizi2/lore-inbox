Return-Path: <linux-kernel-owner+w=401wt.eu-S1752434AbWLSENH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbWLSENH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbWLSENE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:13:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4468 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752434AbWLSENA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:13:00 -0500
Date: Tue, 19 Dec 2006 05:13:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: chas@cmf.nrl.navy.mil
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/atm/Kconfig: remove dead ATM_TNETA1570 option
Message-ID: <20061219041300.GD6993@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unconverted ATM_TNETA1570 option that also lacks 
any code in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc1-mm1/drivers/atm/Kconfig.old	2006-12-19 04:42:00.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/atm/Kconfig	2006-12-19 04:42:14.000000000 +0100
@@ -167,10 +167,6 @@
 	  Note that extended debugging may create certain race conditions
 	  itself. Enable this ONLY if you suspect problems with the driver.
 
-#   bool 'Rolfs TI TNETA1570' CONFIG_ATM_TNETA1570 y
-#   if [ "$CONFIG_ATM_TNETA1570" = "y" ]; then
-#      bool '  Enable extended debugging' CONFIG_ATM_TNETA1570_DEBUG n
-#   fi
 config ATM_NICSTAR
 	tristate "IDT 77201 (NICStAR) (ForeRunnerLE)"
 	depends on PCI && ATM && !64BIT

