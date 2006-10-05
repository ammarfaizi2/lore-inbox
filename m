Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWJEWWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWJEWWa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWJEWW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:22:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50828
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932366AbWJEWW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:22:28 -0400
Date: Thu, 05 Oct 2006 15:22:30 -0700 (PDT)
Message-Id: <20061005.152230.45740673.davem@davemloft.net>
To: simoneau@ele.uri.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061005211543.GA18539@ele.uri.edu>
References: <20061005211543.GA18539@ele.uri.edu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Thu, 5 Oct 2006 17:15:44 -0400

> Here's a pair of unaligned accesses I found playing with the eth1394 driver:
> 
> Kernel unaligned access at TPC[102c8190] ether1394_tx+0xf8/0x600 [eth1394]
> Kernel unaligned access at TPC[10162c8c] ether1394_data_handler+0x914/0x1000 [eth1394]

Thanks a lot for reporting this.  I have a similar report from
Harald Welte involving IPV6 to look at as well.

I'll try to get these all fixed up next week.

Thanks again.
