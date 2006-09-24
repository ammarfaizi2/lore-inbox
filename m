Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWIXWlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWIXWlq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWIXWlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:41:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49861 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751422AbWIXWlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:41:45 -0400
Date: Sun, 24 Sep 2006 23:41:42 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] netlabel gfp annotations
Message-ID: <20060924224142.GX29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/net/netlabel.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index fc2b72f..dd5780b 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -108,7 +108,7 @@ #define NETLBL_LEN_U32                  
  */
 static inline struct sk_buff *netlbl_netlink_alloc_skb(size_t head,
 						       size_t body,
-						       int gfp_flags)
+						       gfp_t gfp_flags)
 {
 	struct sk_buff *skb;
 
-- 
1.4.2.GIT
