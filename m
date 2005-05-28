Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVE1XVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVE1XVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVE1XTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:19:43 -0400
Received: from coderock.org ([193.77.147.115]:49286 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261203AbVE1XSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:18:11 -0400
Message-Id: <20050528231737.805020000@nd47.coderock.org>
Date: Sun, 29 May 2005 01:17:39 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 5/7] Remove duplicate file in Documentation/networking (drivers_net_wan_Kconfig)
Content-Disposition: inline; filename=delete-Documentation_networking_wanpipe.txt_drivers_net_wan_Kconfig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>


wanpipe.txt and wan-router.txt in Documentation/networking
contain the exact same information (diff between the two shows no
difference). This patch removes the reference to this document in
drivers/net/wan/Kconfig.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/net/wan/Kconfig
===================================================================
--- quilt.orig/drivers/net/wan/Kconfig
+++ quilt/drivers/net/wan/Kconfig
@@ -435,7 +435,7 @@ config VENDOR_SANGOMA
 	  the driver to support.
 
 	  If you have one or more of these cards, say M to this option;
-	  and read <file:Documentation/networking/wanpipe.txt>.
+	  and read <file:Documentation/networking/wan-router.txt>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called wanpipe.

--
