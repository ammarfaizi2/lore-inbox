Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSJJK4X>; Thu, 10 Oct 2002 06:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263369AbSJJK4X>; Thu, 10 Oct 2002 06:56:23 -0400
Received: from host213-121-110-54.in-addr.btopenworld.com ([213.121.110.54]:63650
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S263362AbSJJK4H>; Thu, 10 Oct 2002 06:56:07 -0400
Subject: Re: use of bonding in kernel 2.4.19
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: lao nightwolf <laonightwolf@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F27YI9IJsaJbqJGNzsc000001ea@hotmail.com>
References: <F27YI9IJsaJbqJGNzsc000001ea@hotmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3I5/BmTI1cIiMg7IJ+c6"
Organization: 
Message-Id: <1034247730.1490.77.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 10 Oct 2002 12:02:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3I5/BmTI1cIiMg7IJ+c6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-10-10 at 08:44, lao nightwolf wrote:
> Hello,
>=20
> I've read in some posts to this list that there's a bug in kernel 2.4.19=20
> stable regarding the use of bonding.
>=20
> I've setup bonding myself yesterday with the patch from=20
> sourceforge.net/projects/bonding and everything works as it should be
>=20
> bond0 is bringing up both my nic's eth0 and eth1.
>=20
> Is this because I use an external patch? Or can someone give me more=20
> explanation about using bonding in kernel 2.4.19. Or should I wait till=20
> 2.4.20 is released (does someone know when this will be? +/-)

The bonding problem in 2.4.19 is with the default boding code in there.
If you update to the latest bonding patch, then that should fix it.

FYI: This patch does the job for me:
http://www.scaramanga.co.uk/kernel/ECSC-2.4.19/02_bonding-fixes.diff.gz

its from 2.4.20-preX where it was fixed.

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-3I5/BmTI1cIiMg7IJ+c6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9pV4ykbV2aYZGvn0RAtGXAJsEKuS75RKr1EoNXu98wXoODTHKbgCeNIpZ
FxbzFI6OyhdJ8UZsBdgLq/E=
=P8FG
-----END PGP SIGNATURE-----

--=-3I5/BmTI1cIiMg7IJ+c6--

