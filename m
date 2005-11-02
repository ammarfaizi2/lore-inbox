Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVKBDcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVKBDcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 22:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKBDcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 22:32:45 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:57504 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932250AbVKBDcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 22:32:43 -0500
Subject: Re: 2.6.14-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Carlos Antunes <cmantunes@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
	 <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
	 <1130900716.29788.22.camel@localhost.localdomain>
	 <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 01 Nov 2005 22:32:22 -0500
Message-Id: <1130902342.29788.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 22:26 -0500, Carlos Antunes wrote:

> 
> It's a simple program I put together to test wakeup latency. Each
> thread basically sleeps for 20ms, wakes up and executes a couple of
> instructions and goes back to sleep for another 20ms. Multiply this by
> a thousand. What I found out is that, inthis situation, and using
> realtime-preempt, SCHED_OTHER offers 3 orders of magnitude less
> latency than SCHED_FIFO or SCHED_RR. Which suggests to me there is
> something fishy going on.

Could you supply this program?  I like to see what it does on my
systems.

Thanks,

-- Steve


