Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRDNHkv>; Sat, 14 Apr 2001 03:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRDNHkl>; Sat, 14 Apr 2001 03:40:41 -0400
Received: from bigD.kappa.ro ([194.102.255.132]:2571 "EHLO bigD.kappa.ro")
	by vger.kernel.org with ESMTP id <S129245AbRDNHka>;
	Sat, 14 Apr 2001 03:40:30 -0400
Date: Sat, 14 Apr 2001 10:40:26 +0300 (EEST)
From: Doru Petrescu <pdoru@kappa.ro>
Reply-To: pdoru@kappa.ro
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: problem with the timers ?!? (was: No one wants to help me)
In-Reply-To: <3AD7696B.FB80F2B6@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0104141018150.10445-100000@bigD.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem is, it seems that your machine is using
> IPV4, TCP, IDE, netfilter and nothing else.  Those
> parts of the kernel don't have the above bug (well,
> they didn't mid last year).
> 
> One really, really useful piece of information would
> be the value of the `function' member of the corrupted
> timer.  Your debug code prints this out.  Do you still
> have the logs?
> 
> Was it ever non-zero?
> 
> If so, what function was it pointing at?


The matchine crashed several times, BEFORE I modified timer.c
it did NOT CRASHED even once after that :( 
I am waiting for it to chrash.
when it will crash, I will let you guys know.

But, as I stated before, I fear that because of the changes, the race
condition does not happen any more ...


Best regards,
------
Doru Petrescu
KappaNet - Senior Software Engineer
E-mail: pdoru@kappa.ro		 LINUX - the choice of the GNU generation


