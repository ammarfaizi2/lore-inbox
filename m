Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVCNHh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVCNHh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 02:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVCNHh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 02:37:59 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45747 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261202AbVCNHhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 02:37:52 -0500
Date: Mon, 14 Mar 2005 02:37:26 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <1110578809.19661.2.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu>  <1108789704.8411.9.camel@krustophenia.net>
  <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain> 
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> 
 <20050311095747.GA21820@elte.hu>  <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
  <20050311101740.GA23120@elte.hu>  <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
  <20050311024322.690eb3a9.akpm@osdl.org>  <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
  <20050311153817.GA32020@elte.hu>  <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
  <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Mar 2005, Lee Revell wrote:

> On Fri, 2005-03-11 at 15:46 -0500, Lee Revell wrote:
> > On Fri, 2005-03-11 at 15:39 -0500, Steven Rostedt wrote:
> > > I'm leaving now for the weekend, so I won't be able to respond to anyone
> > > till Monday.  I'll also run this patch over the weekend while compiling
> > > the kernel in an endless loop
> >
> > I'll test this with PREEMPT_DESKTOP and data=ordered also and see how it
> > goes.
>
> Does not seem to work at all with the above settings.  It seemed OK
> until I started X.  Then every time I launched an xterm it would
> disappear as soon as I typed anything.  I could not switch consoles to
> see the Oops.
>

Hi Lee,

I just compiled PREEMPT_DESKTOP and mounted root (only disk filesystem on
my test machine) as data=ordered.  I had no problem getting to X, starting
an xterm and running a make. Actually it was a gnome-term since I didn't
have xterm. But then I su to root, apt-get xterm, ran xterm, and did a
make there with no problems.

Did you patch this against 39-02 or -40-X?

I haven't had time to upgrade to 40 yet.  Maybe, I'll work on that today.

Maybe your crash has something else to do with.  My test machine has a
serial hookup that I can look at even if the term goes down. I'll see if
40 gives me problems.

-- Steve
