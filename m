Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274571AbRITRUf>; Thu, 20 Sep 2001 13:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274572AbRITRUQ>; Thu, 20 Sep 2001 13:20:16 -0400
Received: from discord.ws.crane.stargate.net ([216.151.124.71]:23779 "EHLO
	discord") by vger.kernel.org with ESMTP id <S274571AbRITRUB>;
	Thu, 20 Sep 2001 13:20:01 -0400
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
From: "steve j. kondik" <shade@chemlab.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3BAA21B1.B579D368@pp.inet.fi>
In-Reply-To: <1000912739.17522.2.camel@discord>
	<3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de>
	<3BA9DC30.DA46A008@pp.inet.fi>  <20010920142555.B588@suse.de>
	<1000991848.569.1.camel@discord>  <3BAA21B1.B579D368@pp.inet.fi>
X-Mailer: Evolution/0.13 (Preview Release)
Date: 20 Sep 2001 13:20:25 -0400
Message-Id: <1001006425.1498.9.camel@discord>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_discord-29963-1001006426-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_discord-29963-1001006426-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hmm?  both cryptoapi and loop-aes work just fine when encrypting
anything but swap.  this is _only_ with kernel 2.4.10-pre12.  i would
suspect something changed that breaks swap on loopdev in general in this
kernel.

-steve

On Thu, 2001-09-20 at 13:04, Jari Ruusu wrote:
> "steve j. kondik" wrote:
> > loop-aes does not work to encrypt swap using 2.4.10-pre12.  the same
> > panic results during mkswap.
>=20
> Did you remove _any_ of the kernel compile time generated files from kern=
el
> source tree? Some of those generated files are _required_ to correctly
> compile modules.
>=20
> Regards,
> Jari Ruusu <jari.ruusu@pp.inet.fi>
>=20
--=20
http://chemlab.org  -  email shade-pgpkey@chemlab.org for pgp public key
  chemlab radio!    -  drop out @ http://mp3.chemlab.org:8000   24-7-365

"i could build anything if i could just find my tools.."=09

--=_discord-29963-1001006426-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7qiVZq7nxKnD1kxkRArfkAJ9XrGxFo9DCyAArfNb0NL6OmfmSKgCdE0YW
WMNF6dCV10w9sO9iNHUxhwI=
=wwCD
-----END PGP SIGNATURE-----

--=_discord-29963-1001006426-0001-2--
