Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265891AbUGNLVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbUGNLVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 07:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267219AbUGNLVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 07:21:23 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:7100 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S265891AbUGNLVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 07:21:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA disk device naming ?
Date: Wed, 14 Jul 2004 13:20:28 +0200
User-Agent: KMail/1.6.2
Cc: "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0407130415430.15806-100000@hubble.stokkie.net> <40F35140.6020509@pobox.com>
In-Reply-To: <40F35140.6020509@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_AcR9ASk2mSEWlBK";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407141320.32608.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_AcR9ASk2mSEWlBK
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dienstag, 13. Juli 2004 05:04, Jeff Garzik wrote:
> Whoever builds your kernels changed around the kernel configuration on yo=
u.
>=20
> SATA "disk naming" (what driver you use) did not change from 2.6.3 to 2.6=
=2E7.
>=20
The thing that changed is the new BLK_DEV_IDE_SATA option that defaults
to 'n', while before it was enabled implicitly.

I was bitten by this as well. Unfortunately I have an md RAID-0 volume
which I can not start after hde/hdg become sda/sdb, so I'll probably
have to keep using the old IDE driver indefinitely.

	Arnd <><

--Boundary-02=_AcR9ASk2mSEWlBK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA9RcA5t5GS2LDRf4RAhyrAJ933+28qlk0FhdUDMvSkxaI7inF6QCfbq0V
gpDqgDzqYkQNjh0sqKMKq8w=
=Gn60
-----END PGP SIGNATURE-----

--Boundary-02=_AcR9ASk2mSEWlBK--
