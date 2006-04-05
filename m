Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWDEQgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWDEQgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWDEQgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:36:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33290 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751267AbWDEQgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:36:11 -0400
Date: Wed, 5 Apr 2006 18:36:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mpm@selenic.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] drivers/char/random.c: unexport secure_ipv6_port_ephemeral
Message-ID: <20060405163610.GG8673@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(secure_ipv6_port_ephemeral).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm1-full/drivers/char/random.c.old	2006-04-05 17:00:04.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/char/random.c	2006-04-05 17:00:22.000000000 +0200
@@ -1584,7 +1584,6 @@
 
 	return twothirdsMD4Transform(daddr, hash);
 }
-EXPORT_SYMBOL(secure_ipv6_port_ephemeral);
 #endif
 
 #if defined(CONFIG_IP_DCCP) || defined(CONFIG_IP_DCCP_MODULE)

