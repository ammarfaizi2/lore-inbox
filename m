Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTEZW3Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTEZW3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:29:00 -0400
Received: from web40007.mail.yahoo.com ([66.218.78.25]:61212 "HELO
	web40007.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262321AbTEZW13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:27:29 -0400
Message-ID: <20030526224041.1493.qmail@web40007.mail.yahoo.com>
Date: Mon, 26 May 2003 15:40:41 -0700 (PDT)
From: Jeff Smith <whydoubt@yahoo.com>
Subject: Re: [netfilter-core] [2.5.69 PATCH] - Trivial patch to Netfilter Kconfig 
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       zippel@linux-m68k.org
In-Reply-To: <20030526061024.5DA2C2C26E@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree the wording is still convoluted, here is the revised patch:

========================================================================
--- a/net/ipv4/netfilter/Kconfig        Sun May  4 18:53:37 2003
+++ b/net/ipv4/netfilter/Kconfig        Mon May 26 17:30:20 2003
@@ -120,8 +120,8 @@
        tristate "Packet type match support"
        depends on IP_NF_IPTABLES
        help
-         This patch allows you to match packet in accrodance
-         to its "class", eg. BROADCAST, MULTICAST, ...
+         Packet type matching allows you to match a packet by
+         its "class", eg. BROADCAST, MULTICAST, ...

          Typical usage:
          iptables -A INPUT -m pkttype --pkt-type broadcast -j LOG


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
