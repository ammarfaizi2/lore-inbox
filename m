Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVCRG6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVCRG6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 01:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVCRG6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 01:58:46 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:58093 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261480AbVCRG6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 01:58:44 -0500
Date: Fri, 18 Mar 2005 01:58:36 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
In-Reply-To: <1111077383.23171.26.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0503180154420.21638@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain> 
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>  <20050315120053.GA4686@elte.hu>
  <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> 
 <20050315133540.GB4686@elte.hu>  <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
  <20050316085029.GA11414@elte.hu> <20050316020408.434cc620.akpm@osdl.org> 
 <20050316101906.GA17328@elte.hu> <20050316024022.6d5c4706.akpm@osdl.org> 
 <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain> 
 <20050316031909.08e6cab7.akpm@osdl.org>  <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
  <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain> 
 <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain> 
 <1111000818.21369.8.camel@mindpipe>  <Pine.LNX.4.58.0503170210530.17019@localhost.localdomain>
  <1111074082.23171.8.camel@mindpipe>  <Pine.LNX.4.58.0503171108510.17696@localhost.localdomain>
 <1111077383.23171.26.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Mar 2005, Lee Revell wrote:
>
> OK, no need to cc: me on this one any more.  It's really low priority
> IMO compared to the big latencies I am seeing with ext3 and
> "data=ordered".  Unless you think there is any relation.
>

IMO a deadlock is higher priority than a big latency :-)

I still belive that something to do with the locking in ext3 has to do
with your latencies, but I'll take you off when I send something to Andrew
or Ingo next time. Hopefully, they'll do the same.

When this problem is solved on Ingo's side, maybe this will solve your
latency problem, so I recommend that you keep trying the latest RT
kernels.  BTW what test are you running that causes these latencies?

-- Steve

