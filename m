Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVF1Au0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVF1Au0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVF1Au0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:50:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51963 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262241AbVF1AuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:50:17 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Chuck Harding <charding@llnl.gov>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.63.0506271327040.5120@ghostwheel.llnl.gov>
References: <20050608112801.GA31084@elte.hu>
	 <20050625091215.GC27073@elte.hu>
	 <200506250919.52640.gene.heskett@verizon.net>
	 <200506251039.14746.gene.heskett@verizon.net>
	 <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
	 <1119902991.4794.5.camel@dhcp153.mvista.com>
	 <Pine.LNX.4.63.0506271327040.5120@ghostwheel.llnl.gov>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 27 Jun 2005 17:50:12 -0700
Message-Id: <1119919812.4794.19.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 13:28 -0700, Chuck Harding wrote:
> On Mon, 27 Jun 2005, Daniel Walker wrote:
> 
> > If you have PREEMPT_RT enabled, it looks like interrupts are hard
> > disabled then there is a schedule_timeout() requested. You could try
> > turning off power management and see if you still have problems.
> >
> > Daniel
> >
> 
> Well, putting apm=off in the kernel command line did the trick. I am
> using a desktop system so apm really isn't needed. Time to change my
> standard config file..... Thanks.

Did it solve everything , including the virtual terminal switching, and
the scheduling with irqs disabled ?

Daniel

