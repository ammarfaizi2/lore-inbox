Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422958AbWAMUw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422958AbWAMUw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWAMUw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:52:58 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:20648 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422950AbWAMUw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:52:56 -0500
Date: Fri, 13 Jan 2006 15:52:49 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Lee Revell <rlrevell@joe-job.com>
cc: tglx@linutronix.de, "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       Roger Heflin <rheflin@atipa.com>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Subject: RE: Dual core Athlons and unsynced TSCs
In-Reply-To: <1137185313.15108.72.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0601131551140.7201@gandalf.stny.rr.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com> 
 <1137168254.7241.32.camel@localhost.localdomain>  <1137174463.15108.4.camel@mindpipe>
  <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com> 
 <1137174848.15108.11.camel@mindpipe>  <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
  <1137178506.15108.38.camel@mindpipe>  <1137182991.8283.7.camel@localhost.localdomain>
  <1137183980.6731.1.camel@localhost.localdomain>  <1137184982.15108.69.camel@mindpipe>
  <1137185175.7634.37.camel@localhost.localdomain> <1137185313.15108.72.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2006, Lee Revell wrote:

> On Fri, 2006-01-13 at 21:46 +0100, Thomas Gleixner wrote:
> > On Fri, 2006-01-13 at 15:43 -0500, Lee Revell wrote:
> >
> > > Ugh.  In arch/x86_64/kernel/time.c monotonic_clock() uses the TSC
> > > unconditionally.
> >
> > Can you try
> >
> > http://tglx.de/projects/hrtimers/2.6.15/patch-2.6.15-hrt2.patch
> >
> > please ?
>
> I can try it (well I can pass it on to someone who has the hardware),
> but that's a huge patch, not likely to be mergeable in the 2.6.16
> timeframe.  Surely there has to be a way this can be fixed for 2.6.16?

I'll try it.

If it works, at least it might give us a clue to what to do.

-- Steve

