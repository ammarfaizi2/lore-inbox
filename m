Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSJaTVd>; Thu, 31 Oct 2002 14:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265352AbSJaTVd>; Thu, 31 Oct 2002 14:21:33 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:44910 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265351AbSJaTVc>;
	Thu, 31 Oct 2002 14:21:32 -0500
Date: Thu, 31 Oct 2002 20:27:52 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Bernd Petrovitsch <bernd@gams.at>, Matt Porter <porter@cox.net>,
       Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031202752.B12469@jaquet.dk>
References: <20021031100855.A3407@home.com> <22051.1036083179@frodo.gams.co.at> <20021031194348.A12469@jaquet.dk> <20021031191535.GA815@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021031191535.GA815@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Oct 31, 2002 at 12:15:35PM -0700
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2002 at 12:15:35PM -0700, Tom Rini wrote:
> There currently isn't a CONFIG_TINY / CONFIG_DESKTOP / CONFIG_FOO.  The
> idea is that all of these changes you're working on to make a smaller
> kernel shouldn't all be under CONFIG_TINY, but which ones are on / off
> are read from some sort of template and there's a default 'tiny'
> template, 'desktop' 'foo', etc template which has some on and some off.
>=20
> And this is a major concern since many of us who would have to deal with
> this when it enters the kernel want it to done in a flexible manner
> initially, not later on.

OK. This certainly makes sense and I'll be happy to redo my stuff to
match such a framework. This is not something I have thought a lot
about until now, though.

How would you go about implementing this? A central .h file with
tweakables and a number of templates setting these?

Regards,
  Rasmus

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wYQ4lZJASZ6eJs4RAirYAJsG9eQIcqHJLWb2YJqNDKXicr1MOACeIQ8k
uaI9yxkS+lZb4BbVjZCTkdg=
=jhOl
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
