Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUEFQDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUEFQDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUEFQDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:03:34 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:42670 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S262648AbUEFQDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:03:31 -0400
Date: Thu, 6 May 2004 18:03:14 +0200
From: Malte =?ISO-8859-1?B?U2NocvZkZXI=?= <Malte.Schroeder@hanse.net>
To: Valdis.Kletnieks@vt.edu
Cc: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>,
       Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-Id: <20040506180314.3cea176b@highlander.Home.LAN>
In-Reply-To: <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<200405051312.30626.dominik.karall@gmx.net>
	<200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
	<20040505215136.GA8070@wohnheim.fh-wedel.de>
	<200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
Reply-To: MalteSch@gmx.de
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__6_May_2004_18_03_14_+0200_4vWccTDiT7pN81xw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__6_May_2004_18_03_14_+0200_4vWccTDiT7pN81xw
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 06 May 2004 11:18:10 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Wed, 05 May 2004 23:51:36 +0200, =3D?iso-8859-1?Q?J=3DF6rn?=3D Engel s=
aid:
>=20
> > I disagree.  -mm is the testing ground for -linus.  If this patch
> > would only break the nvidia module, I couldn't care less.
>=20
> OK.. I need to clarify - I'm OK on the patch being *in -mm* precisely *be=
cause*
> it's a testing ground.  Anybody who's running a -mm kernel should have the
> technical savvy to deal with the issue by reverting the one patch in ques=
tion,
> and to recover if it eats their file system (Yes, I'm running 2.6.6-rc3-m=
m2 and
> the NVidia driver as I type.  No, making it work wasn't a problem.  Yes, =
I spin
> everything needed to rebuild out to CD/RW at least once a week, just beca=
use it
> *is* a -mm kernel. ;)
>=20
> It's a Good Idea to do this in -mm, to flush out all the binary modules t=
hat
> are known to have issues with this (have we identified anybody other than=
 NVidia
> that actually *has* a problem)?
I use 2.6.6-rc3  w/ 4k-stack enabled (-mm is a bit too experimental for my =
taste ;) ), ATIs binary-module is working w/o problems.
but IIRC I had to disable REGPARMS.

>=20
> It's probably a Bad Idea to push this to Linus before the vendors that ha=
ve
> significant market-impact issues (again - anybody other than NVidia here?)
> have gotten their stuff cleaned up...
>=20
>=20


--=20
---------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
---------------------------------------


--Signature=_Thu__6_May_2004_18_03_14_+0200_4vWccTDiT7pN81xw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAmmHG4q3E2oMjYtURAgyRAKDBrnBvX5KRUSNtzZQz44Ab778wdwCfci/2
id/PWfaaCq03u87vvNq3TXY=
=eFMS
-----END PGP SIGNATURE-----

--Signature=_Thu__6_May_2004_18_03_14_+0200_4vWccTDiT7pN81xw--
