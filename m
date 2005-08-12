Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVHLCmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVHLCmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVHLCmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:42:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57831
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750752AbVHLCmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:42:16 -0400
Date: Thu, 11 Aug 2005 19:41:11 -0700 (PDT)
Message-Id: <20050811.194111.41635499.davem@davemloft.net>
To: mpm@selenic.com
Cc: akpm@osdl.com, ak@suse.de, jmoyer@redhat.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
Subject: Re: [PATCH 0/8] netpoll: various bugfixes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1.502409567@selenic.com>
References: <1.502409567@selenic.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Thu, 11 Aug 2005 21:18:28 -0500

> This patch series cleans up a few outstanding bugs in netpoll:
> 
> - two bugfixes from Jeff Moyer's netpoll bonding
> - a tweak to e1000's netpoll stub
> - timeout handling for e1000 with carrier loss
> - prefilling SKBs at init
> - a fix-up for a race discovered in initialization
> - an unused variable warning
> 
> This patch set was tested over repeated rebooting with both tg3 and
> e1000 and random cable disconnection, with and without SMP and
> preempt. Please apply.

All applied, thanks a lot for putting this patch set together.

I'll push this to Linus after some smoke testing.
