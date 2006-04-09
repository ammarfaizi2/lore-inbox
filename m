Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWDIP6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWDIP6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWDIP6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:58:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53509 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750803AbWDIP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:58:23 -0400
Date: Sun, 9 Apr 2006 17:58:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] drivers/char/random.c: unexport secure_ipv6_port_ephemeral
Message-ID: <20060409155822.GI8454@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(secure_ipv6_port_ephemeral).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 Apr 2006

--- linux-2.6.17-rc1-mm1-full/drivers/char/random.c.old	2006-04-05 17:00:04.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/char/random.c	2006-04-05 17:00:22.000000000 +0200
@@ -1584,7 +1584,6 @@
 
 	return twothirdsMD4Transform(daddr, hash);
 }
-EXPORT_SYMBOL(secure_ipv6_port_ephemeral);
 #endif
 
 #if defined(CONFIG_IP_DCCP) || defined(CONFIG_IP_DCCP_MODULE)

