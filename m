Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265953AbUFTVpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUFTVpx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUFTVpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:45:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2702 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265953AbUFTVpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:45:50 -0400
Subject: Re: [PATCH] FAT: don't use "utf8" charset and NLS_DEFAULT
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: hirofumi@mail.parknet.co.jp
In-Reply-To: <200406201807.i5KI7qNT004770@hera.kernel.org>
References: <200406201807.i5KI7qNT004770@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Dr3yN3f8J9kH6bQqHGFV"
Organization: Red Hat UK
Message-Id: <1087767944.2805.20.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 20 Jun 2004 23:45:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Dr3yN3f8J9kH6bQqHGFV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-20 at 18:59, Linux Kernel Mailing List wrote:
> ChangeSet 1.1770, 2004/06/20 09:59:33-07:00, hirofumi@mail.parknet.co.jp
>=20
> 	[PATCH] FAT: don't use "utf8" charset and NLS_DEFAULT
> =09
> 	Recently, some distributors have set "utf8" to NLS_DEFAULT, therefore,
> 	FAT uses the "iocharset=3Dutf8" as default.  But, since "iocharset=3Dutf=
8"
> 	doesn't provide the function (lower <-> upper conversion) which FAT
> 	needs, so FAT can't provide suitable behavior.

does Microsoft store UTF8 in vfat ?

--=-Dr3yN3f8J9kH6bQqHGFV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1gWHxULwo51rQBIRAu20AJ9c32pTjzIeYISI8h/0il0a2S7XpwCeLXay
M6s/mqSS5Sg9CHWgI6l8FEQ=
=ufRy
-----END PGP SIGNATURE-----

--=-Dr3yN3f8J9kH6bQqHGFV--

