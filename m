Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270020AbRHGBK3>; Mon, 6 Aug 2001 21:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270021AbRHGBKT>; Mon, 6 Aug 2001 21:10:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5033 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270020AbRHGBKD>;
	Mon, 6 Aug 2001 21:10:03 -0400
Date: Mon, 6 Aug 2001 21:10:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108070051.f770pji27036@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108062053220.16817-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2001, Richard Gooch wrote:

> More importantly, the loop you used doesn't protect insertions into
> the table. So it's not safe on SMP.

Nope.  Allocation of entry itself is moved ahead of the loop, so
we insert immediately after expanding the thing.

> > PS: ObYourPropertyManager: karmic retribution?
> 
> Um, retribution for putting in an awful lot of time developing devfs
> (despite extreme hostility), at considerable personal sacrifice, and
> being patient and civilised to those who flamed against it? My, how
> I've been such a horrible person.

<tongue-in-cheek>
Nah, not that. Not plugging the holes that need to be plugged. Admit
it, there is some poetic justice in the situation.
</tongue-in-cheek>

As for the repugnant comments - IMO your "On the top of that, I have
a life" used in the context it was used in counts pretty high on that
scale. You know, you are _not_ unique in that respect.

Whatever.  I just hope that this time all that mess will be fixed and by
now I really don't care who does it and what does it take.

