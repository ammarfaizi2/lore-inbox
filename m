Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWJZKZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWJZKZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWJZKZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:25:33 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:21404 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1422893AbWJZKZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:25:32 -0400
Date: Thu, 26 Oct 2006 12:25:30 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cm4000_cs: fix return value check
Message-ID: <20061026102530.GM6264@sunbeam.de.gnumonks.org>
References: <20061017062559.GB13100@localhost> <20061026024004.GF32048@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
Content-Disposition: inline
In-Reply-To: <20061026024004.GF32048@dominikbrodowski.de>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2006 at 10:40:04PM -0400, Dominik Brodowski wrote:

> On Tue, Oct 17, 2006 at 03:25:59PM +0900, Akinobu Mita wrote:
> > The return value of class_create() need to be checked with IS_ERR().
> > And register_chrdev() returns errno on failure.
> > This patch includes these fixes for cm4000_cs and cm4040_cs.
> >=20
> > Cc: Harald Welte <laforge@gnumonks.org>
> > Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>
>=20
> Temporarily applied to pcmica-2.6.git, thanks. Harald, do you ACK?

yes, sorry.  I've been too busy and the mail slipped through...

The patch is obviously fine. Thanks!

Signed-off-by: Harald Welte <laforge@gnumonks.org>

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
We all know Linux is great...it does infinite loops in 5 seconds. -- Linus

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFQI0aXaXGVTD0i/8RAmQSAKCodDIvFPn4oE5rHPrhu/AoRvPZbgCfYOAo
p+EMzS49/oV76ioOHdPUqpQ=
=DIoB
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--
