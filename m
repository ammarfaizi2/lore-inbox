Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTFOBrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 21:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTFOBrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 21:47:10 -0400
Received: from iucha.net ([209.98.146.184]:7530 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S261797AbTFOBrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 21:47:05 -0400
Date: Sat, 14 Jun 2003 21:00:55 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71
Message-ID: <20030615020055.GB25303@iucha.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030615014221.GA25303@iucha.net> <Pine.LNX.4.44.0306141849290.20728-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VE1+SxTILTm8udN6"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306141849290.20728-100000@home.transmeta.com>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VE1+SxTILTm8udN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2003 at 06:58:26PM -0700, Linus Torvalds wrote:
> > SysReq-T unfroze the box. I logged out from Gnome, went into a console
> > and attempted to login. In the middle of typing the id, the nfs/rpc=20
> > oops came, then the big oops and the box locked up.
>=20
> Ok, that does look like the list poisoning. The poisoning uses 0x00100100
> as the poison value, and that's the address that oopsed for you:
[snip]=20
> Florin, does it work for you if you remove the poisoning in=20
> <linux/list.h>? (Just search for "POISON" and remove those lines).
>=20
> Trond, any ideas?

I am compiling now 2.5.71 with Tron's patch
(http://bugme.osdl.org/attachment.cgi?id=3D414&action=3Dview). If that
does not fix it I will try without the poison.

florin
--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--VE1+SxTILTm8udN6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+69NXNLPgdTuQ3+QRAt6EAKCNt8OJJvIvO+CIfqAA3I8l4OI4YQCfa3uW
nEatLlP/Z0FCgIawxG8Acuo=
=Ayic
-----END PGP SIGNATURE-----

--VE1+SxTILTm8udN6--
