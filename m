Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVASGij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVASGij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 01:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVASGih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 01:38:37 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:34210 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261602AbVASGib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 01:38:31 -0500
Date: Tue, 18 Jan 2005 22:37:13 -0800
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119063713.GB26932@atomide.com>
References: <20050119000556.GB14749@atomide.com> <1106108467.4500.169.camel@gaston> <20050119050701.GA19542@atomide.com> <1106112525.4534.175.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106112525.4534.175.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [050118 21:29]:
> Hrm... reading more of the patch & Martin's previous work, I'm not sure
> I like the idea too much in the end... The main problem is that you are
> just "replaying" the ticks afterward, which I see as a problem for
> things like sched_clock() which returns the real current time, no ?

Well so far I haven't found problems with time. Since sched_clock()
returns the hw time, how does it cause a problem? Do you have some
example in mind? Maybe there's something I haven't even considered
yet.

> I'll toy a bit with my own implementation directly using Martin's work
> and see what kind of improvement I really get on ppc laptops.

I'd be interested in what you come up with :)

Tony
