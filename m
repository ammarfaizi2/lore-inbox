Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283735AbRK3Rzv>; Fri, 30 Nov 2001 12:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283736AbRK3Rzd>; Fri, 30 Nov 2001 12:55:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62907 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283732AbRK3RzO>;
	Fri, 30 Nov 2001 12:55:14 -0500
Date: Fri, 30 Nov 2001 12:55:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Henning Schmiedehausen <hps@intermeta.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <1007140529.6655.37.camel@forge>
Message-ID: <Pine.GSO.4.21.0111301226190.15083-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 30 Nov 2001, Henning Schmiedehausen wrote:

> issue. Code that you consider ugly as hell may be seen as "easily
> understandable and maintainable" by the author. If it works and has no
> bugs, so what? Just because it is hard for you and me to understand (cf.

... it goes without peer review for years.  And that means bugs.

Fact of life: we all suck at reviewing our own code.  You, me, Ken Thompson,
anybody - we tend to overlook bugs in the code we'd written.  Depending on
the skill we can compensate - there are technics for that, but it doesn't
change the fact that review by clued people who didn't write the thing
tends to show bugs we'd missed for years.

If you really don't know that by your own experience - you don't _have_
experience.  There is a damn good reason for uniform style within a
project: peer review helps.  I've lost the count of bugs in the drivers
that I'd found just grepping the tree.  Even on that level review catches
tons of bugs.  And I have no reason to doubt that authors of respective
drivers would fix them as soon as they'd see said bugs.

"It's my code and I don't care if nobody else can read it" is an immediate
firing offense in any sane place.  It may be OK in academentia, but in the
real life it's simply unacceptable.

It's all nice and dandy to shed tears for poor, abused, well-meaning company
that had made everyone happy by correct but unreadable code and now gets
humiliated by mean ingrates.  Nice image, but in reality the picture is
quite different.  Code _is_ buggy.  That much is a given, regardless of
the origin of that code.  The only question is how soon are these bugs
fixed.  And that directly depends on the amount of efforts required to
read through that code.

Sigh...  Ironic that _you_ recommend somebody to grow up - I would expect
the level of naivety you'd demonstrated from a CS grad who'd never worked
on anything beyond his toy project.  Not from somebody adult.

