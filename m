Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269676AbRHIFkX>; Thu, 9 Aug 2001 01:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269679AbRHIFkO>; Thu, 9 Aug 2001 01:40:14 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:51217 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269676AbRHIFkC>; Thu, 9 Aug 2001 01:40:02 -0400
Date: Wed, 8 Aug 2001 22:39:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: How/when to send patches - (was  Re: [PATCH] one of $BIGNUM
 devfs races)
In-Reply-To: <15218.3327.402934.158296@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.33.0108082230480.7127-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Aug 2001, Neil Brown wrote:
>
> This is something I would like to understand better.
>
> Sometimes I send patches to Linus, and a new prepatch comes out within
> hours that contains them.
> Sometimes I send patches to Linus and it's like sending them to
> /dev/null. Sometimes I resend.  Sometimes it helps.

Re-sending is always the right thing to do. Sometimes it takes a few
times, and you can add a small exasperated message at the top by the third
time ("Don't you love me any more?").

> Now I am happy to just resent the pending patches every time a pre
> patch comes out that doesn't contain then, but I want to be sure that
> isn't going to negatively impact Linus at all.

It's not. Sometimes (like now), I have other priorities, and right now for
example I've been concentrating on the VM balancing issues (and, in all
honesty, sometimes the "other priorities" aren't Linux issues at all ;).

When that happens, any other patches may still be merged, but they might
equally well just end up staying pending in my mailbox. And if they stay
there for more than a day they are basically so stale that I'll likely
never see them again.

I _seldom_ have pending patches over a pre-patch, so while it is possible
that I'm still mulling over your old patch when a new pre-patch comes out,
it's much more likely that the right answer is just to re-send. Maybe with
a slightly bigger explanation on why the patch is such a good and worthy
patch ;^)

And it's absolutely not worth it to worry about filling up my mailbox with
patches. Rule of thumb is: "if it's not really _really_ important, try to
keep one pre-patch or 48 hours between re-sends". And if it is _really_
important, ping me as often as you like.

		Linus

