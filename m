Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbULaRtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbULaRtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbULaRsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:48:13 -0500
Received: from mout1.freenet.de ([194.97.50.132]:10731 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S262128AbULaRrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:47:43 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Simon Burke <simon.burke@gmail.com>
Subject: Re: /tmp as ramdisk
Date: Fri, 31 Dec 2004 18:47:29 +0100
User-Agent: KMail/1.7.1
References: <2d7d2dd20412310941724cc1cb@mail.gmail.com>
In-Reply-To: <2d7d2dd20412310941724cc1cb@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart21243823.ReDTQAWzbz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412311847.36867.mbuesch@freenet.de>
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart21243823.ReDTQAWzbz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Simon Burke <simon.burke@gmail.com>:
> Stupid question really.
>=20
> On my servers I'd like to mount /tmp as a ramdisk, for several
> reasons. How would i go about this with linux? Is it as simple as
> putting it in the /etc/fstab? where do i define the size of such a
> disk?

fstab

tmpfs   /tmp    tmpfs   auto,size=3D256M,uid=3D0,gid=3D0,mode=3D1777    0 0

Your question is a little bit off-topic.
Happy new Year!

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


--nextPart21243823.ReDTQAWzbz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB1ZC4FGK1OIvVOP4RAtDiAJ0RRCrJAv3VJdJdW41Pn+Icy09sIQCgsJxA
g2OQO+sukMBX5eSqTc9C/RE=
=ayVg
-----END PGP SIGNATURE-----

--nextPart21243823.ReDTQAWzbz--
