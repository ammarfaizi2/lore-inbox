Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135378AbRAJTEA>; Wed, 10 Jan 2001 14:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135365AbRAJTDv>; Wed, 10 Jan 2001 14:03:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:60945 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135322AbRAJTDl>; Wed, 10 Jan 2001 14:03:41 -0500
Date: Wed, 10 Jan 2001 11:03:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrea Arcangeli <andrea@suse.de>, David Woodhouse <dwmw2@infradead.org>,
        Zlatko Calusic <zlatko@iskon.hr>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <m1elybgv1c.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 10 Jan 2001, Eric W. Biederman wrote:

> Andrea Arcangeli <andrea@suse.de> writes:
> > 
> > Once I or other developer finishes with the reverse lookup from page to
> > pte-chain (an implementation from DaveM just exists) we'll be able to put them
> > in a separate lru, but it's certainly not a 2.4.1-pre2 thing.
> 
> Why do we even want to do reverse page tables?

We don't.

But it does come up every once in a while, and it will probably continue
to do so.

I looked at it a year or two ago myself, and came to the conclusion that I
don't want to blow up our page table size by a factor of three or more, so
I'm not personally interested any more. Maybe somebody else comes up with
a better way to do it, or with a really compelling reason to.

"Feel free to try" is definitely the open source motto.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
