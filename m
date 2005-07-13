Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVGML5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVGML5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVGML5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:57:04 -0400
Received: from nijmegen.renzel.net ([195.243.213.130]:15821 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S262788AbVGML47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 07:56:59 -0400
From: Mws <mws@twisted-brains.org>
To: Daniel Drake <dsd@gentoo.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SysKonnect ethernet support for Asus A8VE Deluxe Motherboard?
User-Agent: KMail/1.8.1
References: <42D3FDF5.4090501@travellingkiwi.com> <42D50033.9040009@gentoo.org>
In-Reply-To: <42D50033.9040009@gentoo.org>
MIME-Version: 1.0
Date: Wed, 13 Jul 2005 13:57:11 +0200
Content-Type: multipart/signed;
  boundary="nextPart1227648.Nt4HjROqG0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507131357.16969.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1227648.Nt4HjROqG0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 13 July 2005 13:51, you wrote:
> Hamish Marson wrote:
> > I just installed Gentoo distribution on a new PC for a friend who's
> > new to Linux, and discovered that although SysKonnect kindly provide
> > full source code drivers for their various products on their website,
> > that even the latest released kernel sources (i.e. 2.6.12) still don't
> > support the device on this motherboard (Along with a whole host of
> > other PCI id's that appear in the syskonnect sources).
>=20
> Gentoo 2.6.12 kernels provide the skge driver which supports this hardwar=
e (I
> believe). skge will be included in mainline 2.6.13.
>=20
> > I've logged a bug on gentoo.org about it, but thought I'd ask, if
> > there's any reason that the syskonnect (sk98lin) drivers are so back
> > leve in the kernel sources when syskonnect seem to have published the
> > drivers for so many more of their devices in source...
>=20
> The driver updates that syskonnect released are ugly and have been reject=
ed by
> the network driver maintainers. skge was written as a response to this.
>=20
> The very latest sk98lin updates add support for the new Yukon-II PCI-expr=
ess
> adapters. These are not supported by skge -- the Yukon-II is very differe=
nt
> and will eventually be supported by a separate driver. The techniques whi=
ch
> sk98lin uses to support two vastly different network chipsets (yukon/yuko=
n-II)
> in the same driver are generally not accepted in the kernel.

but they have one advantage for now. they do work.

i am using them for about 9 months now including upgrades.

regards
marcel

>=20
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--nextPart1227648.Nt4HjROqG0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1QGcPpA+SyJsko8RArU2AKCDb92uHlMPo789rNcUCepRQcPY+ACdHlUF
XCJV9RL3EEvv1zJwR5+log8=
=RNif
-----END PGP SIGNATURE-----

--nextPart1227648.Nt4HjROqG0--
