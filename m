Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUAESJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbUAESJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:09:47 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:38858 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S265253AbUAESJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:09:44 -0500
Date: Mon, 5 Jan 2004 18:09:27 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105180927.GB17606@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andries Brouwer <aebr@win.tue.nl>,
	Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
	rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
References: <20040105172900.GA359@ucw.cz> <Pine.LNX.4.44.0401050944420.17134-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401050944420.17134-100000@bigblue.dev.mdolabs.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2004 at 09:52:45AM -0800, Davide Libenzi wrote:
> On Mon, 5 Jan 2004, Vojtech Pavlik wrote:
> 
> > On Mon, Jan 05, 2004 at 08:13:26AM -0800, Linus Torvalds wrote:
> > 
> > > But the thing is, some things you simply _cannot_ number. For example, a
> > > two-dimensional space is innumerable - you need more than one integer
> > > number to look things up.  So is the set of real numbers (but not the set 
> > > of fractions), etc etc.
> > 
> > Two dimensional discrete space (*) is enumerable. Just start at [0,0]
> > and assign numbers going around the center in a growing spiral (**).
> > That way you assign a number to every point in that space. This is very
> > similar to the trick used to demonstrate fractions are enumerable.
> 
> Vojtech, a spiral (in the math sense) won't work because whatever 
> continuos function you choose for the radius, you are going to skip 
> integers when the radius grows (and duplicate them when it's small). Also, 
> IIRC, fractions are enumerable because they're a mapping from two 
> enumerable spaces (integers): F = F(I1, I2) = I1 / I2.

   I think he meant something like this:

( 0,  0)
( 1,  0)
( 0,  1)
(-1,  0)
( 0, -1)
( 2,  0)
( 1,  1)
( 0,  2)
(-1,  1)
(-2,  0)
(-1, -1)
etc.

   Rationals are countable since they're the product of the integers
(numerator) and the natural numbers without zero (denominator). You
can count them in a similar way to the above "spiral", making sure
that you don't count 1/2 and 2/4 as two different numbers. :)

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
      --- Try everything once,  except incest and folk-dancing. ---      

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+ahXssJ7whwzWGARAoirAKCHaDflKMZIbmkdc0AMhkY9lB1BXwCePprk
AsckPNphj0IJSRs3lSC4FKQ=
=PgHX
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
