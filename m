Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTJUV2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTJUV1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:27:08 -0400
Received: from [199.45.143.209] ([199.45.143.209]:7686 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S263368AbTJUV0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:26:47 -0400
Subject: Re: 2.6.0-test8 and HIGMEM = segfaults and panics?
From: Zan Lynx <zlynx@acm.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031021195834.GG2617@rdlg.net>
References: <20031021155337.GF2617@rdlg.net>
	 <1066762982.5055.3.camel@localhost.localdomain>
	 <20031021195834.GG2617@rdlg.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-S2dic4GkzodN0ijRZu33"
Organization: 
Message-Id: <1066771573.5055.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Oct 2003 15:26:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S2dic4GkzodN0ijRZu33
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-21 at 13:58, Robert L. Harris wrote:
> Yup, I've played musical DIMMS as well.  It's currently up running with
> 1.5G install without the HIGMEM and I've taxed it pretty hard today
> without issue.
>=20
> What kernel are you running on?
>=20
> They are registered.
>=20

Kernel 2.6.0-test8.
It's a Tyan MPX board with 4 512MB sticks of ECC registered 266 DDR.

Here's the highmem bit of my config file:
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=3Dy
CONFIG_HIGHPTE=3Dy

So, I don't think it's a general bug.

--=20
Zan Lynx <zlynx@acm.org>

--=-S2dic4GkzodN0ijRZu33
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/laR1G8fHaOLTWwgRAiq+AKCDkyXNB6nkjcTH/i4b9vQ6Z/I+CwCeNd2w
PgzM2YXb5yFeumaPGc5hWcs=
=FxpX
-----END PGP SIGNATURE-----

--=-S2dic4GkzodN0ijRZu33--

