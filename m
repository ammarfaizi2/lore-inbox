Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUIEPwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUIEPwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 11:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUIEPwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 11:52:15 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:9614 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266820AbUIEPwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 11:52:13 -0400
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sun, 5 Sep 2004 17:48:11 +0200
To: Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>, Dan Kegel <dank@kegel.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Getting kernel.org kernel to build for m68k?
Message-ID: <20040905154811.GF2605@kiste>
References: <41355F88.2080801@kegel.com> <Pine.GSO.4.58.0409011029390.15681@waterleaf.sonytel.be> <Pine.LNX.4.58.0409051224020.30282@anakin> <20040905120325.A29363@infradead.org> <20040905131948.GE2605@kiste> <20040905144904.A30552@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Content-Disposition: inline
In-Reply-To: <20040905144904.A30552@infradead.org>
User-Agent: Mutt/1.5.6+20040722i
X-Smurf-Spam-Score: -3.1 (---)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Christoph Hellwig:
> > Why not?
>=20
> Because we don't want gazillions of special cases in common code.  We
> already added support for allocating the thread_info and task_struct
> as a single object because ia64 needed it, there's no reason to stack
> another hack ontop for m68k.

OK -- I'll investigate changing that. It'll be a few days until I can get
to it however :-/  so if anybody beats me to it, fine.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBOzU78+hUANcKr/kRAr1tAJ4s9f5hoP/pClvmtakyl8D2OOx7cACgnDLu
e0MPlTY4YC0HXHjQUjGCX+E=
=dMVZ
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
