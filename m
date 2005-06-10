Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVFJXPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVFJXPk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFJXPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:15:16 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13481 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261430AbVFJXMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:12:36 -0400
Date: Fri, 10 Jun 2005 16:12:58 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610231258.GJ1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <1118435904.6423.40.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118435904.6423.40.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 04:38:24PM -0400, Lee Revell wrote:
> On Fri, 2005-06-10 at 08:47 -0700, Paul E. McKenney wrote:
> > > Does the LTP include an RT latency test yet?
> > 
> > Not as far as I know.  I believe that LTP contains primarily pass-fail
> > rather than performance tests, but regardless of where RT latency
> > tests live, I believe that there needs to be a good home for them.
> 
> Maybe I didn't mean LTP, I'm thinking of whatever that popular benchmark
> suite is that people use to identify performance regressions.  OSDL
> something or other?
> 
> The canonical test is "rtc_wakeup", it just sets up a stream of
> interrupts from the RTC, polls on it and measures the delay.  Check the
> list archives for the URL.

OK, http://affenbande.org/~tapas/rtc_wakeup/ is the URL, right?

And LTP might well be a good home for it, I honestly don't know.

I am checking to see if this can be added to the set of tests run
in Martin's automated testing.  If you haven't looked at this, check
out:

http://www.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

This doesn't cover all the various RT variants of Linux, but might
focus some attention on mainline latency issues.

						Thanx, Paul
