Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWJQW20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWJQW20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWJQW20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:28:26 -0400
Received: from home.keithp.com ([63.227.221.253]:42762 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750837AbWJQW2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:28:23 -0400
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
From: Keith Packard <keithp@keithp.com>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: keithp@keithp.com, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061017174020.GA24789@tau.solarneutrino.net>
References: <20061013194516.GB19283@tau.solarneutrino.net>
	 <1160849723.3943.41.camel@neko.keithp.com>
	 <20061017174020.GA24789@tau.solarneutrino.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ftRxzVtk79iidMsbX78s"
Date: Wed, 18 Oct 2006 06:27:42 +0800
Message-Id: <1161124062.25439.8.camel@neko.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ftRxzVtk79iidMsbX78s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-17 at 13:40 -0400, Ryan Richter wrote:

> So do I want something like
>=20
>=20
> static int do_validate_cmd(int cmd)
> {
> 	return 1;
> }
>=20
> in i915_dma.c?

that will certainly avoid any checks. Another alternative is to printk
the cmd which fails validation so we can see what needs adding here.

--=20
keith.packard@intel.com

--=-ftRxzVtk79iidMsbX78s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNVjeQp8BWwlsTdMRAghLAJ9olyrlnf5VOiF7/dR/QrQWPqYZKgCg16mY
W3e9odEIfVl+5p4yEEPL1wI=
=qGYV
-----END PGP SIGNATURE-----

--=-ftRxzVtk79iidMsbX78s--
