Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVBAXna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVBAXna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVBAXna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:43:30 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:59026 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262123AbVBAXnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:43:24 -0500
Date: Tue, 1 Feb 2005 15:42:45 -0800
From: Tony Lindgren <tony@atomide.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050201234244.GM14274@atomide.com>
References: <20050127212902.GF15274@atomide.com> <1107289206.18349.16.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107289206.18349.16.camel@krustophenia.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell <rlrevell@joe-job.com> [050201 12:20]:
> On Thu, 2005-01-27 at 13:29 -0800, Tony Lindgren wrote:
> > Hi all,
> > 
> > Thanks for all the comments, here's an updated version of the dynamic
> > tick patch.
> 
> Hi,
> 
> I was wondering how Windows handles high res timers, if at all.  The
> reason I ask is because I have been reverse engineering a Windows ASIO
> driver, and I find that if the latency is set below about 5ms, by
> examining the kernel timer queue with SoftICE I can see that several
> kernel timers with 1ms period are created.  (Presumably the sound card's
> interval timer is used for longer periods).
> 
> But, I have seen people mention in the "singing capacitor" threads on
> this list that Windows uses 100 for HZ.
> 
> So, how do they implement 1ms timers with a 10ms tick rate?  Does
> Windows dynamically reprogram the PIT as well?

No idea, but it would probably show up by adding some debug code
some an emulator like Bochs?

Tony
