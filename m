Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWBAAS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWBAAS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWBAAS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:18:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932244AbWBAAS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:18:56 -0500
Date: Tue, 31 Jan 2006 16:18:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <1138751318.10316.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0601311553180.7301@g5.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> 
 <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca>
 <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com> 
 <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> 
 <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> 
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> 
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> 
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>
  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> 
 <1138620390.31089.43.camel@localhost.localdomain>  <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org>
  <43DF9D42.7050802@wolfmountaingroup.com>  <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org>
  <43DFB0F2.4030901@wolfmountaingroup.com>  <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org>
 <1138751318.10316.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Jan 2006, Alan Cox wrote:
> 
> I would argue its irrelevance

Well, I can absolutely agree with that.

It really wasn't ever meant to _change_ anything, so it definitely should 
be irrelevant in that sense. 

That said, I think it actually hass one big result: we may be discussing 
this for a couple of weeks, but I'm pretty sure we won't be discussing it 
for months and having a huge split over it in the kernel community. 

Which to me makes it less-than-irrelevant ;)

I actually tend to have two very different kinds of worries:

 - the technical problem of the month. Something doesn't work, and we 
   don't know why, and it's been broken for long enough that it seems to 
   be pretty fundamental.

   These things worry me, but they don't keep me up at night. 

 - the worry that somebody who submitted code to the kernel feels that his 
   code is mis-used and feels let down by the process.

   This thing _worries_ me. This is something I end up losing sleep over.

The second case is unusual, but it does happen. Things like the 
MMX-optimized AES routines, where Jari Ruusu ended up objecting to his 
code getting used. I really don't think he had any _legal_ reasons to feel 
that way, but _that_ is what really really tends to make me unhappy: 
regardless of legal correctness, I want developers to feel _proud_ of what 
they did in Linux, not feel like their code is being trampled on.

Do unto others.. and so on.

This is also why I don't much like BSD->GPL conversion, and try to ask the 
original author to OK it (the way we did with the original AES assembly 
code authored by Dr Brian Gladman - just to make sure). And regardless, I 
want to keep dual licenses _actively_ dual-licensed in the kernel, just to 
respect the original wishes instead of just converting them to the 
(stricter) GPLv2.

So the reason I've spent a lot of time on this thread is basically that I 
worry about people who would _like_ to upgrade (and incorrectly _expected_ 
to upgrade) the whole kernel to GPLv3 being unhappy.

So I'm spending time on this thread trying to make sure that everybody 
realizes that GPLv2 was always the license of choice - people may still 
have wished for something else, but at least I can do my damned best to 
explain why things are how they are, and explaining that any expectations 
to the contrary really were misguided.

> Two cases (lets call them a and b)
> 
> 	a) The GPLv2 only was always the case
> 	b) There was no version so it was open to choice
> 
> Which ultimately means either
> 
> 	a) Linus changed nothing
> 	b) Linus chose a version as the License allowed him to in accordance
> with section 9.
> 
> So we have two legal outcomes both of which produce the right answer for
> any vaguely recent source tree. At which point does it matter ?

Well, it does matter if somebody wants to start anew at the state we were 
at five years ago in the belief that that old state is GPLv3-compatible, 
and then add in the more modern part of the files that are explicitly 
compatible with GPLv3...

And if somebody feels _that_ strongly about it, and feels that five years 
ago there really was a real ambiguity, I'd be interested to hear his or 
her arguments. And I don't see myself likely objecting to it, if only 
because I'd be intrigued to see how far they get ;)

> Is there doubt about the license status of the current code - not in
> this area, no. The COPYING file is extremely clear on this, and more
> importantly in other possible unclear and problematic areas. For example
> the statement that the system calls are not derivative statement which
> resolves the biggest interpretation concern of all.

I was always surprised by how anybody could _possibly_ worry about that 
one, but it did come up very early. I forget exactly when, but I think 
that clarification was added way before Linux-1.0.

In general, people worry too much. And I worry about other people 
worrying.

Hopefully I also worry without any real cause.

		Linus
