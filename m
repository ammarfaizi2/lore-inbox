Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTDOSJN (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTDOSJN 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:09:13 -0400
Received: from iucha.net ([209.98.146.184]:12924 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S262894AbTDOSJG 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 14:09:06 -0400
Date: Tue, 15 Apr 2003 13:20:57 -0500
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030415182057.GC29143@iucha.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Dave Jones <davej@codemonkey.org.uk>
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <20030415164435.GA6389@rivenstone.net>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2003 at 12:44:40PM -0400, Joseph Fannin wrote:
> On Tue, Apr 15, 2003 at 03:06:37PM +0200, Alessandro Suardi wrote:
> <snip>
> > I surely hit bug 543 in 2.5.65 IIRC, and guess what...
> >  ATI Radeon 7500 Mobile - XFree 4.2.1
> >=20
> > According to other emails on lkml, it appears that DRM and/or AGP
> >  new kernel code might be at fault. I don't actually remember
> >  seeing non-Radeon cards being hit by such problems though...
>=20
>     I've seen this problem too many times, but haven't tried to track
> it down.  The video is ATI Rage 128 Pro.
>=20
>     A common bit seems to be ATI cards, judging from this thread.  I'm
> also using the aty128fb framebuffer driver.  My motherboard is Aladdin V
> based and so uses the ali-agp module.

I think it has to do with the interaction between XFree86 4.3.0 and
the AGP code.

I have wdm as my display manager. I am able to login, but when logging
out the system dies. These are the last two messages printed on the
serial console:
   agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
   agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
and then, hard freeze.

These lines do not appear when using XFree86 4.2.1 .

I have a Radeon 8500 and AGP 4x is enabled in BIOS. The motherboard is
ECS K7S5A (SIS 735 chipset).

Dave, if you have any patch to test send it over!

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nE2JNLPgdTuQ3+QRArAOAJ43qtf9yA+DXlwU1k71QgGdAO1sugCfWAYl
7RQz/Vw4S97ugOw+dAc27ew=
=36Ye
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
