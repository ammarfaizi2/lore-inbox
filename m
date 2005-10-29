Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVJ2OpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVJ2OpO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVJ2OpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:45:13 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:55770 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751171AbVJ2OpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:45:12 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Bug#333776: linux-2.6: vfat driver in 2.6.12 is not properly case-insensitive
Date: Sat, 29 Oct 2005 16:45:02 +0200
User-Agent: KMail/1.7.2
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Horms <horms@verge.net.au>,
       333776@bugs.debian.org
References: <20051013165529.GA2472@tennyson.dodds.net> <20051028082252.GC11045@verge.net.au> <874q71wv2b.fsf@devron.myhome.or.jp>
In-Reply-To: <874q71wv2b.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6198559.rpaI0bjree";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510291645.08872.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6198559.rpaI0bjree
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Friday 28 October 2005 16:54, OGAWA Hirofumi wrote:
> Horms <horms@verge.net.au> writes:
> > I guess it is charset2lower or charset2upper that vfat is calling,
> > which make no conversion, thus leading to the problem I outlined above.
> >
> > My question is: Is this behaviour correct, or is it a bug?
>=20
> This is known bug. For fixing this bug cleanly, we will need to much
> change the both of nls and filesystems.

Using per locale collation sequences? :-)

Do you know, how Windows handles the problem of differing collation=20
sequences on the file system? Or is the file system always dependend=20
on the locale of the Windows version, which created the file system?

I'm so happy, that Unix is not case insensitive :-)


Regards

Ingo Oeser


--nextPart6198559.rpaI0bjree
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDY4r0U56oYWuOrkARAnRcAJ0fxJ+bG0yL9Iyq5J3iSq6LyUkKaQCffpNm
fWM5k5ybabsrjKRivEW/Ong=
=kF+c
-----END PGP SIGNATURE-----

--nextPart6198559.rpaI0bjree--
