Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSLIKxR>; Mon, 9 Dec 2002 05:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbSLIKxR>; Mon, 9 Dec 2002 05:53:17 -0500
Received: from smtp.laposte.net ([213.30.181.11]:12021 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S265098AbSLIKxQ>;
	Mon, 9 Dec 2002 05:53:16 -0500
Subject: Re: /proc/pci deprecation?
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ob27XeyK9bSmA359scTc"
Organization: 
Message-Id: <1039431647.16940.14.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-3) 
Date: 09 Dec 2002 12:00:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ob27XeyK9bSmA359scTc
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[Please CC me replies as I'm not on the list ]

Hi

	When I added kt400 agp support recently (just a ID declaration since
generic via routines work fine on my box), I had to declare the KT400
pci id in gart. Which was the only thing really needed (or so I thought
in a sane world).

	Then I did the 2.4 patch. And guess what ? I found I had to declare it
in dri (two times, ie for each versions supported) and in the pci id
database. What kind of madness is it ? How many people do you expect to
update *four* lists with the same info (and btw the last time I checked
2.4 followups were not merged in 2.5) ?

	And all this time lspci knew my chip. In fact, I *used* lspci info to
get the right info to put in the kernel. And to this day since not
everything was merged in 2.5 lspci is more accurate than the kernel.

	So from my very na=EFve point of view /proc/pci wouldn't be mourned,
quite the contrary.

Regards,

--=20
Nicolas Mailhot

--=-ob27XeyK9bSmA359scTc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA99HffI2bVKDsp8g0RAmMcAKD1u4rrECDOnoGC4rM3UNAMvkjJhgCgh4UB
sYIm2oLu027MxN0V5RXwlds=
=b6LE
-----END PGP SIGNATURE-----

--=-ob27XeyK9bSmA359scTc--

