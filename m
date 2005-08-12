Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVHLCTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVHLCTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVHLCTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:19:46 -0400
Received: from waste.org ([216.27.176.166]:61863 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964780AbVHLCTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:19:45 -0400
Date: Thu, 11 Aug 2005 21:19:12 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>, "David S. Miller" <davem@davemloft.net>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
In-Reply-To: <8.502409567@selenic.com>
Message-Id: <9.502409567@selenic.com>
Subject: [PATCH 8/8] netpoll: remove unused variable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: l/net/core/netpoll.c
===================================================================
--- l.orig/net/core/netpoll.c	2005-08-11 01:32:01.000000000 -0500
+++ l/net/core/netpoll.c	2005-08-11 01:49:37.000000000 -0500
@@ -356,7 +356,6 @@ static void arp_reply(struct sk_buff *sk
 	unsigned char *arp_ptr;
 	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
 	u32 sip, tip;
-	unsigned long flags;
 	struct sk_buff *send_skb;
 	struct netpoll *np = NULL;
 
