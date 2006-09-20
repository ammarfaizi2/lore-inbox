Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWITRiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWITRiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWITRiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:38:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:6528 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932140AbWITRiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:38:07 -0400
Date: Wed, 20 Sep 2006 10:38:58 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060920173858.GB1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060920141907.GA30765@elte.hu> <200609201250.03750.gene.heskett@verizon.net> <1158771639.29177.5.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158771639.29177.5.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 10:00:38AM -0700, Daniel Walker wrote:
> On Wed, 2006-09-20 at 12:50 -0400, Gene Heskett wrote:
> 
> >   LD      .tmp_vmlinux1
> > kernel/built-in.o(.text+0x16f25): In function `hrtimer_start':
> > : undefined reference to `hrtimer_update_timer_prio'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > about half way thru the normal time.  config attached.  I don't think hires 
> > timers are enabled.
> > 
> > Comments?
> > 
> 
> Fix attached.
> 
> Daniel

Compiles for me with this patch.  Will try it out on a couple of machines.

							Thanx, Paul
