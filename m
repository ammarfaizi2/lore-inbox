Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135545AbRA1C4f>; Sat, 27 Jan 2001 21:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135775AbRA1C4Z>; Sat, 27 Jan 2001 21:56:25 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:52108 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S135545AbRA1C4P>; Sat, 27 Jan 2001 21:56:15 -0500
Message-ID: <3A738A36.F6294623@Home.net>
Date: Sat, 27 Jan 2001 21:55:51 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.com>
CC: Andrew Morton <andrewm@uow.edu.au>, Chris Mason <mason@suse.com>,
        Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.xkernels?
In-Reply-To: <186870000.980100593@tiny> <3A6B6FDE.93AF69CC@Home.net> <3A72820A.1488BDC@uow.edu.au> <3A7280F5.F122FE35@Home.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, the patch HAS made a difference. For example, while untaring glibc-2.2.1.tar.gz the
system was not sluggish (mouse movements in X) etc.

Seems to be a go for latency improvements on this system.

Shawn Starr wrote:

> Applying now.
>
> Andrew Morton wrote:
>
> > Shawn,
> >
> > I've pretty much completed the low-latency patch against reiserfs.
> > It seems to be a little more latency-prone than ext2, but under normal
> > workloads it's not significant.  The worst-case is 100 milliseconds,
> > but that's when you're doing insane things to it.
> >
> > You may care to apply http://www.uow.edu.au/~andrewm/linux/2.4.1-pre10-low-latency.patch
> > against 2.4.1-pre10 and see if it "feels" different.  I'd be surprised
> > if it does, but the result would be interresting.
> >
> > Note that the low-latency capability must be enabled under the
> > "Processor type and features" menu, and if you also enable the
> > low-latency sysctl option, you'll need to
> >
> >         echo 1 > /proc/sys/kernel/lowlatency
> >
> > to make it happen.  Creature feep :)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
