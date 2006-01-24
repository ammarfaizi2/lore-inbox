Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWAXQ3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWAXQ3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 11:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWAXQ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 11:29:18 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:27552 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030359AbWAXQ3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 11:29:17 -0500
Date: Tue, 24 Jan 2006 21:58:46 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060124162846.GA7139@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1138089139.2771.78.camel@mindpipe> <20060124075640.GA24806@elte.hu> <1138089483.2771.81.camel@mindpipe> <20060124080157.GA25855@elte.hu> <1138090078.2771.88.camel@mindpipe> <20060124081301.GC25855@elte.hu> <1138090527.2771.91.camel@mindpipe> <20060124091730.GA31204@us.ibm.com> <20060124092330.GA7060@elte.hu> <1138095856.2771.103.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138095856.2771.103.camel@mindpipe>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 04:44:15AM -0500, Lee Revell wrote:
> On Tue, 2006-01-24 at 10:23 +0100, Ingo Molnar wrote:
> > * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > 
> > > The other patch to try would be Dipankar Sarma's patch at:
> > > 
> > > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=113657112726596&w=2
> > > 
> > > This patch was primarily designed to reduce memory overhead, but given 
> > > that it tends to reduce batch size, it should also reduce latency.
> > 
> > if this solves Lee's problem, i think we should apply this as a fix, and 
> > get it into v2.6.16. The patch looks straightforward and correct to me.
> > 
> 
> Does not compile:
> 
>  CC      kernel/rcupdate.o
> kernel/rcupdate.c:76: warning: 'struct rcu_state' declared inside parameter list

My original patch was against a much older kernel.
I will send out a more uptodate patch as soon as I am done with some
testing.

Thanks
Dipankar
