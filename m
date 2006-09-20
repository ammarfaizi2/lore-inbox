Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWITRmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWITRmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWITRmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:42:05 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:65030 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932161AbWITRmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:42:02 -0400
Subject: Re: 2.6.18-rt1
From: Daniel Walker <dwalker@mvista.com>
To: paulmck@us.ibm.com
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060920173858.GB1292@us.ibm.com>
References: <20060920141907.GA30765@elte.hu>
	 <200609201250.03750.gene.heskett@verizon.net>
	 <1158771639.29177.5.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060920173858.GB1292@us.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 10:41:58 -0700
Message-Id: <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 10:38 -0700, Paul E. McKenney wrote:
> On Wed, Sep 20, 2006 at 10:00:38AM -0700, Daniel Walker wrote:
> > On Wed, 2006-09-20 at 12:50 -0400, Gene Heskett wrote:
> > 
> > >   LD      .tmp_vmlinux1
> > > kernel/built-in.o(.text+0x16f25): In function `hrtimer_start':
> > > : undefined reference to `hrtimer_update_timer_prio'
> > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > > about half way thru the normal time.  config attached.  I don't think hires 
> > > timers are enabled.
> > > 
> > > Comments?
> > > 
> > 
> > Fix attached.
> > 
> > Daniel
> 
> Compiles for me with this patch.  Will try it out on a couple of machines.
> 

Ingo actually updated with a similar fix , in

http://people.redhat.com/~mingo/realtime-preempt/patch-2.6.18-rt2

Daniel

