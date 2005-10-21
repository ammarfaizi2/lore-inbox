Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVJUNIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVJUNIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVJUNIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:08:36 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37794 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964939AbVJUNIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:08:36 -0400
Subject: PATCH: Bluesmoke missing renames
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Oct 2005 14:37:23 +0100
Message-Id: <1129901843.26367.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As was noted on and off list a couple of places still had old naming

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/drivers/edac/Kconfig linux-2.6.14-rc4-mm1/drivers/edac/Kconfig
--- linux.vanilla-2.6.14-rc4-mm1/drivers/edac/Kconfig	2005-10-20 16:12:39.000000000 +0100
+++ linux-2.6.14-rc4-mm1/drivers/edac/Kconfig	2005-10-20 17:05:58.000000000 +0100
@@ -34,9 +34,9 @@
 	depends on EDAC
 	help
 	  Some systems are able to detect and correct errors in main
-	  memory.  Bluesmoke can report statistics on memory error
+	  memory.  EDAC can report statistics on memory error
 	  detection and correction (EDAC - or commonly referred to ECC
-	  errors).  Bluesmoke will also try to decode where these errors
+	  errors).  EDAC will also try to decode where these errors
 	  occurred so that a particular failing memory module can be
 	  replaced.  If unsure, select 'Y'.
 



diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/drivers/edac/e752x_edac.c linux-2.6.14-rc4-mm1/drivers/edac/e752x_edac.c
--- linux.vanilla-2.6.14-rc4-mm1/drivers/edac/e752x_edac.c	2005-10-20 16:12:39.000000000 +0100
+++ linux-2.6.14-rc4-mm1/drivers/edac/e752x_edac.c	2005-10-20 17:06:17.000000000 +0100
@@ -13,7 +13,7 @@
  * 	Wang Zhenyu at intel.com
  * 	Dave Jiang at mvista.com
  *
- * $Id: bluesmoke_e752x.c,v 1.5.2.11 2005/10/05 00:43:44 dsp_llnl Exp $
+ * $Id: edac_e752x.c,v 1.5.2.11 2005/10/05 00:43:44 dsp_llnl Exp $
  *
  */
 

