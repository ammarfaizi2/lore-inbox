Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVE3VNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVE3VNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVE3VMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:12:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29198 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261754AbVE3U44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:56:56 -0400
Date: Mon, 30 May 2005 22:56:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Subject: [2.6 patch] net/ipv6/ipv6_syms.c: unexport fl6_sock_lookup
Message-ID: <20050530205653.GZ10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no usage of this EXPORT_SYMBOL in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

---

This patch was already sent on:
- 7 May 2005

--- linux-2.6.12-rc3-mm3-full/net/ipv6/ipv6_syms.c.old	2005-05-05 22:23:17.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/ipv6/ipv6_syms.c	2005-05-05 22:23:23.000000000 +0200
@@ -37,5 +37,4 @@
 EXPORT_SYMBOL(xfrm6_rcv);
 #endif
 EXPORT_SYMBOL(rt6_lookup);
-EXPORT_SYMBOL(fl6_sock_lookup);
 EXPORT_SYMBOL(ipv6_push_nfrag_opts);

