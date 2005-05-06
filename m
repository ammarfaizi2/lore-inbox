Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVEFW2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVEFW2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVEFW17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:27:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35846 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261295AbVEFW1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:27:44 -0400
Date: Sat, 7 May 2005 00:27:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/socket.c: unexport move_addr_to_kernel
Message-ID: <20050506222739.GX3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc3-mm2-full/net/socket.c.old	2005-05-03 11:03:23.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/socket.c	2005-05-03 11:03:53.000000000 +0200
@@ -2070,8 +2070,7 @@
 }
 #endif /* CONFIG_PROC_FS */
 
-/* ABI emulation layers need these two */
-EXPORT_SYMBOL(move_addr_to_kernel);
+/* ABI emulation layers need this one */
 EXPORT_SYMBOL(move_addr_to_user);
 EXPORT_SYMBOL(sock_create);
 EXPORT_SYMBOL(sock_create_kern);

