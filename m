Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRARAks>; Wed, 17 Jan 2001 19:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130117AbRARAkd>; Wed, 17 Jan 2001 19:40:33 -0500
Received: from [129.94.172.186] ([129.94.172.186]:21231 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131104AbRARAkT>; Wed, 17 Jan 2001 19:40:19 -0500
Date: Thu, 18 Jan 2001 01:26:04 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Zlatko Calusic <zlatko@iskon.hr>, <linux-kernel@vger.kernel.org>
Subject: Re: Subtle MM bug
In-Reply-To: <20010110193340.D29093@athlon.random>
Message-ID: <Pine.LNX.4.31.0101180122480.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Andrea Arcangeli wrote:
> On Wed, Jan 10, 2001 at 10:46:07AM -0700, Eric W. Biederman wrote:

> > My impression with the MM stuff is that everyone except linux is
> > trying hard to clone BSD instead of thinking through the issues
> > ourselves.
>
> I wasn't even thinking about BSD and I always though about the
> issues myself, no panic ;).

Andrea, if you have the time, please do check out the
FreeBSD and NetBSD VM code.

The FreeBSD code has the original Mach overengineered
abstraction layer, but an absolutely kickass page
replacement strategy.

The NetBSD code has cleaned up the abstraction layer
into something nice and lower overhead, but has a lot
simpler (probably lower performance) page replacement.

It would be cool if some of the Linux hackers could take
the time and look at this code to see if there are some
good ideas we might want to have in Linux.

It might just be the case that we DON'T want to reinvent
the wheel (that others have made into a nice round shape
with 15 years of trial, error and redesigning).

(though I know some people prefer reinventing wheels ;))

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
