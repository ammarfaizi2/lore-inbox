Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWATSsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWATSsU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWATSsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:48:20 -0500
Received: from [63.81.120.158] ([63.81.120.158]:22260 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S1750705AbWATSsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:48:19 -0500
Subject: Re: BUG in check_monotonic_clock()
From: Daniel Walker <dwalker@mvista.com>
To: john stultz <johnstul@us.ibm.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1137782296.27699.253.camel@cog.beaverton.ibm.com>
References: <1137779515.3202.3.camel@localhost.localdomain>
	 <1137782296.27699.253.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 10:48:16 -0800
Message-Id: <1137782896.3202.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 10:38 -0800, john stultz wrote:

> Hey Daniel,
> 	Thanks for the bug report. Could you tell me what clocksource was being
> used at the time? I'm guessing its the TSC, but usually we'll see
> separate TSC inconsistency messages in the log.
> 
> thanks
> -john
> 

I had CONFIG_HPET_TIMER turned on. Also X86_TSC was on. 

Daniel


