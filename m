Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271129AbRITNR1>; Thu, 20 Sep 2001 09:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274441AbRITNRS>; Thu, 20 Sep 2001 09:17:18 -0400
Received: from discord.ws.crane.stargate.net ([216.151.124.71]:25732 "EHLO
	discord") by vger.kernel.org with ESMTP id <S271129AbRITNRE>;
	Thu, 20 Sep 2001 09:17:04 -0400
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
From: "steve j. kondik" <shade@chemlab.org>
To: Jens Axboe <axboe@suse.de>
Cc: Jari Ruusu <jari.ruusu@pp.inet.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20010920142555.B588@suse.de>
In-Reply-To: <1000912739.17522.2.camel@discord>
	<3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de>
	<3BA9DC30.DA46A008@pp.inet.fi>  <20010920142555.B588@suse.de>
X-Mailer: Evolution/0.13 (Preview Release)
Date: 20 Sep 2001 09:17:28 -0400
Message-Id: <1000991848.569.1.camel@discord>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_discord-23659-1000991848-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_discord-23659-1000991848-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

loop-aes does not work to encrypt swap using 2.4.10-pre12.  the same
panic results during mkswap.

On Thu, 2001-09-20 at 08:25, Jens Axboe wrote:
> On Thu, Sep 20 2001, Jari Ruusu wrote:
> > Jens Axboe wrote:
> > > On Thu, Sep 20 2001, Jari Ruusu wrote:
> > > > Cryptoapi can't be used to encrypt swap. It has nasties like sleepi=
ng in
> > > > make_request_fn() and potential memory allocation deadlock.
> > >=20
> > > sleeping in make_request_fn is not a nasty in itself, btw. in fact lo=
op
> > > just needs an emergency page pool for swap to be perfectly safe.
> >=20
> > loop-AES provides emergency page pool for device backed loop. Take a lo=
ok.
>=20
> Then sleeping in make_request_fn is not a nasty at all. In fact the
> kernel does it all the time anyways.
>=20
--=20
http://chemlab.org  -  email shade-pgpkey@chemlab.org for pgp public key
  chemlab radio!    -  drop out @ http://mp3.chemlab.org:8000   24-7-365

"i could build anything if i could just find my tools.."=09

--=_discord-23659-1000991848-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7qexoq7nxKnD1kxkRArH0AJ9Tyh4ESVFAXZTVk8xzOMtkSUN+pwCfX+sH
SskSU9AguoOTn1LnopHN568=
=GMAg
-----END PGP SIGNATURE-----

--=_discord-23659-1000991848-0001-2--
