Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284899AbRLURoL>; Fri, 21 Dec 2001 12:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284913AbRLURoB>; Fri, 21 Dec 2001 12:44:01 -0500
Received: from mail.ece.umn.edu ([128.101.168.129]:35793 "EHLO
	mail.ece.umn.edu") by vger.kernel.org with ESMTP id <S284899AbRLURnr>;
	Fri, 21 Dec 2001 12:43:47 -0500
Date: Fri, 21 Dec 2001 11:43:40 -0600
From: Bob Glamm <glamm@mail.ece.umn.edu>
To: Mike Jagdis <jaggy@purplet.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in	Configure.help.
Message-ID: <20011221114340.B29076@kittpeak.ece.umn.edu>
In-Reply-To: <B848EEB6.406C%mail@rene-engelhard.de> <3C2359C6.6010506@purplet.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C2359C6.6010506@purplet.demon.co.uk>; from jaggy@purplet.demon.co.uk on Fri, Dec 21, 2001 at 03:48:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 03:48:22PM +0000, Mike Jagdis wrote:
> Rene Engelhard wrote:
> 
> >  Christian Groessler wrote:
> >>So, is it 1/1024 or 1/1000 bytes ?  :-)
> >>
> > 
> > 1/1024. Because we are talking about byte.
> 
> Bollocks. How can I put this politely? Don't anyone ever send me
> a CV unless you know the technical basics!

The IEC has adopted these units, not SI.  And you could argue that
the IEC has gotten it completely wrong.

Basic unit of length:      1 m
Basic unit of weight:      1 g
...
Basic unit of information: 1 *bit*

Not a byte.  A byte is 8 basic units of information.

To be consistent (as with SI), all prefixes should be applied to
the basic unit of measurement - in this case, a bit.  And one
kilobit == 1000 bits; one megabit == 1 million bits.

Saying "kilobyte" is like saying "micromicrofarad" or "megakilometer".

However, you *could* also argue that the IEC has it correct.  IIRC,
physicists researching electrostatics/magnetostatics at least used to use
(and maybe still do) the centimeter/gram/second units - e.g. an abcoulomb,
which ends up being 10 coulombs.  For whatever reason, convention among
this group of people means using cgs units.  For whatever reason,
convention among computer people is to use units of 8 bits - 1 byte -
as a measurement standard.

> Go look up "SI binary prefix" and "SI prefix" on Google. You might
> not _like_ the binary prefixes (I don't either) but they're what's
> been standardized and they're unambiguous. It does no good to claim
> that it's enough that *you* know what you mean. This isn't Alice in
> Wonderland (you can look that reference up in your spare time :-) ).

SI standards have been around for years.  Yet many mechanical
engineers in the US still use English units.  Convention and
economics dictate that they do so; any change in this field is quite
slow.

Somehow I expect that the same convention and economics factors will
also dominate the argument over prefixes for bits of information
in this field for years to come as well.

-Bob
