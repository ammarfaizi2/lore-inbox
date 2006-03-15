Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWCOKyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWCOKyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWCOKyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:54:17 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:61854 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750824AbWCOKyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:54:17 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Date: Wed, 15 Mar 2006 11:54:11 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <1142262431.25773.25.camel@localhost.localdomain> <200603132331.33129.prakash@punnoor.de>
In-Reply-To: <200603132331.33129.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12556140.J4trOCrX8s";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603151154.15691.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12556140.J4trOCrX8s
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag M=C3=A4rz 13 2006 23:31 schrieb Prakash Punnoor:
> Hi,
>
> I tried your ide1 patch with 2.6.16-rc6 and NFORCE2 board, thus using the
> AMD driver (and sil sata driver).

[...]

> I will see how the DVD+RW drive behaves and let you know whether it makes
> troubles. :-)

Ok, I am having some troubles burning CDs/DVDs. I am using k3b as front-end=
=20
and it has troubles to detect the type of disc inserted. If you eg insert a=
=20
cd-rw the dialog changes the detected medium around (about each second):=20
cd-rom, cd-rw, etc. Same with DVD+R. It detects DVD+R, waiting a second, th=
an=20
appendable DVD+R etc. But then it thinks it is a RW so it wants to=20
blank/format/whatever it and this breaks, ie. I can't start the burning. It=
=20
worked fine with a DVD+RW though. And ignoring the message and blanking in=
=20
menu, I could also write a cd-rw.


I am not sure what is causing the problem. Could dbus/hal be also trouble=20
makers? I don't know whether k3b is making something stupid, as well. Last=
=20
time I tried I had no problem with the ide driver though. So I don't know=20
whether ATAPI support in libata still needs polishing or whether Alan's PAT=
A=20
patch is missing something or whatever...


What infos should I provide to make diagnosis easier?
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart12556140.J4trOCrX8s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEF/JXxU2n/+9+t5gRAqbsAJ923SsWGSRU5jDnKvYeJg6ZSZuAlQCgyViK
aI74qx5qY6MZDwxHuSRQ8rM=
=UFOw
-----END PGP SIGNATURE-----

--nextPart12556140.J4trOCrX8s--
