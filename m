Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVGHPgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVGHPgD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 11:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVGHPgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 11:36:03 -0400
Received: from outbound04.telus.net ([199.185.220.223]:51334 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id S262689AbVGHPgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 11:36:01 -0400
Subject: Re: Swap partition vs swap file
From: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <E1DqhZV-0004yW-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1DqhZV-0004yW-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Bi+gngFDTZjLX1zelqRB"
Date: Fri, 08 Jul 2005 09:35:58 -0600
Message-Id: <1120836958.16935.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Bi+gngFDTZjLX1zelqRB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On ven, 2005-07-08 at 03:22 +0200, Bernd Eckenfels wrote:
> No, it is creating files by appending just like any other file write. One
> could think about a call to create unfragmented files however since this =
is
> not always working best is to create those files young or defragment them
> before usage.

Except that this defeats one of the biggest advantages a swap file has
over a swap partition: the ability to easilly reconfigure the amount of
hd space reserved for swap.

--=20
Jeremy Nickurak <atrus@lkml.spam.rifetech.com>

--=-Bi+gngFDTZjLX1zelqRB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCzp1etjFmtbiy5uYRAotJAJ9djkn/qgiLuN4+oWM8qRRsSisBVACdEKv9
KhO46zO3o0He7md+Jgk5/Xo=
=qgWv
-----END PGP SIGNATURE-----

--=-Bi+gngFDTZjLX1zelqRB--
