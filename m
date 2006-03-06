Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752406AbWCFTHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbWCFTHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbWCFTHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:07:47 -0500
Received: from fmr19.intel.com ([134.134.136.18]:62170 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752405AbWCFTHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:07:46 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>, <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>
Cc: <openib-general@openib.org>
Subject: [PATCH 3/6] net/IB: export ip_dev_find
Date: Mon, 6 Mar 2006 11:07:44 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <adaslpz2l9p.fsf@cisco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcY/FYSDoSObWDAKRKyl93Kwz34rUACOz9oA
Message-ID: <ORSMSX4011XvpFVjCRG00000006@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 06 Mar 2006 19:07:44.0470 (UTC) FILETIME=[3FC57760:01C64151]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export ip_dev_find to allow locating a net_device given an IP address.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>

---

diff -uprN -X linux-2.6.git/Documentation/dontdiff 
linux-2.6.git/net/ipv4/fib_frontend.c 
linux-2.6.ib/net/ipv4/fib_frontend.c
--- linux-2.6.git/net/ipv4/fib_frontend.c	2006-01-16 10:28:29.000000000 -0800
+++ linux-2.6.ib/net/ipv4/fib_frontend.c	2006-01-16 16:14:24.000000000 -0800
@@ -666,4 +666,5 @@ void __init ip_fib_init(void)
 }
 
 EXPORT_SYMBOL(inet_addr_type);
+EXPORT_SYMBOL(ip_dev_find);
 EXPORT_SYMBOL(ip_rt_ioctl);



