Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVEFXbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVEFXbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVEFXaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:30:12 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2567 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261335AbVEFXUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:20:03 -0400
Date: Sat, 7 May 2005 01:20:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] net/ipv6/ipv6_syms.c: unexport fl6_sock_lookup
Message-ID: <20050506232000.GC3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no usage of this EXPORT_SYMBOL in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc3-mm3-full/net/ipv6/ipv6_syms.c.old	2005-05-05 22:23:17.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv6/ipv6_syms.c	2005-05-05 22:23:23.000000000 +0200
@@ -37,5 +37,4 @@
 EXPORT_SYMBOL(xfrm6_rcv);
 #endif
 EXPORT_SYMBOL(rt6_lookup);
-EXPORT_SYMBOL(fl6_sock_lookup);
 EXPORT_SYMBOL(ipv6_push_nfrag_opts);

