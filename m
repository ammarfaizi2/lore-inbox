Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUIGPhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUIGPhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUIGPel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:34:41 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:18367 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S267446AbUIGP34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:29:56 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R8
From: Alexander Nyberg <alexn@dsv.su.se>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
In-Reply-To: <20040907150406.GA29468@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu>
	 <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen>
	 <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu>
	 <20040907115722.GA10373@elte.hu> <1094568658.670.11.camel@boxen>
	 <20040907150406.GA29468@elte.hu>
Content-Type: text/plain
Message-Id: <1094570992.716.2.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Sep 2004 17:29:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Looks fine over here on 2-CPU, debian 64-bit user-space with both
> > preempt & voluntary preempt turned on. Init seems to explode (gets
> > killed over and over, not sure how this happens) on
> > CONFIG_LATENCY_TRACE, I'll take a look at that later today unless you
> > have any offender you're aware of.
> 
> > +#ifdef CONFIG_LATENCY_TRACE
> > +EXPORT_SYMBOL(mcount);
> > +#endif
> 
> thanks, i've added this to latency.c. You can find my current snapshot
> at:
> 
>   http://redhat.com/~mingo/private/voluntary-preempt-2.6.9-rc1-bk12-R9-A6
> 
> there are alot of changes - perhaps one of them fixes your LATENCY_TRACE
> problem - but the likelyhood is low, for me LATENCY_TRACE worked fine on
> amd64 even with -R8.

I didn't even get to see any text before it rebooted, hmm? I'll take a
look with -R8 later as for LATENCY_TRACE, do you know what could have
caused this sudden reboot?

