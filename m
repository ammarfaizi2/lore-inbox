Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVCRSUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVCRSUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVCRSTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:19:40 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:27822 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262023AbVCRST2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:19:28 -0500
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
From: Lee Revell <rlrevell@joe-job.com>
To: rostedt@goodmis.org
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503180154420.21638@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	 <20050315120053.GA4686@elte.hu>
	 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	 <20050315133540.GB4686@elte.hu>
	 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	 <20050316085029.GA11414@elte.hu> <20050316020408.434cc620.akpm@osdl.org>
	 <20050316101906.GA17328@elte.hu> <20050316024022.6d5c4706.akpm@osdl.org>
	 <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
	 <20050316031909.08e6cab7.akpm@osdl.org>
	 <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
	 <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
	 <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
	 <1111000818.21369.8.camel@mindpipe>
	 <Pine.LNX.4.58.0503170210530.17019@localhost.localdomain>
	 <1111074082.23171.8.camel@mindpipe>
	 <Pine.LNX.4.58.0503171108510.17696@localhost.localdomain>
	 <1111077383.23171.26.camel@mindpipe>
	 <Pine.LNX.4.58.0503180154420.21638@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 13:19:23 -0500
Message-Id: <1111169963.11065.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 01:58 -0500, Steven Rostedt wrote:
> 
> On Thu, 17 Mar 2005, Lee Revell wrote:
> >
> > OK, no need to cc: me on this one any more.  It's really low priority
> > IMO compared to the big latencies I am seeing with ext3 and
> > "data=ordered".  Unless you think there is any relation.
> >
> 
> IMO a deadlock is higher priority than a big latency :-)
> 

Of course, if I was hitting the deadlock in normal use.

> I still belive that something to do with the locking in ext3 has to do
> with your latencies, but I'll take you off when I send something to Andrew
> or Ingo next time. Hopefully, they'll do the same.

If you suspect they are related then yes I would like to be copied.

> 
> When this problem is solved on Ingo's side, maybe this will solve your
> latency problem, so I recommend that you keep trying the latest RT
> kernels.  BTW what test are you running that causes these latencies?

dbench 16

Lee

