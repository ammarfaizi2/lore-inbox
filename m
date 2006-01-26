Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWAZHf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWAZHf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 02:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWAZHf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 02:35:29 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:30409 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750914AbWAZHf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 02:35:28 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AMD64, 4GB, mttr questions
Date: Thu, 26 Jan 2006 08:37:41 +0100
User-Agent: KMail/1.9
Cc: linux-kernel <linux-kernel@vger.kernel.org>, thockin@hockin.org
References: <5ywpz-49F-11@gated-at.bofh.it> <43D6C2BD.50301@shaw.ca>
In-Reply-To: <43D6C2BD.50301@shaw.ca>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6859410.KS7ahp6ngd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601260837.44595.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6859410.KS7ahp6ngd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch Januar 25 2006 01:13 schrieb Robert Hancock:
> Prakash Punnoor wrote:
> > I have a machine with 4GB RAM, an Athlon64 X2 and following mttr entrie=
s:
> >
> > reg00: base=3D0x00000000 (   0MB), size=3D4096MB: write-back, count=3D1
> > reg01: base=3D0x100000000 (4096MB), size=3D2048MB: write-back, count=3D1
> > reg02: base=3D0x80000000 (2048MB), size=3D2048MB: uncachable, count=3D1
> >
> > First of all, why is there an uncachable region? Is it the upper half of
> > memory? Or is this just a hole and the remaining 2GB are seated at
> > 0x100000000 ?
>
> Your e820 memory map shows the first 2GB of RAM is at 0-2GB and the
> remaining 2GB is at 4-6GB, so yes there is a hole. This doesn't explain
> why all of 0-4GB is set as write-back and then the top half of it is
> also set as uncacheable. This will presumably have been set up by the
> BIOS though, I don't think the kernel does this.

OK thanks to both of you for clearing this up. :-)

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart6859410.KS7ahp6ngd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD2HxIxU2n/+9+t5gRAlWOAKCfHz5CkM9BTL5h2nvJu53ADLebLACgqJR6
WXilprX+zc0dOBqU5l74mEo=
=mAM2
-----END PGP SIGNATURE-----

--nextPart6859410.KS7ahp6ngd--
