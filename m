Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWI1UUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWI1UUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWI1UUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:20:40 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:22472 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161177AbWI1UUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:20:39 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18 hangs during boot on ASUS M2NPV-VM motherboard
Date: Thu, 28 Sep 2006 22:20:20 +0200
User-Agent: KMail/1.9.4
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org,
       "Andy Currid" <ACurrid@nvidia.com>
References: <451BFDC8.6030308@perkel.com> <20060928131427.bc3d0ed4.akpm@osdl.org>
In-Reply-To: <20060928131427.bc3d0ed4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5004007.idy3cveRYd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609282220.20790.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5004007.idy3cveRYd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag 28 September 2006 22:14 schrieb Andrew Morton:

> > I compiled 2.6.18 and setting acpi_skip_timer_override to 0 instead of 1
> > makes the problem go away. Obviously the logic needs to e a little more
> > complex than is but this shouldn't be that hard to resolve.
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D6975
>
> I think the kernel _should_ be enabling acpi_skip_timer_override by itsel=
f,
> but isn't doing that for some reason.

Other way round. It should only enable it for broken chipsets. But it hasn'=
t=20
been defined what _are_ the broken chipsets.... currently it is enabled for=
=20
all chipsets.

>
> Perhaps Andy can help.  He may not even be aware of this problem...

Na, he just choses not to say anything.

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115675009906807&w=3D2

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart5004007.idy3cveRYd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFHC6ExU2n/+9+t5gRAnLnAKDCvetITC3cvsXIUJ0sfKS/0qXqSQCfbEAG
qbEtIMzEC1WqVg0BG1RCYH8=
=0EQP
-----END PGP SIGNATURE-----

--nextPart5004007.idy3cveRYd--
