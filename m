Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVCAOjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVCAOjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVCAOjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:39:05 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:15316 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261926AbVCAOi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:38:58 -0500
From: Mws <mws@twisted-brains.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.11-rc5
Date: Tue, 1 Mar 2005 15:39:13 +0100
User-Agent: KMail/1.8
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <200503011236.58222.mws@twisted-brains.org> <42247DD6.1060906@aitel.hist.no>
In-Reply-To: <42247DD6.1060906@aitel.hist.no>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3956781.8miX9v8CYb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503011539.18223.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3956781.8miX9v8CYb
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 01 March 2005 15:36, Helge Hafting wrote:
> Mws wrote:
>=20
> >hi benjamin
> >
> >now i had some spare time to do some investigation
> >
> >booting the 2.6.11-rc5 with radeonfb.default_dynclk=3D0 or with -1
> >brings up a framebuffer console. everything is fine.
> >starting xorg-x11 with Ati binary only drivers just brings up a black sc=
reen
> >without a mouse cursor and freezes the hole machine. even network ect.=20
> >is no more reachable from outside the machine. worst thing out of that
> >a tail on the log files (on another machine) does immediately stop - als=
o no=20
> >output is written to syslog :/
> >
> >next scenario - test 2.6.11-rc5 with radeonfb.default_dynclock=3D0 and -1
> >starting xorg-x11 with Xorg Radeon driver.=20
> >a grey screen comes up - mouse cursor is visible and also able to move f=
or
> >5 - 8 seconds after screen display - then freezes the whole machine agai=
n.
> > =20
> >
> Did you try without dri? (Comment out dri in the X config file)
> I use a radeon 7000 VE at work, where X will hang after a few
> seconds if dri is enabled in X.  Disable dri, and it is
> rock solid. xfree or x.org makes no difference here.
>=20
> Helge Hafting

hi,=20

i had dri disabled already :/

regards
marcel

--nextPart3956781.8miX9v8CYb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCJH6WPpA+SyJsko8RAt+ZAJ0ZDOB8CxO8mU27yUNJ3jbd09Rr3gCg7PPd
AA26z4W3EPEM6+KzQ98rZLA=
=mLE0
-----END PGP SIGNATURE-----

--nextPart3956781.8miX9v8CYb--
