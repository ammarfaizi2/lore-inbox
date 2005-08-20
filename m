Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbVHTT1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVHTT1u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVHTT1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:27:50 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.25]:64832 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750819AbVHTT1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:27:49 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jeff Dike <jdike@addtoit.com>, paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostdt@goodmis.org>
In-Reply-To: <20050819184334.GG1298@us.ibm.com>
References: <20050818060126.GA13152@elte.hu>
	 <1124470574.17311.4.camel@twins> <1124476205.17311.8.camel@twins>
	 <20050819184334.GG1298@us.ibm.com>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 21:27:25 +0200
Message-Id: <1124566045.17311.11.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 11:43 -0700, Paul E. McKenney wrote:
> On Fri, Aug 19, 2005 at 08:30:05PM +0200, Peter Zijlstra wrote:
> > On Fri, 2005-08-19 at 18:56 +0200, Peter Zijlstra wrote:
> > > Hi Ingo, Paul, others,
> > > 
> > > I'm trying to run a user-mode-linux guest under the RT kernel however
> > > the uml process never gets out of the calibrate delay loop. It seems as
> > > if the signal never gets through.
> > > 
> > one clarification: the guest kernel is a non -rt kernel, a modified
> > 2.6.13-rc6 in my case.
> > 
> > > A non -rt host kernel does work (with a similar .config).
> > > 
> > > Could this be related to pauls task list changes?
> 
> Possibly.  What signal?  This is a signal to a single process, right?
> 
Jeff, could you help us out here?
What exactly does uml need to get out of the calibrate delay loop?

Kind regards,

Peter Zijlstra

