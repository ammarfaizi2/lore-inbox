Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVI1LSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVI1LSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 07:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVI1LSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 07:18:06 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:59790 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751210AbVI1LSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 07:18:05 -0400
Date: Wed, 28 Sep 2005 07:17:50 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Simon White <s_a_white@email.com>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Best Kernel Timers?
In-Reply-To: <20050928100858.824F5101D9@ws1-3.us4.outblaze.com>
Message-ID: <Pine.LNX.4.58.0509280712300.5529@localhost.localdomain>
References: <20050928100858.824F5101D9@ws1-3.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Sep 2005, Simon White wrote:

> >
> > Also you may be interested in Ingo Molnar's RT kernel.
> >
> > http://people.redhat.com/mingo/realtime-preempt/
>
> Unless I'm mistaken this is a external patch i.e. not in mainline?
> I do know of the work, but people willing to patch the kernel
> should hopefully equally be able to cope with an rtai or rtlinux
> patch.  If this is integrated into mainline I'll definately
> check it out.

You may have to wait a while.  The biggest difference between Ingo's patch
and rtai is that Ingo's patch doesn't require changing the programs to run
as realtime tasks.  It makes the Linux kernel an actual RTOS (as suppose
to running a micro kernel underneath) so if you can program on Linux,
there's no learning curve for Ingo's work.

>
> >
> > As well as the work being done by the HRT folks.
> >
> > http://sourceforge.net/projects/high-res-timers
> >
>
> I posted a similiar question there but received no response.  From
> what I can tell it is a frame work for providing hardware specific
> timer sources to the kernel and also exporting posix userspace
> system calls from the kernel.  It may do more in kernel but haven't
> found exactly what it does, relevent docs?  Also is this in mainline
> (or soon to be) or just patches against it?

I'm not really sure what you have against patches?  If you have to wait
for this to be in the mainline, you are going to be disappointed.

-- Steve
