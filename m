Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVFJXDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVFJXDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVFJXDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:03:15 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:54795 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261378AbVFJXCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:02:54 -0400
Date: Fri, 10 Jun 2005 16:08:36 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Karim Yaghmour <karim@opersys.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610230836.GD21618@nietzsche.lynx.com>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610225231.GF6564@g5.random>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:52:31AM +0200, Andrea Arcangeli wrote:
> Just tell me how can you go to a customer and tell him that your
> linux-RTOS has a guaranteed worst case latency of 50usec.  How can you
> tell that? Did you exercise all possible scheduler paths with cache
> disabled and calculated the worst case latency with rdtsc + math?

Ask Ingo. I'm through with this track and your misinformed comments
about it. We just went through a 300+ plus thread discussing the issues
and you still apparently haven't read through the relevant portions of
it.
 
> Why do you take risks when you can go with much more relaible solutions
> like RTAI and rtlinux?

How are they more reliable ? explain that to me ?

> Said that there are many problems where metal-hard solutions are
> fine, every single app that don't require a worst-case guarantee of
> the worst-case latency is fine with metal-hard, and every time one has
> to call into the alsa ioctl or other complex syscalls also is fine with
> metal hard since the first kmalloc or lock contention inside RT context,
> will send your RTOS into water-hard state.

When you demonstrate a basic understanding of real time programming and
ask a relevant and informed question, then I'll be very happy to explain
this patch, single kernel RT design issues. Until then, I'm declaring
that I'm officially sick of reply to FUD generating comments from folks
that don't understand how this patch works.

bill

