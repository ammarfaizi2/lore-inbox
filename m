Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRJaXkd>; Wed, 31 Oct 2001 18:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275852AbRJaXkX>; Wed, 31 Oct 2001 18:40:23 -0500
Received: from adsl-dynamic1-27.milwaukee.wi.ameritech.net ([64.108.132.27]:14581
	"HELO alphaflight.d6.dnsalias.org") by vger.kernel.org with SMTP
	id <S275778AbRJaXkG>; Wed, 31 Oct 2001 18:40:06 -0500
Date: Wed, 31 Oct 2001 17:40:30 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: cdrecord from ext3
Message-ID: <20011031174030.E6992@0xd6.org>
In-Reply-To: <20011031001846.A1840@werewolf.able.es> <3BDF576F.3A797933@zip.com.au> <20011031155934.A18608@werewolf.able.es> <9rpdp8$601$1@cesium.transmeta.com> <20011031104000.D1767@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <20011031104000.D1767@thune.mrc-home.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mike Castle <dalgoda@ix.netcom.com> on Wed, Oct 31, 2001:

> On Wed, Oct 31, 2001 at 09:52:40AM -0800, H. Peter Anvin wrote:
> > By author:    "J . A . Magallon" <jamagallon@able.es>
> > > Did you noticed that the ext3 was at 20MHz, and ext2 was at 40MHz ? I
> > > will reformat the 20MHz drive and make 2 slices, one ext2 and one ext3
> > > to be sure not to compare apples and oranges...
> >=20
> > Doesn't work.  Low block numbers (outer edge of the disk) is
> > invariably faster than high block numbers (inner edge of the disk) on
> > all drives that are even close to recent.
>=20
> So unmount and remount as ext2?
>=20

ext2 =3D=3D ext3

ext3 may as well be called ext2 2.5 if you want to think about it in the
non-marketing sense.

What you'd want to do is do the first test on a vanilla ext2 partition, and
then perform the second test on that same partition, mounted as ext3.  That
way you aren't being slowed down by physical properties of the drive.

M. R.

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE74IvuaK6pP/GNw0URAqk7AJ0YEbmDh1ClxmG9axAdj+iNi1MCjQCg0aG2
acHiemXsncHdqujwRHyGOUo=
=vcqh
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
