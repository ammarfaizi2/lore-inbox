Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268089AbTAJBGQ>; Thu, 9 Jan 2003 20:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268091AbTAJBGQ>; Thu, 9 Jan 2003 20:06:16 -0500
Received: from smtp.comcast.net ([24.153.64.2]:55991 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S268089AbTAJBGQ>;
	Thu, 9 Jan 2003 20:06:16 -0500
Date: Thu, 09 Jan 2003 20:10:53 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: Pushing a stray sk_buff to the NIC
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux network development <netdev@oss.sgi.com>
Message-id: <1042161058.6107.18.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to take "hand-built" sk_buffs with little more than some data
and a dev member and push them to the NIC for transmission.  I would
like to simply give them to dev_queue_xmit.  Does anybody know what
state I should have them in before handing them to dev_queue_xmit? 
Should skb->data point to the start of a MAC header or an IP header?

Also, given an IP address in skb->nh.iph->daddr, what's the easiest way
to get the appropriate MAC address?

J



