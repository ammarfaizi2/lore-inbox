Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135911AbRA1DWR>; Sat, 27 Jan 2001 22:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136011AbRA1DWG>; Sat, 27 Jan 2001 22:22:06 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:26754 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135911AbRA1DVx>; Sat, 27 Jan 2001 22:21:53 -0500
Message-ID: <3A739205.7C71EF89@uow.edu.au>
Date: Sun, 28 Jan 2001 14:29:09 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.net>
CC: Shawn Starr <Shawn.Starr@Home.com>, Chris Mason <mason@suse.com>,
        Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.xkernels?
In-Reply-To: <186870000.980100593@tiny> <3A6B6FDE.93AF69CC@Home.net> <3A72820A.1488BDC@uow.edu.au> <3A7280F5.F122FE35@Home.com> <3A738A36.F6294623@Home.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> 
> Andrew, the patch HAS made a difference. For example, while untaring glibc-2.2.1.tar.gz the
> system was not sluggish (mouse movements in X) etc.
> 
> Seems to be a go for latency improvements on this system.

hmm..  OK, thanks.

Chris, this seems to be a worthwhile improvement to mainstream
reiserfs, independent of the low-latency thing.   You can
probably achieve 10 milliseconds with just a few lines of
code - a subset of the patch which Shawn tested. (Unless you
were planning on magical algorithmic improvements...).

I'm all set up to generate those few lines of code, so
I'll propose a patch later this week.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
