Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVKBDge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVKBDge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 22:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKBDge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 22:36:34 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:3106 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932237AbVKBDgd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 22:36:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jOIIYs3kLaQtgLAbx4D4lfMXE6bo8ACsIAvk/9vG+jeVhLQ8dw334obkxdWy1iT8DuCzoHq05gnmAoffTvKTB5/PFt2wlM1IErX8CWVXnLHqDVvgfUF/WGWJ2/YwJXt5cUlqWHOprjw+xQp7JKDSJ0alkpXawHQyhfBg18Gtm14=
Message-ID: <cb2ad8b50511011936w724389c2s65a6842bbccfafba@mail.gmail.com>
Date: Tue, 1 Nov 2005 22:36:31 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.14-rt1
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1130902342.29788.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
	 <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
	 <1130900716.29788.22.camel@localhost.localdomain>
	 <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
	 <1130902342.29788.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2005-11-01 at 22:26 -0500, Carlos Antunes wrote:
>
> >
> > It's a simple program I put together to test wakeup latency. Each
> > thread basically sleeps for 20ms, wakes up and executes a couple of
> > instructions and goes back to sleep for another 20ms. Multiply this by
> > a thousand. What I found out is that, inthis situation, and using
> > realtime-preempt, SCHED_OTHER offers 3 orders of magnitude less
> > latency than SCHED_FIFO or SCHED_RR. Which suggests to me there is
> > something fishy going on.
>
> Could you supply this program?  I like to see what it does on my
> systems.
>

Sure, let me just clean it up a little bit. I'll post it soon.

Carlos


--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson
