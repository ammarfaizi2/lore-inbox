Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSK0Qjy>; Wed, 27 Nov 2002 11:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSK0Qjy>; Wed, 27 Nov 2002 11:39:54 -0500
Received: from ns1.canonical.org ([209.115.72.29]:2200 "EHLO
	panacea.canonical.org") by vger.kernel.org with ESMTP
	id <S263333AbSK0Qjx>; Wed, 27 Nov 2002 11:39:53 -0500
Date: Wed, 27 Nov 2002 11:46:25 -0500
From: Jason Cook <jasonc@reinit.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Verifying Kernel source
Message-ID: <20021127164624.GI12674@panacea.canonical.org>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1038408874.12143.14.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
In-Reply-To: <1038408874.12143.14.camel@oubop4.bursar.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Richard B. Tilley  (Brad) (rtilley@vt.edu) wrote:
> Hello,
>=20
> What is the proper way to verify the kernel source before compiling?
> There have been too many trojans of late in open source and free
> software and I, for one, am getting paranoid.
>=20
> Thank you,
> Brad
>=20

For each kernel and patch on kernel.org there is a corresponding .sign
file.  This is a detached signature file that can be used to verify
that the kernel came from the kernel maintainers and that it has not
been modified since signing.  The process for verifying these
signatures is quite easy.

On a valid kernel you will see something like this:

=2E::jasonc@panacea::.~> gpg --verify linux-2.4.18.tar.gz.sign linux-2.4.18=
.tar.gz
gpg: Signature made Mon Feb 25 14:42:44 2002 EST using DSA key ID 517D0F0E
gpg: Good signature from "Linux Kernel Archives Verification Key <ftpadmin@=
kernel.org>"

On a bad signature:

=2E::jasonc@panacea::.~> gpg --verify linux-2.4.18.tar.gz.sign linux-2.4.18=
.tar.gz
gpg: Signature made Mon Feb 25 14:42:44 2002 EST using DSA key ID 517D0F0E
gpg: BAD signature from "Linux Kernel Archives Verification Key <ftpadmin@k=
ernel.org>"

--=20
Jason Cook                 |  GnuPG Fingerprint: D531 F4F4 BDBF 41D1 514D
GNU/Linux Engineering Lead |                     F930 FD03 262E 5120 BEDD
evolServ Technology        |  Home page: http://reinit.org

SMB sucks! *Really* *really* sucks=20
		--Jeremy Allison

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj3k9uAACgkQ/QMmLlEgvt03+QCcCAcRoOdBO3BACtUWE4SojYO4
bycAoIL2h8ZPnI1az4KTbhU94HS0yeuR
=rT9I
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
