Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRA1EAz>; Sat, 27 Jan 2001 23:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135972AbRA1EAe>; Sat, 27 Jan 2001 23:00:34 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:18430 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131349AbRA1EAc>; Sat, 27 Jan 2001 23:00:32 -0500
Message-ID: <3A73993F.DA35B57E@Home.net>
Date: Sat, 27 Jan 2001 22:59:59 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Shawn Starr <Shawn.Starr@Home.com>, Chris Mason <mason@suse.com>,
        Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.xkernels?
In-Reply-To: <186870000.980100593@tiny> <3A6B6FDE.93AF69CC@Home.net> <3A72820A.1488BDC@uow.edu.au> <3A7280F5.F122FE35@Home.com> <3A738A36.F6294623@Home.net> <3A739205.7C71EF89@uow.edu.au>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It should also be noted, that while using GCC and other tasks, the latency has returned to 2.2
levels from my point. Before. If you want to me to do any testing I can do that.

I applied the timepegs patch:

Kernel timepegs enabled. See http://www.uow.edu.au/~andrewm/linux/

Shawn.

> >
> > Andrew, the patch HAS made a difference. For example, while untaring glibc-2.2.1.tar.gz the
> > system was not sluggish (mouse movements in X) etc.
> >
> > Seems to be a go for latency improvements on this system.
>
> hmm..  OK, thanks.
>
> Chris, this seems to be a worthwhile improvement to mainstream
> reiserfs, independent of the low-latency thing.   You can
> probably achieve 10 milliseconds with just a few lines of
> code - a subset of the patch which Shawn tested. (Unless you
> were planning on magical algorithmic improvements...).
>
> I'm all set up to generate those few lines of code, so
> I'll propose a patch later this week.
>
> -

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
