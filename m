Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWHADPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWHADPx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWHADPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:15:53 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:64666 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1030418AbWHADPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:15:52 -0400
Date: Tue, 1 Aug 2006 05:14:06 +0200
To: "Siddha\, Suresh B" <suresh.b.siddha@intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp,
       asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060801031406.GL3662@kiste.smurf.noris.de>
References: <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de> <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost> <20060730020346.5d301bb5.akpm@osdl.org> <20060730201005.GA85093@muc.de> <20060730211359.GZ3662@kiste.smurf.noris.de> <1154294444.2941.50.camel@laptopd505.fenrus.org> <20060730215509.GA3662@kiste.smurf.noris.de> <20060731184701.A4592@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vDEbda84Uy/oId5W"
Content-Disposition: inline
In-Reply-To: <20060731184701.A4592@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vDEbda84Uy/oId5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Siddha, Suresh B:
> > No, it's in fact the same speed -- the BIOS just reads it wrongly.
>=20
> It sounds to me as a BIOS issue. From the boot log, it is quite clear that
> TSCs are running at different speeds(different bogomips show this).

Ah. OK, that convinces me -- I'll do a BIOS update as soon as possible.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Anyone nit-picking enough to write a letter of correction to an editor
doubtless deserves the error that provoked it.
					-- Alvin Toffler

--vDEbda84Uy/oId5W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEzsb+8+hUANcKr/kRAmZIAJ9mfChDBq9z1iFhzY1w/5zMGvrqHgCfetjM
57/WRCCnFf3bYfK0cTzz2FQ=
=OGfw
-----END PGP SIGNATURE-----

--vDEbda84Uy/oId5W--
