Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTEIQna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTEIQna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:43:30 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:26865 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263268AbTEIQn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:43:28 -0400
Subject: Re: #include error (userland)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: David Ford <david+powerix@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EBBDA0A.2010709@blue-labs.org>
References: <3EBBDA0A.2010709@blue-labs.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EkykMZMmzGYxovGHOesD"
Organization: Red Hat, Inc.
Message-Id: <1052499359.1529.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 09 May 2003 18:56:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EkykMZMmzGYxovGHOesD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-05-09 at 18:40, David Ford wrote:
> In file included from /usr/include/netinet/igmp.h:26,
>                  from /usr/include/libnet.h:69,
>                  from killtcp.c:6:
> /usr/include/linux/igmp.h:74:2: #error "Please fix <asm/byteorder.h>"
> make[1]: *** [killtcp.o] Error 1
>=20
>=20
> What needs to be fixed?

probably should have been #error "Dont include kernel headers in
userspace" :)

--=-EkykMZMmzGYxovGHOesD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+u92fxULwo51rQBIRAtd/AJ0TJ3OGkCdEMz6ASu/A/C4BfWhIyQCgpaY8
FyK0Woq1w+Qz8oDB6V0LiFw=
=iDke
-----END PGP SIGNATURE-----

--=-EkykMZMmzGYxovGHOesD--
