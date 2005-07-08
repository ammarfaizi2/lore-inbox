Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVGHLiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVGHLiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVGHLiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:38:18 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:18883 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S262552AbVGHLiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:38:13 -0400
Subject: Re: [git patches] IDE update
From: Erik Slagter <erik@slagter.name>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>,
       Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <koerc1h7m0iri2pdrvsa0pu2tjakobq78o@4ax.com>
References: <42C9C56D.7040701@tomt.net>
	 <42CA5A84.1060005@rainbow-software.org> <20050705101414.GB18504@suse.de>
	 <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de>
	 <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux>
	 <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux>
	 <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de>
	 <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <42CDAD94.7000306@rtr.ca>
	 <koerc1h7m0iri2pdrvsa0pu2tjakobq78o@4ax.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4txJhgJWWR6AwRZDpPBm"
Date: Fri, 08 Jul 2005 13:37:42 +0200
Message-Id: <1120822662.23681.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4txJhgJWWR6AwRZDpPBm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-08 at 10:06 +1000, Grant Coady wrote:

> I've not been able to get dual channel I/O speed faster than single=20
> interface speed, either as 'md' RAID0 or simultaneous reading or=20
> writing done the other day:
>=20
> Time to write or read 500MB file:
>=20
> >summary		2.4.31-hf1	2.6.12.2
> >boxen \ time ->	 w 	 r	 w	 r
> >---------------	----	----	----	----
> ...
> >peetoo			33	20	26.5	22
> >(simultaneuous		57	37.5	52	38.5)
>=20
> MB/s		2.4.31-hf1	2.6.12.2
> 		w	r	w	r
> single		15	25	19	23
> dual		17.5	27	19	26
>=20
> These timings show very little happening in parallel, is that normal?

"me too" ;-)

--=-4txJhgJWWR6AwRZDpPBm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCzmWGJgD/6j32wUYRAr8rAJ9190t/vD4C2LrnRiSGmSiX7nvxeACfSBFN
cfHF0oTcpeJPobjfZ2H3Ktg=
=BWwZ
-----END PGP SIGNATURE-----

--=-4txJhgJWWR6AwRZDpPBm--
