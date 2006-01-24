Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWAXIBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWAXIBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWAXIBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:01:25 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:46304 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030218AbWAXIBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:01:25 -0500
Date: Tue, 24 Jan 2006 09:01:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060124080157.GA25855@elte.hu>
References: <1138089139.2771.78.camel@mindpipe> <20060124075640.GA24806@elte.hu> <1138089483.2771.81.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138089483.2771.81.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2006-01-24 at 08:56 +0100, Ingo Molnar wrote:
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > I ported the latency tracer to 2.6.16 and got this 13ms latency within 
> > > a few hours.  This is a regression from 2.6.15.
> > > 
> > > It appears that RCU can invoke ipv4_dst_destroy thousands of times in 
> > > a single batch.
> > 
> > could you try the PREEMPT_RCU patch below?
> 
> Sure.  If it works do you see this making it in 2.6.16?  Otherwise we 
> still would have a regression...

nope, that likely wont make v2.6.16, which is frozen already.

	Ingo
