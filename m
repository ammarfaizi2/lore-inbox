Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbRACUz3>; Wed, 3 Jan 2001 15:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRACUzK>; Wed, 3 Jan 2001 15:55:10 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:62176 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131183AbRACUxF>; Wed, 3 Jan 2001 15:53:05 -0500
Message-ID: <3A53910D.CAEDF4FF@home.net>
Date: Wed, 03 Jan 2001 15:52:29 -0500
From: Shawn Starr <shawn.starr@home.net>
Reply-To: shawn.starr@home.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug McNaught <doug@wireboard.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SHM Not working in 2.4.0-prerelease
In-Reply-To: <3A537EA8.45889173@home.net> <m3g0j0l7e6.fsf@belphigor.mcnaught.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ahh ok, so everythings fine then. It would be nice though to see that
value perhaps in future they'll be a way.

Thanks,

Shawn.

Doug McNaught wrote:

> Shawn Starr <shawn.starr@home.net> writes:
>
> > [spstarr@coredump /etc]$ free
> >              total       used       free     shared    buffers
> > cached
> > Mem:         62496      61264       1232          0       1248
> > 28848
> >
> >
> > There's no shared memory being used?
>
> [...]
>
> > the shmfs is mounted. Is there any configuration i need to get shm
> > memory activiated?
>
> The 'shared' field in /proc/meminfo (source for 'top' and 'free') has
> nothing to do with {SysV,POSIX} shared memory.  The 'shared' field
> referred to memory that was used by more than one process (shared
> libraries, shared text segments etc).  As I understand it, under 2.4
> the 'shared' field is very expensive to calculate, so we don't--the
> zero value is there to avoid breaking programs that parse
> /proc/meminfo.
>
> -Doug

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
