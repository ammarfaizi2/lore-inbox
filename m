Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVFJUhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVFJUhg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVFJUhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:37:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31632 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261218AbVFJUhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:37:31 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread
From: Lee Revell <rlrevell@joe-job.com>
To: paulmck@us.ibm.com
Cc: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
In-Reply-To: <20050610154745.GA1300@us.ibm.com>
References: <20050608022646.GA3158@us.ibm.com>
	 <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com>
	 <1118372388.32270.6.camel@mindpipe>  <20050610154745.GA1300@us.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 16:38:24 -0400
Message-Id: <1118435904.6423.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 08:47 -0700, Paul E. McKenney wrote:
> > Does the LTP include an RT latency test yet?
> 
> Not as far as I know.  I believe that LTP contains primarily pass-fail
> rather than performance tests, but regardless of where RT latency
> tests live, I believe that there needs to be a good home for them.

Maybe I didn't mean LTP, I'm thinking of whatever that popular benchmark
suite is that people use to identify performance regressions.  OSDL
something or other?

The canonical test is "rtc_wakeup", it just sets up a stream of
interrupts from the RTC, polls on it and measures the delay.  Check the
list archives for the URL.

Lee

