Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318505AbSGZVUC>; Fri, 26 Jul 2002 17:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318508AbSGZVUC>; Fri, 26 Jul 2002 17:20:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53694 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318505AbSGZVUB>;
	Fri, 26 Jul 2002 17:20:01 -0400
Date: Fri, 26 Jul 2002 17:23:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Federico Ferreres <fferreres@ojf.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Funding GPL projects or funding the GPL?
In-Reply-To: <1027714551.961.61.camel@fede>
Message-ID: <Pine.GSO.4.21.0207261642500.21586-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 26 Jul 2002, Federico Ferreres wrote:

[sigh... I shouldn't be doing that, but...]
 
> Idea 1: You do have $10 and you are trying to free-ride (honest answer).
> 
> Idea 2: You don't have $10 or $20 a year to "spare"? Then probably you are using 
> (old and) already supported hardware. And because past years developements
> are free as in beer. If you ARE a developer, you get a free permament 
> membership so you shouldn't care about all this.
> 
> Idea 3: Make bugfixes and hardware support are always GPL and not fGPL. The fGPL
> will force you to distribute under GPL (or fGPL, at your choise).
> 
> Idea 4: Write your own drivers if nobody else would.
> 
> Idea 5: You are a student and as such are granted a free membership
> until you finish your studies.

What you and the rest of armchair generals do not get is that "adding
features" is _not_ the hard part of work.  Doing that in a way that
wouldn't be a permanent source of bugs afterwards and cleaning up the
existing sources of bugs _IS_.  So is doing infrastructure work.  So
is auditing code.  So is removing crap code.

None of that is covered by your "model".  99:1 that your "working driver
for card" is going to contain a bunch of root holes.  _And_ be unmaintainable.

I had seen quite a few vendor drivers.  Every time I'm looking at one of
them, I'm reminded of MST3K.  Yup, Mistery Science Theater 3000.  With
guy being forced to watch crap selected to drive him mad.

And it's not just vendor drivers.  Example: recently a new version of
cpio(1) had been released (after 6 years of inactivity).  It still
contains idiotic holes reported (with fixes) years ago.  Many times.
Some of these holes going back to 1993 (first report I'd been able to
find, followed by ~5 rediscoveries of the same bug).  Who should be
paying to whom in cases like that?

The thing being, absolute majority of software is crap.  That has nothing
to getting paid for it and everything with average quality of programmers.
For how many years did the (well-paid) rogering tosspots in SGI ship IRIX
with sendmail choke-full of known root holes? (not to mention that
it was configured as an open relay effectively hiding the IP of submitting
host - spammers' dream come true).  For how many years did Sun ship
systems with mind-boggling default configuration? (NIS holes galore)
For how many years does Microsoft ship what they are shipping?

As long as crap software is considered acceptable and people who write
crap - employable, the things will be bad and job market - overcrowded.
It's that simple.

