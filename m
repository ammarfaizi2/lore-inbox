Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUB0AT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbUB0ATZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:19:25 -0500
Received: from nn7.excitenetwork.com ([207.159.120.61]:60946 "EHLO
	mprdmxin.myway.com") by vger.kernel.org with ESMTP id S261404AbUB0ATY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:19:24 -0500
To: linux-kernel@vger.kernel.org
Subject: TCP congestion control kernel parameters
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: ID = 04ddad92b28d5164754ebd8e49b93de3
Reply-To: steve_cawley@yahoo.com
From: "Stephen F. Cawley" <steve_cawley@myway.com>
MIME-Version: 1.0
X-Mailer: PHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <20040227001918.3C7ED3975@mprdmxin.myway.com>
Date: Thu, 26 Feb 2004 19:19:18 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a network application which needs to communicate in real time to clients which are spread around the globe.  There are times when there is not traffic on the network and the Initial Window shrinks.  When data is sent after these idle times, we are seeing up to a 1 second latency before the protocol comes up to speed.

Is it possible to avoid the TCP slow start algorithm and send at full speed or must we step up with every ACK?  I have been looking at the tcp_wmem and tcp_rmem kernel parameters, but am unsure whether they are the ones that I need to work with.

We are operating in a private network with RedHat 
2.4.9-e.25enterprise kernel.  

Thanks in advance.


--
Stephen F. Cawley




_______________________________________________
No banners. No pop-ups. No kidding.
Introducing My Way - http://www.myway.com
