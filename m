Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbSLRRcV>; Wed, 18 Dec 2002 12:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbSLRRcV>; Wed, 18 Dec 2002 12:32:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55056 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266006AbSLRRcU>; Wed, 18 Dec 2002 12:32:20 -0500
Date: Wed, 18 Dec 2002 09:41:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
In-Reply-To: <20021218165838.GD27695@suse.de>
Message-ID: <Pine.LNX.4.44.0212180936550.2891-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Dec 2002, Dave Jones wrote:
>
>  > I just don't know what that "something" should be. Any ideas? I thought
>  > about the code freeze require buy-in from three of four people (me, Alan,
>  > Dave and Andrew come to mind) for a patch to go in, but that's probably
>  > too draconian for now. Or is it (maybe start with "needs approval by two"
>  > and switch it to three when going into code freeze)?
>
> You'd likely need an odd number of folks in this cabal^Winner circle
> though, or would you just do it and be damned if you got an equal
> number of 'aye's and 'nay's ? 8-)

Quite frankly, I wouldn't expect a lot of dissent.

I suspect a group approach has very little inherent disagreement, and to
me the main result of having an "approval process" is to really just slow
things down and make people think about the submitting.  The actual
approval itself is secondary (it _looks_ like a primary objective, but in
real life it's just the _existence_ of rules that make more of a
difference).

> The approval process does seem to be quite a lot of work though.
> I think it was rth last year at OLS who told me that at that time
> he'd been doing more approving of other peoples stuff than coding himself.

I heartily disagree with the approval process for development, just
because it gets so much in the way and just annoys people. But for
stabilization, that's exactly what you want. So I think gcc is using the
approval process much too much, but apparently it works for them.

And I think it could work for the kernel too, especially the stable
releases and for the process of getting there. I just don't really know
how to set it up well.

		Linus

