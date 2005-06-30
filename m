Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbVF3WV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVF3WV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 18:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbVF3WV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 18:21:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41476 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263020AbVF3WVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 18:21:13 -0400
Date: Fri, 1 Jul 2005 00:21:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Max Asbock <masbock@us.ibm.com>, Vernon Mauery <vernux@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] IBM_ASM Kconfig corrections
Message-ID: <20050630222110.GF27478@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following fixes:
- IBM_ASM must depend on PCI
- remove useless "default n"
- correct the URL to further information

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm2-full/drivers/misc/Kconfig.old	2005-06-30 22:36:01.000000000 +0200
+++ linux-2.6.12-mm2-full/drivers/misc/Kconfig	2005-06-30 22:36:21.000000000 +0200
@@ -6,8 +6,7 @@
 
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
-	depends on X86 && EXPERIMENTAL
-	default n
+	depends on X86 && PCI && EXPERIMENTAL
 	---help---
 	  This option enables device driver support for in-band access to the
 	  IBM RSA (Condor) service processor in eServer xSeries systems.
@@ -22,7 +21,7 @@
 	  
 	  WARNING: This software may not be supported or function
 	  correctly on your IBM server. Please consult the IBM ServerProven
-	  website <http://www.pc.ibm/ww/eserver/xseries/serverproven> for
+	  website <http://www.pc.ibm.com/ww/eserver/xseries/serverproven> for
 	  information on the specific driver level and support statement
 	  for your IBM server.
 

