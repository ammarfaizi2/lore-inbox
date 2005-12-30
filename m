Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVL3HXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVL3HXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVL3HXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:23:15 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:9149 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751197AbVL3HXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:23:15 -0500
From: Chris White <chriswhite@gentoo.org>
Organization: Gentoo Linux
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: Re: Howto set kernel makefile to use particular gcc
Date: Fri, 30 Dec 2005 16:24:19 +0900
User-Agent: KMail/1.8.3
Cc: "Alessandro Suardi" <alessandro.suardi@gmail.com>,
       linux-kernel@vger.kernel.org
References: <3AEC1E10243A314391FE9C01CD65429B2239C2@mail.esn.co.in>
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B2239C2@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1945554.CYoiDRPWCW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512301624.24229.chriswhite@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1945554.CYoiDRPWCW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 30 December 2005 16:04, Mukund JB. wrote:
> Dear Alessandro,
>
> Thanks for the reply.
> What does that the make CC=3D<path_to_your_gcc_3.3> do?
> Will it set my gcc default build configuration to gcc 3.3?

Not Alessandro but,

CC sets the CC makefile variable.  When the kernel build system goes to=20
compile something, it doesn't call on gcc directly, but rather what the=20
variable CC is set to.  By setting it to your gcc 3.3 compiler, it will use=
=20
that instead.

> I mean the general procedure is make bzImage; make modules....
> How do I do these:
>
> Will I have to do it like:
> 	make bzImage cc=3D<gcc path>

make CC=3D<gcc path> bzImage

note the case sensitivity, which tends to be somewhat of a pain for new *ni=
x=20
users.

> Best Regards,
> Mukund Jampala

Chris White

--nextPart1945554.CYoiDRPWCW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDtOCoFdQwWVoAgN4RApn4AKDbe+fsJXQw3UiDvFLewsSdHzv2RACbB+l5
rTT/a/8W/oewfB6789Sq/ng=
=u9Bm
-----END PGP SIGNATURE-----

--nextPart1945554.CYoiDRPWCW--
