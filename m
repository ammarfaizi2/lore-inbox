Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbSJFR0J>; Sun, 6 Oct 2002 13:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSJFRZU>; Sun, 6 Oct 2002 13:25:20 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:7926 "EHLO
	mg.homelinux.net") by vger.kernel.org with ESMTP id <S262151AbSJFRVt>;
	Sun, 6 Oct 2002 13:21:49 -0400
Date: Sun, 6 Oct 2002 19:26:59 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: Ext3 documentation
Message-ID: <20021006172659.GA21270@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021002085713.GA23086@darwin.crans.org> <Pine.LNX.4.33L2.0210020915400.14122-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0210020915400.14122-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-Message-Flag: If you do not see this message correctly, stop using Outlook.
X-GPG-Fingerprint: 8121 AD32 F00A 8094 748A  6CD0 9157 445D E7A6 D78F
X-GPG-Key: http://ice.dammit.lt/~mgedmin/mg-pgp-key.txt
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2002 at 09:17:00AM -0700, Randy.Dunlap wrote:
> On Wed, 2 Oct 2002, Vincent Hanquez wrote:
>=20
> | Here a (small) documentation for ext3 filesystem.
> | it seem now correct/accurate. report me any problem/bugs
> |
> | It can be merge in 2.4/2.5 kernel I think. feedback appreciated.
>=20
> Here are a few typo corrections for you.  My correction lines
> begin with '#'.

I found a couple more.

> jounal=3Dupdate		Update the ext3 file system's journal to the
> 			current format.

'jounal'?

> bsddf 		(*)	Make 'df' act like BSD.
> minixdf			Make 'df' act like Minix.

A couple of additional lines for clueless users (like me) would be
nice.

> errors=3Dremount-ro(*)	Remount the filesystem read-only on an error.
> errors=3Dcontinue		Keep going on a filesystem error.
> errors=3Dpanic		Panic and halt the machine if an error occurs.

mount(8) claims the default is set in the superblock.  (It certainly
wasn't remount-ro when I mountend an ext3 fs on 2.4.18.)


Marius Gedminas
--=20
The IQ of the group is the lowest IQ of a member of
the group divided by the number of people in the group.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9oHJjkVdEXeem148RAs4GAJ9SWu6cOYrbOQIEM8R4PscsBNpDHACglAVW
DJ3O4Qnk4vxDuJxAUaMQybc=
=vhMi
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
