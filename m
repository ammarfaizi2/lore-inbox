Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTEEESb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTEEESb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:18:31 -0400
Received: from iucha.net ([209.98.146.184]:61034 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S261895AbTEEES3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:18:29 -0400
Date: Sun, 4 May 2003 23:30:58 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69
Message-ID: <20030505043058.GG1059@iucha.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6BvahUXLYAruDZOj"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6BvahUXLYAruDZOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2003 at 05:48:53PM -0700, Linus Torvalds wrote:
>  I finally found the reason for why some of my machines had trouble with
> restarting the X server, and it turns out that it's been around since very
> early February. I bet others must have seen it too, with random crashes on
> X server restart when the server used AGP (which means that it mainly hit
> either hw-accelerated 3D setups or the intel integrated graphics which use
> a UMA model with AGP as the backing store).
>=20
> That's a big relief for me, as it was the major thing I personally worrie=
d=20
> about for 2.6.x.=20

Unfortunately it is not the same reason that locks up my machine ;(

On SIS 735 motherboard, with agpgart, sis-agp and radeon loaded, I get
this on the serial console before the machine freezes:
   agpgart: Found an AGP 2.0 compliant device.
   agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
   agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
Without these modules loaded, the machine is stable.

I am using XFree86 4.3.0 with a Radeon 8500.

Please let me know if you need more details or you have a patch for
testing.

Cheers,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--6BvahUXLYAruDZOj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tekCNLPgdTuQ3+QRAosfAJ4nUKLjSL/Sb1WAOMl/I/Rd47jurwCfZ0yW
2qHCsJ4LGhsHskfDbOUXcEM=
=A4FR
-----END PGP SIGNATURE-----

--6BvahUXLYAruDZOj--
