Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbTILPGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTILPGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:06:25 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:27585 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S261720AbTILPGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:06:13 -0400
Date: Fri, 12 Sep 2003 08:06:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-kernel@vger.kernel.org, plm-devel@lists.sourceforge.net
Subject: Re: PowerPC Cross-compile of 2.6 kernels
Message-ID: <20030912150611.GE13672@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.LNX.4.33.0309101629260.24847-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309101629260.24847-100000@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2003 at 04:41:05PM -0700, Judith Lebzelter wrote:
> Hello,
>=20
> In response to requests at OLS, we've added cross-compile
> capability to the PLM, and the first architecture
> implemented is PowerPC.  The powerpc code is
> generated via a cross-compiler set up using Dan
> Kegels's crosstool-0.22 on an i386 host using gcc-3.3.1,
> glibc-2.3.2 and built for the powerpc-750.
>=20
> The filter run is the compile regress developed by John
> Cherry at OSDL.  Refer to his prior mail on lkml for the
> results of this filter on ia386 and IA64.
>=20
> Look at
>     http://www.osdl.org/plm-cgi/plm?module=3Dsearch
> and look up linux-2.6.0-test5 or any later kernels for the
> results of this filter under 'PPC-Cross Compile Regress'.
>=20
> Does anyone have any input regarding requests for
> additional architectures or improvements to the
> filters?  Please cc me in any responses to lkml as I do
> not currently monitor this list, though other OSDL
> employees do.

Is there any way to seed the config so that it will override what
allmodconfig (or allyesconfig) sets?  Both of these targets by nature
pick an 'odd' machine to compile for.

--=20
Tom Rini
http://gate.crashing.org/~trini/

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/YeDjdZngf2G4WwMRAveAAJ9lQr4sDpN2DvITduM8TrnW4JIveACeNw5p
GWKd+LCTl96pLLS6mNQfG5w=
=25Y5
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
