Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKHFZE>; Wed, 8 Nov 2000 00:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131081AbQKHFYy>; Wed, 8 Nov 2000 00:24:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11780 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129057AbQKHFYp>; Wed, 8 Nov 2000 00:24:45 -0500
Date: Tue, 7 Nov 2000 21:23:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: jt@hpl.hp.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dagb@fast.no>
Subject: Re: [RANT] Linux-IrDA status
In-Reply-To: <3A08DFCF.49845763@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.10.10011072109340.15388-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2000, Michael Rothwell wrote:
> Linus Torvalds wrote:
> > 
> > Also, I've never seen much in the form of explanation, and at least the
> > last patch I saw just the first screenful was so off-putting that I just
> > went "Ok, I have real bugs to fix, I don't need this crap".
>
> Like what? I'm not sure what you're saying here. It seems that the pople
> writing the IrDA code have gotten no feedback from you as to why their
> patch is never accepted -- could you clarify?

There's one _major_ reason why things never get accepted:

 CVS trees

I'm not fed patches. I'm force-fed big changes every once in a while. I
don't like it.

I like it even less when the very first screen of a patch is basically a
stupid change that implies that somebody calls ioctl's from interrupts.

When I get a big patch like that, where the very first screen is
bletcherous, what the hell am I supposed to do? I'm not going to waste my
time on people who cannot send multiple small and well-defined patches,
and who send be big, ugly, "non-maintained" (as far as I'm concerned)
patches.

I'm surprised Alan rants about this. He knows VERY well how I work, and is
(along with Jeff Garzik and Randy Dunlap) one of the people who are very
good at sending me 25 separate patches with explanations of what they do.

Basically, if you send me a big patch with tons of changes, how the hell
DO you expect me to answer them? Does anybodt really expect me to go
through ten thousand lines of code that I do not know, and comment on it?
Obviously not, as anybody with an ounce of sense would see.

So what choice do I have? Apply them blindly?

Quite frankly, I'd rather have a few people hate me deeply than apply
stuff I don't like. If I just start blindly applying big patches, I can
avoid nasty discussions. But I'd rather have people flame me. Maybe some
day people will instead start sending me smaller commented patches.

I'm NOT going to do other peoples work for them. If people can't be
bothered to send me well-specified patches ESPECIALLY now that we're close
to 2.4.x, then I can't be bothered to apply them,

Live with it. Hat eme all you like. I do not care. Th ething I care about
is not letting too much crap through unchecked.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
