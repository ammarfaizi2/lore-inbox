Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVKRW0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVKRW0O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVKRW0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:26:14 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:39077 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751059AbVKRW0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:26:13 -0500
Date: Fri, 18 Nov 2005 17:25:42 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Thomas Gleixner <tglx@linutronix.de>,
       pluto@agmk.net, john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.14-rt13
In-Reply-To: <1132352143.6874.31.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0511181725030.17504@gandalf.stny.rr.com>
References: <20051115090827.GA20411@elte.hu>  <1132336954.20672.11.camel@cmn3.stanford.edu>
  <1132350882.6874.23.camel@mindpipe>  <1132351533.4735.37.camel@cmn3.stanford.edu>
  <20051118220755.GA3029@elte.hu> <1132352143.6874.31.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Nov 2005, Lee Revell wrote:

> On Fri, 2005-11-18 at 23:07 +0100, Ingo Molnar wrote:
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> >
> > > Arghhh, at least I take this as a confirmation that the TSCs do drift
> > > and there is no workaround. It currently makes the -rt/Jack
> > > combination not very useful, at least in my tests.
> > >
> > > Is there a way to resync the TSCs?
> >
> > no reasonable way. Does idle=poll make any difference?
>
> But JACK itself uses rdtsc() for timing calculations so TSC drift is
> invariably fatal.

Can it simply be pinned to a cpu?

-- Steve

