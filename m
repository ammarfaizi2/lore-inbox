Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbVHSSm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbVHSSm6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVHSSm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:42:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49894 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932697AbVHSSm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:42:57 -0400
Date: Fri, 19 Aug 2005 11:43:34 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostdt@goodmis.org>
Subject: Re: 2.6.13-rc6-rt9
Message-ID: <20050819184334.GG1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050818060126.GA13152@elte.hu> <1124470574.17311.4.camel@twins> <1124476205.17311.8.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124476205.17311.8.camel@twins>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 08:30:05PM +0200, Peter Zijlstra wrote:
> On Fri, 2005-08-19 at 18:56 +0200, Peter Zijlstra wrote:
> > Hi Ingo, Paul, others,
> > 
> > I'm trying to run a user-mode-linux guest under the RT kernel however
> > the uml process never gets out of the calibrate delay loop. It seems as
> > if the signal never gets through.
> > 
> one clarification: the guest kernel is a non -rt kernel, a modified
> 2.6.13-rc6 in my case.
> 
> > A non -rt host kernel does work (with a similar .config).
> > 
> > Could this be related to pauls task list changes?

Possibly.  What signal?  This is a signal to a single process, right?

						Thanx, Paul
