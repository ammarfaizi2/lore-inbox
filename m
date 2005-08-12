Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVHLTWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVHLTWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVHLTWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:22:31 -0400
Received: from waste.org ([216.27.176.166]:35978 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751256AbVHLTW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:22:29 -0400
Date: Fri, 12 Aug 2005 12:21:52 -0700
From: Matt Mackall <mpm@selenic.com>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
Subject: Re: [PATCH 0/8] netpoll: various bugfixes
Message-ID: <20050812192152.GJ12284@waste.org>
References: <1.502409567@selenic.com> <20050812172151.GA11104@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812172151.GA11104@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[corrected akpm's address]

On Fri, Aug 12, 2005 at 07:21:51PM +0200, Olaf Hering wrote:
>  On Thu, Aug 11, Matt Mackall wrote:
> 
> > This patch series cleans up a few outstanding bugs in netpoll:
> > 
> > - two bugfixes from Jeff Moyer's netpoll bonding
> > - a tweak to e1000's netpoll stub
> > - timeout handling for e1000 with carrier loss
> > - prefilling SKBs at init
> > - a fix-up for a race discovered in initialization
> > - an unused variable warning
> 
> Matt, I have tested them, the sender doesnt lockup anymore. But a
> task dump doesnt work, I get only the first task. This is on a 3GHz xeon
> with tg3 card.

Does the task dump work without patch 5/8 (add retry timeout)? I'll
try testing it here.

-- 
Mathematics is the supreme nostalgia of our time.
