Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSFDU0T>; Tue, 4 Jun 2002 16:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSFDU0S>; Tue, 4 Jun 2002 16:26:18 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:22932 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S316705AbSFDU0Q>; Tue, 4 Jun 2002 16:26:16 -0400
Date: Tue, 4 Jun 2002 16:25:37 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: J Sloan <joe@tmsusa.com>
Cc: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        Larry McVoy <lm@bitmover.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
        "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        linux-kernel@vger.kernel.org
Subject: Re: please kindly get back to me
Message-ID: <20020604202537.GA4792@alcove.wittsend.com>
Mail-Followup-To: J Sloan <joe@tmsusa.com>,
	"M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
	Larry McVoy <lm@bitmover.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	"Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0206031302050.1038-100000@shell1.aracnet.com> <3CFBF795.3090602@tmsusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 04:11:17PM -0700, J Sloan wrote:

> M. Edward (Ed) Borasky wrote:

> >Now that there are Linux viruses, maybe we also need an open source
> >virus scanner.


> Ah yes, the perennial "linux virus" scare -
> the anti virus labs are hard at work trying
> to drum up new business....

> The thing with linux/unix "virii" is, they
> are actually for the most part trojans -
> they've been in labs for years, the problem
> is that there is no suitable transport vector!

	Dude...  Where have you been?

	Remember Ramen and L1on?

	I personally researched a DNS based worm that was infecting
RedHat 6.2 and 7.0 systems by exploiting the TSIG vulnerability to
propagate last year.  It was a mess.  I discovered three variations
on that worm, TSIG-A, TSIG-B and TSIG-C, that were in active propagation
in the wild.  Even with that, I only managed to account for 1/3 of the
DNS probing that got real hot just about a year ago (I think some of the
rest of it was exploiting the earlier INVQ hole).  Fortunately, that one
did largely die off a few months later.  It's still out there, though,
on a few systems and still hasn't been totally eradicated.

	Some of these things are carrying rootkits like Adore that even
include stealth kernel modules.  Some of them are pretty damn nasty.
Then you've got the {Win32,Linux}.simile virus than can infect both
Windows PE binaries and Linux ELF binaries.  It understands both binary
formats and can cross infect between platforms.  So now a constant
noise density of infected Windows machines can provide a host population
which threatens the Linux boxes.  Fortunately, this one has not spred
widely in the wild yet, but think of the cybernetic equivalent of Ebola.
What if Nimda or one of it's progeny get loaded with that virus in
it's payload package?  The sadmind worm was spreding and infecting back
and forth betweeen Windows and Solaris where it was running on two
different HARDWARE platforms and breaking into Solaris boxes through
the sadmind hole (hence the name).  It doesn't take a rocket scientist
to load the payloads with multiple binaries for multiple platforms and
archetectures and these things are being assembled "cookie cutter"
fashion now.

	The E-Mail based "social engineering" worms that have been plaguing
the Windows world may not have a foothold in the Linux world yet, but we
(Linux/Unix/BSD) are certainly NOT immune to viruses or worms (hell, the
first internet worm was the Robert Morris worm that infect Sun systems
and propagated through holes in sendmail and finger).

	These things have been suscessful and we've been successful,
so far, at beating them back.  But they ARE getting better and we are
NOT IMMUNE.  The vectors exist every time a new remote exploit is
revealed.  Recent hybrid threats are all script driven and a new
exploit can be loaded into the warhead of a worm in minutes of it
being published and circulated in the underground.  Rootkits do
exist which subvert binaries, libraries, and even the kernel.  Kits
exist out there right now that will even load a module into a kernel
which has no loadible module support (hint, /dev/kmem) so even that
is of little help.

	It's not theoretical and it's not just in the labs.  It's real
and it's in the wild now.  It just doesn't have the population
density and the monclonal culture to make it go BANG like the Windows
worms go.  Yet...

> You'd have to dupe an unwitting superuser
> (now there's a dangerous combination) into
> running the "virus" by hand - sort of like
> the "honor system" virus....

	You're making the mistake of assuming that all worms and viruses
are E-Mail based.  While it's true that the worst ones in the Windows
world include a "social engineering" E-Mail vector, that's only one
vector.  The real worst ones, like Nimda and its ilk, do not require
E-Mail to propagate even when the CAN use E-Mail to help them propagate.
In the case of Klez, it certainly proves that human stupidity remains are
largest security vulnerability.  But Nimda is out there on its own.  TSIG
is out there on Linux on its own.  Expect more.  Expect worse.

> Joe

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
