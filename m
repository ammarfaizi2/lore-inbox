Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTFKJF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTFKJF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:05:56 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:52695 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id S264252AbTFKJFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:05:47 -0400
Date: Wed, 11 Jun 2003 11:19:11 +0200
From: Rene Engelhard <rene@rene-engelhard.de>
To: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org
Subject: RealTek NIC on alpha?
Message-ID: <20030611091910.GD801@rene-engelhard.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	debian-alpha@lists.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GnuPG-Key: $ finger rene@db.debian.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

as my "normal" PC just died and I strongly need it as a router I thought
about adding this functionality to my alpha (digital AlphaStation 500
333 Mhz).

So I got a RealTek NIC from my i386 machine and put in into my alpha
hoping that would work (it would told me this should).

After installing the NIC the boot outputs

"
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=3D256).         =
      =20
CSLIP: code copyright 1989 Regents of the University of California.        =
    =20
loop: loaded (max 8 devices)                                               =
    =20
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)                      =
    =20
eth0: Digital DC21040 Tulip rev 36 at 0x9800, 00:00:F8:23:30:83, IRQ 29.   =
    =20
8139too Fast Ethernet driver 0.9.2
"

and does not do anything after that.

This was from 2.4.21-rc7, I tried 2.2.25 before and there was a similar
problem:

"
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=3D256).         =
      =20
CSLIP: code copyright 1989 Regents of the University of California.        =
    =20
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov                     =
    =20
eth0: Digital DC21040 Tulip rev 36 at 0x9000, 00:00:F8:23:30:83, IRQ 29.   =
    =20
eth1: region already allocated at 0x9000.
"

=2E. and halts too doing nothing...

Any advice? Do I need some boot parameters?

Regards,

Ren=E9

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+5vQO+FmQsCSK63MRAl4aAJ4yBWnU911yW99mfJ70+GMLW1PD8ACfeOm8
qmrEBBawiL1NkvF+cQHnmbM=
=x3hK
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
