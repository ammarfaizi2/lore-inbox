Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWHPP6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWHPP6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHPP6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:58:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:50921 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932091AbWHPP6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:58:44 -0400
X-Authenticated: #815327
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: reiserfs on-demand bitmap loading, what is the state?
Date: Wed, 16 Aug 2006 17:58:38 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1780032.a69gMufrdF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608161758.41935.MalteSch@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1780032.a69gMufrdF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,
I set up a new raid system with about 500gib space and put reiserfs on it. =
It=20
takes some seconds to mount so I patched my 2.6.17.8-tree with those=20
reiserfs-patches from -mm. Mount time was reduced significantly (less than =
a=20
second).
What I found out about these patches is that they can introduce instability=
,=20
but that seemed a bit vague to me.
Up to now I didn't encounter any problems, so are there (theoretical?)=20
problems with the on-demand code? Could that stuff go into mainline?
Maybe there are tests I could run, the data on that box is easily=20
recoverable ...

Regards
=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--nextPart1780032.a69gMufrdF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE40Cx4q3E2oMjYtURAuRVAKDTkbMWXlhH98FhdHtIFqlpo3jLjgCfbsY1
VlaM1vTHdzB5pWSEyf8WBEA=
=ndU+
-----END PGP SIGNATURE-----

--nextPart1780032.a69gMufrdF--
