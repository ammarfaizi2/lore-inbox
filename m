Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRKHTiB>; Thu, 8 Nov 2001 14:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277738AbRKHThu>; Thu, 8 Nov 2001 14:37:50 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:23715 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S277713AbRKHThl>; Thu, 8 Nov 2001 14:37:41 -0500
Date: Thu, 8 Nov 2001 20:37:18 +0100
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@online.fr>
To: John Gluck <jgluckca@home.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: Adaptec AIC7xxx support
Message-ID: <20011108203718.B505@online.fr>
Mail-Followup-To: John Gluck <jgluckca@home.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3BEAC679.A80ACBAC@home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <3BEAC679.A80ACBAC@home.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: "debian SID Gnu/Linux 2.4.14 on i586"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2001 at 12:52:57PM -0500, John Gluck wrote:
> Hi
>=20
> I configuring the kernel, there is a option "Build adapter firmware with
> Kernel build". There is no help for this. It's obvious that it build
> firmware but is it installed in the adapter automagically ???

IIRC the kernel comes with an already built firmware. This option allows
you to rebuild it from source. You certainly not need it.

>=20
> I also wonder why the reset delay is 15000 Msec. It used to be 5000
> Msec. I've usually set it to that without nasty results. I just wonder
> what the reasoning is behind such a long delay.

This is a drawback of single driver for multiple cards. Good cards
suffer to enable the driver to support bad ones.

> TIA
>=20
> John

cab.

>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@online.fr>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE76t7uj0UvHtcstB4RAubwAJ0XZ1IXQEnUrUFuuU/8i5yahFqKKACdG5Qx
CKT0mKFwqrgtcQ+LpwP4XR8=
=Gv6E
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
