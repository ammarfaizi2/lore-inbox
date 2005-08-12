Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVHLRXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVHLRXW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVHLRXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:23:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:24297 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750737AbVHLRXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:23:22 -0400
Date: Fri, 12 Aug 2005 19:21:51 +0200
From: Olaf Hering <olh@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.com>, "David S. Miller" <davem@davemloft.net>,
       ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
Subject: Re: [PATCH 0/8] netpoll: various bugfixes
Message-ID: <20050812172151.GA11104@suse.de>
References: <1.502409567@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1.502409567@selenic.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Aug 11, Matt Mackall wrote:

> This patch series cleans up a few outstanding bugs in netpoll:
> 
> - two bugfixes from Jeff Moyer's netpoll bonding
> - a tweak to e1000's netpoll stub
> - timeout handling for e1000 with carrier loss
> - prefilling SKBs at init
> - a fix-up for a race discovered in initialization
> - an unused variable warning

Matt, I have tested them, the sender doesnt lockup anymore. But a
task dump doesnt work, I get only the first task. This is on a 3GHz xeon
with tg3 card.
