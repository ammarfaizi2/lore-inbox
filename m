Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSKRMrz>; Mon, 18 Nov 2002 07:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSKRMrz>; Mon, 18 Nov 2002 07:47:55 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:47119 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S262418AbSKRMrw>;
	Mon, 18 Nov 2002 07:47:52 -0500
Date: Mon, 18 Nov 2002 15:54:13 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [Q] is framebuffer console code in 2.5.4x functional ?
Message-ID: <20021118125413.GA312@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi all,

I'm trying to resurrect SGI Visws support in 2.5 kernels and have two
problems: frambuffer console doesn't show anything and legacy device=20
interrupts not working. It's difficult to debug second problem without
console :(

Framebuffer driver sets needed video mode (checked with monitor's ods)
and starts display dma engine successfuly (i can even draw lines on the
screen using memset()'s). But the beautifull linux logo doesn't apear and
console doesn't show a single pixel.

Simple(silly) questions:
	- is 2.5.4x framebuffer console code really functional ?
	- if yes, where to start debugging this issue ?

Best regards.

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE92OL1Bm4rlNOo3YgRAgBGAJ9lj3ZhrNkFNPcW61NIEc8t8lBobgCff9VV
t7p+KMGyt+bUBNZ8zmMy1CU=
=fsbL
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
