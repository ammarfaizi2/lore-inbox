Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283936AbRLAFVp>; Sat, 1 Dec 2001 00:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283948AbRLAFVg>; Sat, 1 Dec 2001 00:21:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40209 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283971AbRLAFVV>; Sat, 1 Dec 2001 00:21:21 -0500
Date: Fri, 30 Nov 2001 21:15:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <20011130214448.A28617@hq2>
Message-ID: <Pine.LNX.4.33.0111302048200.1459-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Nov 2001, Victor Yodaiken wrote:
>
> Ok. There was no design, just "less than random mutations".
> Deep.

I'm not claiming to be deep, I'm claiming to do it for fun.

I _am_ claiming that the people who think you "design" software are
seriously simplifying the issue, and don't actually realize how they
themselves work.

> There was a overall architecture, from Dennis and Ken.

Ask them. I'll bet you five bucks they'll agree with me, not with you.
I've talked to both, but not really about this particular issue, so I
might lose, but I think I've got the much better odds.

If you want to see a system that was more thoroughly _designed_, you
should probably point not to Dennis and Ken, but to systems like L4 and
Plan-9, and people like Jochen Liedtk and Rob Pike.

And notice how they aren't all that popular or well known? "Design" is
like a religion - too much of it makes you inflexibly and unpopular.

The very architecture of UNIX has very much been an evolution. Sure, there
are some basic ideas, but basic ideas do not make a system.

When they say that the devil is in the details, they are trying to tell
you that the details MATTER. In fact, the details matter quite a lot more
than the design ever does.

> Here's a characteristic good Linux design method ,( or call it "less than random
> mutation method" if that makes you feel happy): read the literature,
> think hard, try something, implement

Hah.

I don't think I've seen very many examples of that particular design
methodology.

It's impressive that you think this is how stuff gets done, but from
personal experience I would say that it's certainly not true to any
noticeable degree. The impressive part is that Linux development could
_look_ to anybody like it is that organized.

Yes, people read literature too, but that tends to be quite spotty. t's
done mainly for details like TCP congestion control timeouts etc - they
are _important_ details, but at the same time we're talking about a few
hundred lines out of 20 _million_.

And no, I'm no tclaiming that the rest is "random". But I _am_ claiming
that there is no common goal, and that most development ends up being done
for fairly random reasons - one persons particular interest or similar.

It's "directed mutation" on a microscopic level, but there is very little
macroscopic direction. There are lots of individuals with some generic
feeling about where they want to take the system (and I'm obviously one of
them), but in the end we're all a bunch of people with not very good
vision.

And that is GOOD.

A strong vision and a sure hand sound like good things on paper. It's just
that I have never _ever_ met a technical person (including me) whom I
would trust to know what is really the right thing to do in the long run.

Too strong a strong vision can kill you - you'll walk right over the edge,
firm in the knowledge of the path in front of you.

I'd much rather have "brownian motion", where a lot of microscopic
directed improvements end up pushing the system slowly in a direction that
none of the individual developers really had the vision to see on their
own.

And I'm a firm believer that in order for this to work _well_, you have to
have a development group that is fairly strange and random.

To get back to the original claim - where Larry idolizes the Sun
engineering team for their singlemindedness and strict control - and the
claim that Linux seems ot get better "by luck": I really believe this is
important.

The problem with "singlemindedness and strict control" (or "design") is
that it sure gets you from point A to point B in a much straighter line,
and with less expenditure of energy, but how the HELL are you going to
consistently know where you actually want to end up? It's not like we know
that B is our final destination.

In fact, most developers don't know even what the right _intermediate_
destinations are, much less the final one. And having somebody who shows
you the "one true path" may be very nice for getting a project done, but I
have this strong belief that while the "one true path" sometimes ends up
being the right one (and with an intelligent leader it may _mostly_ be the
right one), every once in a while it's definitely the wrong thing to do.

And if you only walk in single file, and in the same direction, you only
need to make one mistake to die.

In contrast, if you walk in all directions at once, and kind of feel your
way around, you may not get to the point you _thought_ you wanted, but you
never make really bad mistakes, because you always ended up having to
satisfy a lot of _different_ opinions. You get a more balanced system.

This is what I meant by inbreeding, and the problem that UNIX
traditionally had with companies going for one niche.

(Linux companies also tend to aim for a niche, but they tend to aim for
_different_ niches, so the end result is the very "many different
directions" that I think is what you _want_ to have to survive).

> > And I will go further and claim that _no_ major software project that has
> > been successful in a general marketplace (as opposed to niches) has ever
> > gone through those nice lifecycles they tell you about in CompSci classes.
>
> That's classic:
> 	A) "trust me"
> 	B) now here's a monster bit of misdirection for you to choke on.
>
> Does anyone believe in those stupid software lifcycles?
> No.
> So does it follow that this has anything to do with design?
> No.

Hey, the whole _notion_ of "design" is that you know what you're going to
write, and you design for it.

Or do you have some other meaning of the word "design" that I haven't
heard about.

		Linus

