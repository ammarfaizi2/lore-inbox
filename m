Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbRG0If0>; Fri, 27 Jul 2001 04:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267846AbRG0IfQ>; Fri, 27 Jul 2001 04:35:16 -0400
Received: from schiele.swm.uni-mannheim.de ([134.155.20.124]:18051 "EHLO
	schiele.swm.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267844AbRG0IfG>; Fri, 27 Jul 2001 04:35:06 -0400
Date: Fri, 27 Jul 2001 10:34:56 +0200
From: Robert Schiele <rschiele@uni-mannheim.de>
To: Niels Kristian Bech Jensen <nkbj@image.dk>
Cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
Message-ID: <20010727103456.B15014@schiele.swm.uni-mannheim.de>
In-Reply-To: <9jptj1$155$1@penguin.transmeta.com> <Pine.LNX.4.33.0107270852430.731-100000@hafnium.nkbj.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.33.0107270852430.731-100000@hafnium.nkbj.dk>; from nkbj@image.dk on Fri, Jul 27, 2001 at 08:55:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2001 at 08:55:52AM +0200, Niels Kristian Bech Jensen wrote:
> On Thu, 26 Jul 2001, Linus Torvalds wrote:
>=20
> >  - "static inline" means "we have to have this function, if you use it
> >    but don't inline it, then make a static version of it in this
> >    compilation unit"
> >
> >  - "extern inline" means "I actually _have_ an extern for this function,
> >    but if you want to inline it, here's the inline-version"
> >
> [SNIP]
> > ... we should just convert
> > all current users of "extern inline" to "static inline".
> >
> Doesn't work for the ones in include/linux/parport_pc.h, which have
> extern versions in drivers/parport/parport_pc.c. Gives build errors.

Is there any reason against just removing these functions from
drivers/parport/parport_pc.c? I do not see one. After all, they are
just duplicates.

Robert

--=20
Robert Schiele			mailto:rschiele@uni-mannheim.de
Tel./Fax: +49-621-10059		http://webrum.uni-mannheim.de/math/rschiele/

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEVAwUBO2EnsMQAnns5HcHpAQGZqwf/Q28YCzsd7URUJ2Uv6QgTlcKDbZOIFL/2
I8he+Zr1Nt9Bs61BrEYnnVWZYS9MwYcpCMknZhDJ2+wPCoM7ExE80H/73gz0LNdc
Mkd+vaMBAf4HvIvrKJ8vaT1KkM7KQm2MsGBZOs+nqRRo6kaOGAVyPO+Nm216xtwm
qNuvORKYQkCWNm7RRS4dAbIUI5BoOOYrAaifrCOtfOwWpXw3g8ZDgflI45FlDGcu
G5E9DsG/Y7bGFyTLwpWzU4EU/rGeE4WUmYKYqR85OTmW6GF0eDBDncZLjgTfHc81
sqD0vRZ0Z2FmC/AEpjung8+msS48D84djU6psr5+WVcB/lalkKmXyQ==
=a3w7
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
