Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965282AbWIRQRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbWIRQRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWIRQRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:17:55 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:5789 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S965282AbWIRQRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:17:54 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: "Gerd v. Egidy" <lists@egidy.de>
Subject: Re: APIC on Asus M2N SLI Deluxe
Date: Mon, 18 Sep 2006 18:17:39 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Thomas Richter <thor@mail.math.tu-berlin.de>
References: <200609141017.k8EAHdL9017691@mersenne.math.TU-Berlin.DE> <200609172203.18666.prakash@punnoor.de> <200609181804.36428.lists@egidy.de>
In-Reply-To: <200609181804.36428.lists@egidy.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1446206.H9qPsUiB1Q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609181817.39498.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1446206.H9qPsUiB1Q
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 18 September 2006 18:04 schrieb Gerd v. Egidy:
> > > > recently, I tried to upgrade the bios of the ASUS M2N SLI Deluxe
> > > > board from release 0202 to 0307. With the 0307 bios, I get a kernel
> > > > panic that the APIC cannot be found. Concerning this, I've two
> > > > explanations, could possibly confirm someone here this:
> > >
> > > I can confim this problem.
> >
> > Does it boot with no_timer_check boot parameter?
>
> no, same bug.
>
> Booting with apic=3Ddebug as suggested in the error message doesn't reveal
> any additional details. Maybe I have to compile with some special debug
> options?

I don't think so. I once had the same problem with my board. On 2.6.16.x I =
got=20
same message. 2.6.18-rcx booted further, but hanged. Above parameter helped=
=20
though with 2.6.18-rc. As I haven't tested 2.6.17 nor 2.6.16 with obve=20
parameter, I could only guess. The real fix for me though was to disable th=
e=20
nvidia quirk. Then my system boots and runs fine with 2.6.18-rc kernel w/o=
=20
any additional parameter. You may want to look into:

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115545986619977&w=3D2

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1446206.H9qPsUiB1Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFDsajxU2n/+9+t5gRAiREAKCX4QZ4tNXb68dCse6iLZVbS30dggCePhi0
47lPQP7ZTiWIoTLpHCVjZVs=
=zDTx
-----END PGP SIGNATURE-----

--nextPart1446206.H9qPsUiB1Q--
