Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292952AbSBVTLc>; Fri, 22 Feb 2002 14:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292954AbSBVTLM>; Fri, 22 Feb 2002 14:11:12 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:27155
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292952AbSBVTLH>; Fri, 22 Feb 2002 14:11:07 -0500
Date: Fri, 22 Feb 2002 10:58:25 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <Pine.LNX.4.33.0202220901470.6365-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.10.10202221053320.32372-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Obvious you have a bug up the backside, so I am totally hands off until
you and Martin are done.  See you back at 2.5.10.  I will not comment on
the changes because you want something and I do not have the timetable to
deliver and you are upset.

I am more concerned with the stablity of the core of ATA/ATAPI and next in
queue was to address the entire ATAPI data-phases issues that appear to
have some problems.

It is clear you want a cosmetic change and I am not ready to make one.

Therefore I will be patient and wait for you get the facelift you want and
then see what needs to be salvaged afterwards.

--a


On Fri, 22 Feb 2002, Linus Torvalds wrote:

> 
> 
> On Fri, 22 Feb 2002, Rik van Riel wrote:
> >
> > Martin,
> >
> > please tell us up-front if you are able to make Linux work
> > with 48-bit IDE stuff so Linux is able to talk to drives
> > larger than 137 GB.
> >
> > If you're not, please stop pissing off Andre and work
> > together with him ...
> 
> Rik, get off the high horse.
> 
> 2.5.x already supports 48-bit LBA addressing.
> 
> And quite frankly, it's not Martin who cannot work with Andre, it's Andre
> who so far has shown himself _totally_ unable to work with anybody at all.
> 
> Whenever somebody comes and even tries to do trivial and obviously correct
> cleanups that do not actually change any semantics at all, Andre stands
> out and shouts bloody murder from the rooftops, completely ignoring the
> fact that he hasn't even looked at the patches.
> 
> All the crap Andre has shouted about "IDE mess" and "timing changes" is
> total and utter CRAP. None of the patches I've seen has changed _anything_
> but cleanups, or removed _any_ features.
> 
> Guys, you need to realize that Martin is NOT the bad guy here. The problem
> is not Martin, the problem is that Andre cannot take any level or
> criticism, and in the five years or so that he has been maintainer I have
> yet to see a _single_ person who has been able to work together with him
> (as opposed to some people who have been able to maintain their own
> subdrivers _despite_ him).
> 
> Andre, your threats about not wanting to maintain 2.5.x are just a symptom
> of this inability to accept the fact that other people actually do know
> what they are doing, even if what they are doing is only cleanups with no
> semantic changes.
> 
> Rik, _look_ at the patches, instead of just taking Andre's word for it.
> 
> 			Linus

