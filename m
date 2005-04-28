Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVD1HBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVD1HBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVD1HBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:01:43 -0400
Received: from irulan.endorphin.org ([80.68.90.107]:35601 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261800AbVD1HAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:00:36 -0400
Subject: Re: [RFC][PATCH 0/4] AES assembler implementation for x86_64
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, davem@davemloft.net, ak@suse.de
In-Reply-To: <4262B6D4.30805@domdv.de>
References: <4262B6D4.30805@domdv.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v5Zkt9Sjr9paGEoXwKMf"
Date: Thu, 28 Apr 2005 09:00:28 +0200
Message-Id: <1114671628.13134.4.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v5Zkt9Sjr9paGEoXwKMf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-04-17 at 21:19 +0200, Andreas Steinmetz wrote:
> Implementation:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The encrypt/decrypt code is based on an x86 implementation I did a while
> ago which I never published. This unpublished implementation does
> include an assembler based key schedule and precomputed tables.=20

Nice work! Especially because I'm planing to get one of these x86_64
babies soon ;)

> If anybody has a better assembler solution for x86_64 I'll be pleased to
> have my code replaced with the better solution.

Jari Ruusu has a x86_64 implementation in his loop-AES package. It is
also based on Gladman's code.
http://loop-aes.sourceforge.net/loop-AES-latest.tar.bz2 aes-amd64.S

> Microbenchmark:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The microbenchmark was done in userspace with similar compile flags as
> used during kernel compile.

You might want to compare it to the one above.

Regards,
--=20
Fruhwirth Clemens - http://clemens.endorphin.org=20
for robots: sp4mtrap@endorphin.org

--=-v5Zkt9Sjr9paGEoXwKMf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCcIoMbjN8iSMYtrsRAi1jAJ9qBOzxd/WxUee4r8G/bfKSL63m2QCfflwc
Uq9JCTJC+27J6T7emLNyvic=
=J786
-----END PGP SIGNATURE-----

--=-v5Zkt9Sjr9paGEoXwKMf--
