Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266469AbUF3FEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbUF3FEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 01:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUF3FE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 01:04:29 -0400
Received: from mail.donpac.ru ([80.254.111.2]:18847 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266469AbUF3FE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 01:04:27 -0400
Date: Wed, 30 Jun 2004 09:04:23 +0400
From: Andrey Panin <pazke@donpac.ru>
To: "Leonardo G. Di Lella" <leonardo@dilella.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sony Vaio dmi_scan.c
Message-ID: <20040630050423.GM13200@pazke>
Mail-Followup-To: "Leonardo G. Di Lella" <leonardo@dilella.org>,
	linux-kernel@vger.kernel.org
References: <40E1CDEF.7050104@dilella.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <40E1CDEF.7050104@dilella.org>
User-Agent: Mutt/1.5.6+20040523i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 181, 06 29, 2004 at 08:15:43PM +0000, Leonardo G. Di Lella wrote:
> Hello list,
>=20
> there is an old prefix value in the dmi_scan.c.
>=20
> Line: 694 (Kernel 2.6.7)
>=20
> { sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop
>         */           =20
>                             MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
>                             MATCH(DMI_PRODUCT_NAME, "PCG-"),
>                             NO_MATCH, NO_MATCH,
>                             } },
>=20
> The DMI_PRODUCT_NAME doesnt match on newer vaio notebooks. (The newer=20
> A-series from sony vaio have VGN as product name instead of PCG - older=
=20
> model)
> This is the reason why the sonypi doesnt run on newer vaio notebooks.
> Maybe it is better to delete the line MATCH(DMI_PRODUCT_NAME, "PCG-").

It's better to add new DMI entry with MATCH(DMI_PRODUCT_NAME, "VGN-").

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4knXby9O0+A2ZecRAhOWAKCDEtyIZ0jvYqZiO05+cRIL7tV8/QCgpGGX
6Z0ccKQHG3BWiYrvGAl8Lvo=
=rkqu
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
