Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292954AbSB0VPG>; Wed, 27 Feb 2002 16:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292956AbSB0VOe>; Wed, 27 Feb 2002 16:14:34 -0500
Received: from florin.dsl.visi.com ([209.98.146.184]:60989 "HELO
	beaver.iucha.org") by vger.kernel.org with SMTP id <S292954AbSB0VOP>;
	Wed, 27 Feb 2002 16:14:15 -0500
Date: Wed, 27 Feb 2002 15:14:08 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre1-ac1
Message-ID: <20020227211408.GE456@iucha.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16fWhs-00079Y-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <E16fWhs-00079Y-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With 19-pre1-ac1 on a reiserfs partition I cannot patch a kernel. Patch
fails with "Invalid cross-device link" or "Out of disk space".

The partition has around 350 Mb free space (and has plenty of inodes
because it held linux sources + jboss + other sources that I removed).

How to reproduce:
   bunzip2 -c linux-2.4.17.tar.bz2 | tar xf -
   bunzip2 -c patch-2.4.18.bz2 | patch -p0

18-rc2-ac1 works fine on the same partition.

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fUwgNLPgdTuQ3+QRAtBzAKCc3jU+RlhFD4Iv5XitvOaUdDnUDQCfYLKL
3pssoWzB4oBjVASDUjtfsLU=
=7mvn
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
