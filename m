Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWATTCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWATTCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWATTCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:02:34 -0500
Received: from [63.81.120.158] ([63.81.120.158]:57332 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S1750942AbWATTCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:02:33 -0500
Subject: Re: BUG in check_monotonic_clock()
From: Daniel Walker <dwalker@mvista.com>
To: john stultz <johnstul@us.ibm.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1137783149.27699.256.camel@cog.beaverton.ibm.com>
References: <1137779515.3202.3.camel@localhost.localdomain>
	 <1137782296.27699.253.camel@cog.beaverton.ibm.com>
	 <1137782896.3202.9.camel@localhost.localdomain>
	 <1137783149.27699.256.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 11:02:30 -0800
Message-Id: <1137783751.3202.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 10:52 -0800, john stultz wrote:
> On Fri, 2006-01-20 at 10:48 -0800, Daniel Walker wrote:
> > On Fri, 2006-01-20 at 10:38 -0800, john stultz wrote:
> > 
> > > Hey Daniel,
> > > 	Thanks for the bug report. Could you tell me what clocksource was being
> > > used at the time? I'm guessing its the TSC, but usually we'll see
> > > separate TSC inconsistency messages in the log.
> > > 
> > > thanks
> > > -john
> > > 
> > 
> > I had CONFIG_HPET_TIMER turned on. Also X86_TSC was on. 
> 
> So, booting up the box, what is the last message that looks like:
> 
> 	Time: xyz clocksource has been installed.

Last one is,
kernel: Time: tsc clocksource has been installed.

Isn't there a handy proc entry for this? 

Like /proc/sys/kernel/clocksource ?

Daniel


