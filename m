Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbRL2TCj>; Sat, 29 Dec 2001 14:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285250AbRL2TCb>; Sat, 29 Dec 2001 14:02:31 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:38585 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S285236AbRL2TCQ>; Sat, 29 Dec 2001 14:02:16 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: george anzinger <george@mvista.com>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Date: Sat, 29 Dec 2001 20:02:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Martin Knoblauch <knobi@sirius-cafe.de>,
        Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011229190226Z285236-18284+8993@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:
> 
> > Re: [RFC] Scheduler issue 1, RT tasks ...
> >
> > >
> > > Right, that was my question. George says, in your words, "for better
> >
> > > standards compliancy ..." and I want to know why you guys think
> > that.
> >
> > The thought was that if someone need RT tasks he probably need a very
> > low latency and so the idea that by applying global preemption decisions
> > would lead to a better compliancy. But i'll be happy to ear that this is
> > false anyway ...
> >
> 
>  without wanting to start a RT flame-fest, what do people really want
> when they talk about RT in this [Linux] context:
> 
> - very low latency
> - deterministic latency ("never to exceed")
> - both
> - something completely different
> 
> All of the above from time to time and user to user.  That is, some
> folks want one or more of the above, some folks want more, some less. 
> What is really up?  Well they have a job to do that requires certain
> things.  Different jobs require different capabilities.  It is hard to
> say that any given system will do a reasonably complex job with out
> testing.  For example we may have the required latency but find the
> system fails because, to get the latency, we preempted another task that
> was (and so still is) in the middle of updating something we need to
> complete the job.

So George what direction should I try for some tests?
2.4.17 plus your and Robert's preempt plus lock-break?
Add your high-res-timers, rtscheduler or both?
Do they apply against 2.4.17/2.4.18-pre1?
A combination of the above plus Davide's BMQS?

I ask because my MP3/Ogg-Vorbis hiccup during dbench isn't solved anyway.
Running 2.4.17 + preempt + lock-break + 10_vm-21 (AA).
Some wisdom?

Thank you for all your work and
			Happy New Year

-Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
