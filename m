Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286676AbRL1Bwo>; Thu, 27 Dec 2001 20:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286655AbRL1Bwc>; Thu, 27 Dec 2001 20:52:32 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:1744
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286649AbRL1BwY>; Thu, 27 Dec 2001 20:52:24 -0500
Date: Thu, 27 Dec 2001 20:36:45 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011227203645.A28510@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Tom Rini <trini@kernel.crashing.org>, Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227195738.A26889@thyrsus.com> <Pine.LNX.4.33.0112280219090.18346-100000@Appserv.suse.de> <20011228013654.GK712@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011228013654.GK712@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Thu, Dec 27, 2001 at 06:36:54PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org>:
> I think Keith wanted a very small time window tho (~24 hrs, barring big
> supprises).  But if we're going to be worried about the build time,
> kbuild-2.5 and cml2 aren't co-dependant, yes?  I know kbuild-2.5 works
> w/o cml2, and last I tried (ages ago admitedly) cml2 didn't need
> kbuild-2.5. 

That's right.  CML2 and kbuild-2.5 do not require each other

> So we could, in theory dump cml1 quickly but leave the old
> Makefiles for a bit longer.  Or if Keith thinks he can start on the
> speed problems soon, just plod along for a few releases. :)

As Keith has pointed out, old kbuild achieves its speed by being broken.
That's an argument for "plod along", IMHO.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

(Those) who are trying to read the Second Amendment out of the Constitution by
claiming it's not an individual right (are) courting disaster by encouraging
others to use the same means to eliminate portions of the Constitution they
don't like.
	-- Alan Dershowitz, Harvard Law School
