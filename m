Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbREUQWP>; Mon, 21 May 2001 12:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbREUQWF>; Mon, 21 May 2001 12:22:05 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:36868 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261553AbREUQVy>;
	Mon, 21 May 2001 12:21:54 -0400
Date: Mon, 21 May 2001 12:24:42 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Jes Sorensen <jes@sunsite.dk>, Jakob ?stergaard <jakob@unthought.net>,
        "Robert M. Love" <rml@tech9.net>,
        John Cowan <jcowan@reutershealth.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010521122442.B3151@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Tom Rini <trini@kernel.crashing.org>, Jes Sorensen <jes@sunsite.dk>,
	Jakob ?stergaard <jakob@unthought.net>,
	"Robert M. Love" <rml@tech9.net>,
	John Cowan <jcowan@reutershealth.com>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com> <d3wv7eptuz.fsf@lxplus015.cern.ch> <3B054500.2090408@reutershealth.com> <d31ypj1r4y.fsf@lxplus015.cern.ch> <990411054.773.0.camel@phantasy> <20010521043553.C20911@unthought.net> <d3ofsnowfp.fsf@lxplus015.cern.ch> <20010521083602.C9965@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010521083602.C9965@opus.bloom.county>; from trini@kernel.crashing.org on Mon, May 21, 2001 at 08:36:02AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org>:
> python1.5.x is compatiable w/ python2 EXCEPT in the cases where the script
> uses undocumented things which did work in python1.5.x.

That's true of the core language.  The reason I moved to 2.0 was that there
are library changes in 2.0 that enabled me to to cut CML2's in-kernel footprint
substantially.

> Which brings up another point, RedHat (7.1?) and Debian/woody both have the
> option of having python2 around.  Anyone know about mandrake?  My point is
> that some dists are already dealing with python2.

Yes.  By the time 2.5 forks, distros covering an estimated 85% of the market
will carry python2 binaries which the CML2 install script will find 
automatically.  By the time 2.6 forks, we're going to laugh if we ever
remember that we thought this was an issue.

> Eric, would it be easy/possible to go back to requiring python 1.5.x for
> CML2, since that is what many dists ship with?

It wouldn't be too difficult.  But it would make the code heavier, and
I'm not clear that it would make anybody happy who isn't already willing
to deal with the design concept.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The world is filled with violence. Because criminals carry guns, we
decent law-abiding citizens should also have guns. Otherwise they will
win and the decent people will lose.
        -- James Earl Jones
