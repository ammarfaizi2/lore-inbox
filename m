Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbUDPQ1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbUDPQ1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:27:45 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:33492 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263308AbUDPQ1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:27:44 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-kernel@vger.kernel.org
Subject: kgdboe: spinlock already locked
Date: Fri, 16 Apr 2004 17:30:46 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404161730.46655.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using kgdboe with kernel 2.6.5-rc3-mm4.
After a while I got this:

drivers/net/8139too.c:2098: spin_lock(drivers/net/8139too.c:c15c93a0) already locked by drivers/net/8139too.c/2098
drivers/net/8139too.c:2120: spin_unlock(drivers/net/8139too.c:c15c93a0) not locked
drivers/net/8139too.c:2098: spin_lock(drivers/net/8139too.c:c15c93a0) already locked by drivers/net/8139too.c/2098
drivers/net/8139too.c:2120: spin_unlock(drivers/net/8139too.c:c15c93a0) not locked
eth0: link down
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

All the best,

Duncan.
