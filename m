Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVJOXws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVJOXws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 19:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVJOXws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 19:52:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29677 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751259AbVJOXwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 19:52:47 -0400
Date: Sun, 16 Oct 2005 00:52:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: davem@davemloft.net
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mismerge in net/ipv6/netfilter/ip6_tables.c
Message-ID: <20051015235245.GB7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... duh

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc4-git4-base/net/ipv6/netfilter/ip6_tables.c current/net/ipv6/netfilter/ip6_tables.c
--- RC14-rc4-git4-base/net/ipv6/netfilter/ip6_tables.c	2005-10-15 16:21:34.000000000 -0400
+++ current/net/ipv6/netfilter/ip6_tables.c	2005-10-15 17:49:22.000000000 -0400
@@ -975,7 +975,6 @@
 		struct ip6t_entry *table_base;
 		unsigned int i;
 
-		for (i = 0; i < num_possible_cpus(); i++) {
 		for_each_cpu(i) {
 			table_base =
 				(void *)newinfo->entries
