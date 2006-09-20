Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWITUFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWITUFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWITUFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:05:40 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:32706 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750702AbWITUFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:05:39 -0400
Date: Wed, 20 Sep 2006 13:06:27 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060920200627.GE1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060920141907.GA30765@elte.hu> <200609201250.03750.gene.heskett@verizon.net> <1158771639.29177.5.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920173858.GB1292@us.ibm.com> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <1158777240.29177.16.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158777240.29177.16.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 11:34:00AM -0700, Daniel Walker wrote:
> On Wed, 2006-09-20 at 11:25 -0700, Paul E. McKenney wrote:
> > 
> > BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
> >  printing eip:
> > c01151ff
> > *pde = 34d21001
> > *pte = 00000000
> > stopped custom tracer.
> > Oops: 0000 [#1]
> > PREEMPT SMP 
> > Modules linked in:
> > CPU:    2
> > EIP:    0060:[<c01151ff>]    Not tainted VLI
> > EFLAGS: 00010246   (2.6.18-rt2-autokern1 #1) 
> > EIP is at __wake_up_common+0x10/0x55
> 
> I get this too, it happens when HRT is off.. If you turn HRT on it will
> boot .. I haven't found a fix for it, but I imagine Thomas will find it
> soon.

Enabling HRT works for me too -- thanks to you and Thomas for the hint!

							Thanx, Paul
