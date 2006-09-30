Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWI3H0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWI3H0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 03:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWI3H0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 03:26:25 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:54934 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751077AbWI3H0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 03:26:24 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA status reports update
Date: Sat, 30 Sep 2006 09:26:01 +0200
User-Agent: KMail/1.9.4
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <451CE8EC.1020203@garzik.org> <200609291200.56308.prakash@punnoor.de> <451CEF8E.2050601@garzik.org>
In-Reply-To: <451CEF8E.2050601@garzik.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1709138.FVaA91345o";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609300926.04964.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1709138.FVaA91345o
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag 29 September 2006 12:03 schrieb Jeff Garzik:
> Prakash Punnoor wrote:
> > Well, how would one debug it w/o hw docs? Or is it possible to compare
> > the patch with a working driver for another chipset?
>
> Well, it is based off of the standard ADMA[1] specification, albeit with
> modifications.  There is pdc_adma.c, which is also based off ADMA.  And
> the author (from NVIDIA) claims that the driver worked at one time, so
> maybe it is simply bit rot that broke the driver.

Well, I tried to hack the patch into 2.6.18 driver, but wasn't very=20
successful. It migt be also due to the case that I have a MCP51 chipset and=
=20
if I read the patch correctly it isn't designed  to activate ADMA on MCP51.=
=20
Do you know whether MCP51 knows ADMA? If not, how is NCQ to be activated on=
=20
MCP51? According to nvidia.com and windows user reports MCP51 does know NCQ.

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1709138.FVaA91345o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFHhwMxU2n/+9+t5gRAs9hAKDRq2VPIuJz8uAARUJToozpmEZq3wCguWwx
/UNGHleepNs7heo1HREwLq4=
=2Qnu
-----END PGP SIGNATURE-----

--nextPart1709138.FVaA91345o--
