Return-Path: <linux-kernel-owner+w=401wt.eu-S1422868AbWLUPqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422868AbWLUPqE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 10:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422908AbWLUPqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 10:46:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58749 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422868AbWLUPqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 10:46:03 -0500
Date: Thu, 21 Dec 2006 15:46:00 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] dumb typo in generic csum_ipv6_magic()
Message-ID: <20061221154600.GJ17561@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... duh

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/include/net/ip6_checksum.h b/include/net/ip6_checksum.h
index 68e2b32..bc1b0fd 100644
--- a/include/net/ip6_checksum.h
+++ b/include/net/ip6_checksum.h
@@ -87,7 +87,7 @@ static __inline__ __sum16 csum_ipv6_magi
 	carry = (sum < uproto);
 	sum += carry;
 
-	return csum_fold((__force __wsum)csum);
+	return csum_fold((__force __wsum)sum);
 }
 
 #endif
