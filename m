Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264243AbTCXQlI>; Mon, 24 Mar 2003 11:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264267AbTCXQer>; Mon, 24 Mar 2003 11:34:47 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:58346 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264295AbTCXQbE>; Mon, 24 Mar 2003 11:31:04 -0500
Message-Id: <200303241642.h2OGgD35008350@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:42:00 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: __ipv6_regen_rndid typo fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/net/ipv6/addrconf.c linux-2.5/net/ipv6/addrconf.c
--- bk-linus/net/ipv6/addrconf.c	2003-03-24 13:14:54.000000000 +0000
+++ linux-2.5/net/ipv6/addrconf.c	2003-03-24 13:19:01.000000000 +0000
@@ -1111,7 +1111,7 @@ regen:
 	if (time_before(idev->regen_timer.expires, jiffies)) {
 		idev->regen_timer.expires = 0;
 		printk(KERN_WARNING
-			"__ipv6_regen_rndid(): too short regeneration interval; timer diabled for %s.\n",
+			"__ipv6_regen_rndid(): too short regeneration interval; timer disabled for %s.\n",
 			idev->dev->name);
 		in6_dev_put(idev);
 		return -1;
