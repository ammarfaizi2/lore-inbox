Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVCAWBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVCAWBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVCAWBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:01:12 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:19886 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S262079AbVCAWA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:00:59 -0500
From: Mws <mws@twisted-brains.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.11-rc5
Date: Tue, 1 Mar 2005 23:01:08 +0100
User-Agent: KMail/1.8
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <200503011236.58222.mws@twisted-brains.org> <1109713095.5679.17.camel@gaston>
In-Reply-To: <1109713095.5679.17.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1891779.Ypx40Y3eoh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503012301.14374.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1891779.Ypx40Y3eoh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 01 March 2005 22:38, Benjamin Herrenschmidt wrote:
> On Tue, 2005-03-01 at 12:36 +0100, Mws wrote:
> > hi benjamin
> >=20
> > now i had some spare time to do some investigation
> >=20
> > booting the 2.6.11-rc5 with radeonfb.default_dynclk=3D0 or with -1
> > brings up a framebuffer console. everything is fine.
> > starting xorg-x11 with Ati binary only drivers just brings up a black s=
creen
> > without a mouse cursor and freezes the hole machine. even network ect.=
=20
> > is no more reachable from outside the machine. worst thing out of that
> > a tail on the log files (on another machine) does immediately stop - al=
so no=20
> > output is written to syslog :/
> >=20
> > next scenario - test 2.6.11-rc5 with radeonfb.default_dynclock=3D0 and =
=2D1
> > starting xorg-x11 with Xorg Radeon driver.=20
> > a grey screen comes up - mouse cursor is visible and also able to move =
for
> > 5 - 8 seconds after screen display - then freezes the whole machine aga=
in.
>=20
> Ok, so it's not dynamic clocks. At this point, i have no idea what's
> going on. I don't yet have any access to PCI Express hardware. You
> should report this to X.org list where others can try to help me track
> this down.
>=20
> Ben.

it's possible to do so, but i also will try to find out whats going on.
i don't know if i will have success.

regards
marcel


--nextPart1891779.Ypx40Y3eoh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCJOYqPpA+SyJsko8RAlUjAKCYdnTHqBznbBs+t0ucuLWkmVQb9QCbBaoC
si2ENcbJ2SPQoSoX9FH57OY=
=swTR
-----END PGP SIGNATURE-----

--nextPart1891779.Ypx40Y3eoh--
