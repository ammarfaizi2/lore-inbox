Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264719AbSKDQED>; Mon, 4 Nov 2002 11:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264722AbSKDQED>; Mon, 4 Nov 2002 11:04:03 -0500
Received: from turing.fb12.de ([80.76.224.45]:47006 "HELO turing.fb12.de")
	by vger.kernel.org with SMTP id <S264719AbSKDQEB>;
	Mon, 4 Nov 2002 11:04:01 -0500
Date: Mon, 4 Nov 2002 17:10:34 +0100
From: Sebastian Benoit <benoit-lists@fb12.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] tcp hang solved
Message-ID: <20021104171034.A474@turing.fb12.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	"David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20021104123824.A29797@turing.fb12.de> <20021104.055951.41634255.davem@redhat.com> <20021104141852.A31235@turing.fb12.de> <20021104.063928.71089343.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021104.063928.71089343.davem@redhat.com>; from davem@redhat.com on Mon, Nov 04, 2002 at 06:39:28AM -0800
X-MSMail-Priority: High
x-gpg-fingerprint: 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2F00
x-gpg-key: http://wwwkeys.de.pgp.net:11371
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

David S. Miller(davem@redhat.com)@2002.11.04 06:39:28 +0000:
>    From: Sebastian Benoit <benoit-lists@fb12.de>
>    Date: Mon, 4 Nov 2002 14:18:53 +0100
>   =20
>    I removed parts of 2.5.43-bk1 and that solved my problem, see attached=
 mail
>    below.
>=20
> That's just a list of files, can you send me the actual precise patch
> you reverted?

Okay, I redid that patch against plain 2.5.44. This patch removes most
networking changes that were done between 2.5.43 and 2.5.44. I rechecked
that 2.5.44 without this patch has the tcp-hang problem, with this patch it
works again.

Since it's 24kB compressed, I put it on http://turing.fb12.de/people/benoit=
/2.5.44-rn.gz

/B.
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0x5BA22F00 2001-07-31 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2=
F00

Astronomers do it with sextants.

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj3Gm/oACgkQTsThvluiLwD3hQCfZg3at3HtOoRhUgptg6RS8dT6
BegAniPB8rJWvh7QNzDS2lMw34Y0sZXM
=vTuH
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
