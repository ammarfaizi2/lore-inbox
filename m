Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbSK2IpE>; Fri, 29 Nov 2002 03:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266982AbSK2IpE>; Fri, 29 Nov 2002 03:45:04 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:58636 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S266971AbSK2IpD>;
	Fri, 29 Nov 2002 03:45:03 -0500
Date: Fri, 29 Nov 2002 11:51:34 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] pci_siig* interdependence
Message-ID: <20021129085134.GA2257@pazke.ipt>
Mail-Followup-To: Zwane Mwaikambo <zwane@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0211280336580.14410-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0211280336580.14410-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=A7=D1=82=D0=B2, =D0=9D=D0=BE=D1=8F 28, 2002 at 03:39:08 -0500, Zwane=
 Mwaikambo wrote:

> This patch is to fix a compilation problem (functions are shared with
> parport_serial) as well as fix a potential oops (parport_serial as module
> would try and reference the freed memory)

The problem you are seeing caused by semiapplied patch moving SIIG combo
cards support from 8250_pci.c to parport_serial.c
Parport patch already applied, while serial one still isn't.

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE95yqWBm4rlNOo3YgRAmjpAJ99FmecozmxGRwjji30h0jyAS/gBwCggu+S
hB9ZXR9dXIlA+Y0PiKDuhko=
=zSYs
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
