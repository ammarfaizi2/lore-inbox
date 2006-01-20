Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWATSwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWATSwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWATSwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:52:33 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:7552 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750705AbWATSwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:52:33 -0500
Subject: Re: BUG in check_monotonic_clock()
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1137782896.3202.9.camel@localhost.localdomain>
References: <1137779515.3202.3.camel@localhost.localdomain>
	 <1137782296.27699.253.camel@cog.beaverton.ibm.com>
	 <1137782896.3202.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 10:52:28 -0800
Message-Id: <1137783149.27699.256.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 10:48 -0800, Daniel Walker wrote:
> On Fri, 2006-01-20 at 10:38 -0800, john stultz wrote:
> 
> > Hey Daniel,
> > 	Thanks for the bug report. Could you tell me what clocksource was being
> > used at the time? I'm guessing its the TSC, but usually we'll see
> > separate TSC inconsistency messages in the log.
> > 
> > thanks
> > -john
> > 
> 
> I had CONFIG_HPET_TIMER turned on. Also X86_TSC was on. 

So, booting up the box, what is the last message that looks like:

	Time: xyz clocksource has been installed.


thanks
-john

