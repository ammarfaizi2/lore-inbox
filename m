Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTJXPLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 11:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTJXPLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 11:11:18 -0400
Received: from relay.dera.gov.uk ([192.5.29.49]:32956 "HELO relay.dstl.gov.uk")
	by vger.kernel.org with SMTP id S262280AbTJXPLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 11:11:17 -0400
Subject: Re: Linux 2.4.23-pre8
From: Tony Gale <gale@syntax.dstl.gov.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
In-Reply-To: <Pine.LNX.4.44.0310222116270.1364-100000@dstl.gov.uk>
References: <Pine.LNX.4.44.0310222116270.1364-100000@dstl.gov.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NgYISSh2IWVnckBSAfte"
Message-Id: <1067008275.6437.6.camel@syntax.dstl.gov.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 24 Oct 2003 16:11:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NgYISSh2IWVnckBSAfte
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-10-23 at 00:24, Marcelo Tosatti wrote:
> Hi,=20
>=20
> Here goes -pre8... It contains a quite big amount of ACPI fixes,
> networking changes, network driver changes, few IDE fixes, SPARC merge, S=
H
> merge, tmpfs fixes, NFS fixes, important VM typo fix, amongst others.
>=20

As reported earlier, this still fails to boot on my P-II (to recap,
pre6, pre7 and pre8 fail to boot - no messages after Uncompressing
kernel).

Reverting the ACPI changes in pre6 fixes it - note that I have ACPI
turned off in the config, so the CONFIG_ACPI_BOOT thing is causing the
problem, and it seems to be impossible to compile a kernel without it.

Cheers,
-tony


--=-NgYISSh2IWVnckBSAfte
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iQCVAwUAP5lBEh/0GZs/Z0FlAQIP6AQAwOwqzzAtXIASbRTCz1Omk3UM1oSn9jM+
iW67KfwGu1sdYc1RmQVhjLK7tvLxI6i6uim2iMxWnSnUhVUGGLNSOSMd+vp+BbGR
Ibql1Z4hV3xtIkvlDcMGjmaYfvlMUcG8aqhgQqEVoNwTWoFV/ate819VHTxe25jU
qnN/PwFrOl0=
=+HcM
-----END PGP SIGNATURE-----

--=-NgYISSh2IWVnckBSAfte--

