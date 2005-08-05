Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbVHEVzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbVHEVzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVHEVxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:53:17 -0400
Received: from neveragain.de ([217.69.76.1]:33742 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S261962AbVHEVwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:52:55 -0400
Date: Fri, 5 Aug 2005 23:52:47 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
Message-ID: <20050805215247.GA25652@minerva.local.lan>
References: <20050805192628.GA24706@minerva.local.lan> <20050805195056.GB7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20050805195056.GB7991@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender succeded SMTP AUTH authentication, not delayed by milter-greylist-1.4 (hobbit.neveragain.de [217.69.76.1]); Fri, 05 Aug 2005 23:52:46 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2005 at 12:50:56PM -0700, Chris Wright wrote:
> * Martin Loschwitz (madkiss@madkiss.org) wrote:
> > I just ran into the following problem: Having updated my box to 2.6.12.=
3,=20
> > I tried to start YaST2 and noticed a kernel panic (see below). Some qui=
ck
> > debugging brought the result that the kernel crashes while some user (n=
ot
> > even root ...) tries to access /proc/ioports. Is this a known problem a=
nd
> > if so, is a fix available?
>=20
> First I've heard of it.  I can't trigger here with simple cat
> /proc/ioports.  Must be specific to your setup.  What was the last
> working kernel, and what's that ioport output look like?
>=20

The situation in this case is somewhat obscene ... Originally, I had exactly
this problem while using the Knoppix standard kernel (2.6.11 vanilla SMP). I
then went to compile 2.6.12.3, also with SMP, and it showed exactly the same
problem. I disable SMP, tried again -- voila, it worked.

The kernel that I am encountering this error again now is 2.6.12.3 -- witho=
ut
SMP or whatsoever. I'm just out of ideas on how to fix it this time.

> thanks,
> -chris

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC89+vHPo+jNcUXjARAvSRAJ9nHLXulfOscf+Q+wTNangbcvkWvgCgvfL6
Hec334bcxo5S2PTrAfpTXE8=
=CBJI
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
