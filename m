Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318318AbSG3QDv>; Tue, 30 Jul 2002 12:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318319AbSG3QDv>; Tue, 30 Jul 2002 12:03:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3205 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318318AbSG3QDs>;
	Tue, 30 Jul 2002 12:03:48 -0400
Date: Tue, 30 Jul 2002 12:07:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Hans Reiser <reiser@namesys.com>, Federico Ferreres <fferreres@ojf.com>,
       Daniel Mose <imcol@unicyclist.com>, Larry McVoy <lm@work.bitmover.com>,
       Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, openpatentfunds@home.se
Subject: Re: Funding GPL projects or funding the GPL?
In-Reply-To: <m165yygvtk.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0207301130020.4021-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 Jul 2002, Eric W. Biederman wrote:

> But the assertion made by Al Viro that software maintenance is where
> the bulk of the work is, is interesting.  Long term this is trivially
> true because the all of the code has been written, and there is no new
> development to do.  Services like distributions and device driver
> writers, and kernel maintainers appear to be in the area where
> maintenance is important.  Maintenance can be handled by
> maintenance/support contracts, making the economic model with closed
> source and open source the same, except with open source it is easier
> for multiple maintainers to cooperate.  And in the areas where the
> work is primarily maintenance is where open source has been observed
> to be well funded so this appears to work in practice.

That's _not_ the assertion I've made.  It's not about innovation vs.
maintenance and frankly, I'm insulted by that interpretation (which
is quite an achievement - I've got really thick skin).

Actual split is not into innovation and maintenance - it's into
new visible features and everything else.  Which happens to include
	* writing maintainable code.
	* designing sane interfaces.
	* writing code in a way that allows audits.
	* _doing_ audits of your code.
	* getting already existing code into form that allows aforementioned
new features - and if they are really new it's 99% of the work; the only
way to avoid it is by creating, er, private copies of existing subsystems
and kludging them up into something you can use.  Effects of such strategy
are left as an exercise to readers.  Or, if your new features happen to
be similar enough to something not new you get to reuse the work already
done back when those features were implemented.
	* etc., etc., including the things traditionally considered as
maintenance.

All mechanisms I've seen mentioned in that thread encourage only one thing -
new features as fast as possible at whatever cost for future work.  Calling
that innovation and relegating everything else to support contracts...  I'd
beg to differ.

THAT is the problem - mechanism that gives incentive to being quick, dirty and
sloppy (and encourages featuritis, while we are at it - inventing features
that are not new by any stretch of imagination and selling them as great
innovations is the oldest trick in the book).  Folks, it's not a good thing.
There's already more than enough pressure in that direction and it had
already given us dungpiles of unsupportable, exploit-ridden software.
Commercial and free alike.  And guess what?  After a while you _can't_
do anything really new on a platform, since it's already choke-full of kludges
from "quick innovators" - to the point when touching it in any non-trivial way
breaks something and nobody actually understands the thing enough to fix
the breakage, so more and more kludges are layered.  Sheesh...

