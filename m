Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292934AbSBVRI5>; Fri, 22 Feb 2002 12:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292935AbSBVRIr>; Fri, 22 Feb 2002 12:08:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11524 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292934AbSBVRIa>; Fri, 22 Feb 2002 12:08:30 -0500
Date: Fri, 22 Feb 2002 09:06:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <Pine.LNX.4.33L.0202220706540.7820-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0202220901470.6365-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Feb 2002, Rik van Riel wrote:
>
> Martin,
>
> please tell us up-front if you are able to make Linux work
> with 48-bit IDE stuff so Linux is able to talk to drives
> larger than 137 GB.
>
> If you're not, please stop pissing off Andre and work
> together with him ...

Rik, get off the high horse.

2.5.x already supports 48-bit LBA addressing.

And quite frankly, it's not Martin who cannot work with Andre, it's Andre
who so far has shown himself _totally_ unable to work with anybody at all.

Whenever somebody comes and even tries to do trivial and obviously correct
cleanups that do not actually change any semantics at all, Andre stands
out and shouts bloody murder from the rooftops, completely ignoring the
fact that he hasn't even looked at the patches.

All the crap Andre has shouted about "IDE mess" and "timing changes" is
total and utter CRAP. None of the patches I've seen has changed _anything_
but cleanups, or removed _any_ features.

Guys, you need to realize that Martin is NOT the bad guy here. The problem
is not Martin, the problem is that Andre cannot take any level or
criticism, and in the five years or so that he has been maintainer I have
yet to see a _single_ person who has been able to work together with him
(as opposed to some people who have been able to maintain their own
subdrivers _despite_ him).

Andre, your threats about not wanting to maintain 2.5.x are just a symptom
of this inability to accept the fact that other people actually do know
what they are doing, even if what they are doing is only cleanups with no
semantic changes.

Rik, _look_ at the patches, instead of just taking Andre's word for it.

			Linus

