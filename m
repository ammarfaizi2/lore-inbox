Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSEPA1a>; Wed, 15 May 2002 20:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316531AbSEPA13>; Wed, 15 May 2002 20:27:29 -0400
Received: from CPE00c0f0141dc1.cpe.net.cable.rogers.com ([24.42.47.5]:43919
	"EHLO jukie.net") by vger.kernel.org with ESMTP id <S316530AbSEPA12>;
	Wed, 15 May 2002 20:27:28 -0400
Date: Wed, 15 May 2002 20:27:20 -0400
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Subject: Q: x86 interrupt arrival after cli
Message-ID: <20020515202720.D15996@jukie.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quick question for the x86 gurus:

If a hardware interrupt arrives within a spin_lock_irqsave &
spin_unlock_irqrestore will the interrupt handler associated with said
interrupt be called immediately after the spinlock is released? =20

I am interested in any delays, even those less then a jiffie.

Cheers,
Bart.

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE84vzo/zRZ1SKJaI8RAhagAKDer6aYff+OKpbaC+8rtpp2tQTATQCdHJ54
3Ult9tqMO4zeSsQW+xQsZTc=
=m91A
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
