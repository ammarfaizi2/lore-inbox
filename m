Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVDEANa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVDEANa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 20:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVDDWzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:55:24 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:36246 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S261458AbVDDWtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:49:43 -0400
Subject: Re: [openib-general] [PATCH][RFC][3/4] IB: userspace verbs mthca
	changes
From: Tom Duffy <tduffy@sun.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <200544159.AzH1nqpM3uTQZaKG@topspin.com>
References: <200544159.AzH1nqpM3uTQZaKG@topspin.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-i06RB/mQ+GW4MBCVQhIL"
Date: Mon, 04 Apr 2005 15:49:35 -0700
Message-Id: <1112654975.22537.12.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i06RB/mQ+GW4MBCVQhIL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-04-04 at 15:09 -0700, Roland Dreier wrote:
> --- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-04 =
14:57:12.254750421 -0700
> +++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-04 14:58=
:12.411669307 -0700
> @@ -49,14 +49,6 @@
>  #define DRV_VERSION	"0.06-pre"
>  #define DRV_RELDATE	"November 8, 2004"
> =20
> -/* XXX remove once SINAI defines make it into kernel.org */
> -#ifndef PCI_DEVICE_ID_MELLANOX_SINAI_OLD
> -#define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
> -#endif
> -#ifndef PCI_DEVICE_ID_MELLANOX_SINAI
> -#define PCI_DEVICE_ID_MELLANOX_SINAI 0x6274
> -#endif
> -
>  enum {
>  	MTHCA_FLAG_DDR_HIDDEN =3D 1 << 1,
>  	MTHCA_FLAG_SRQ        =3D 1 << 2,

Now, you are really gonna hate me for asking you to put this in as you
probably did not want to include this in the patch to lkml.

So, maybe Grant was right ;-)

-tduffy

--=-i06RB/mQ+GW4MBCVQhIL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCUcR+dY502zjzwbwRAs7nAJ9oH/kLR0hwx4TtDmUuSuQVx/6YnACeLtL/
tprvo+97FIbSRC8rSKsyTrg=
=j7ia
-----END PGP SIGNATURE-----

--=-i06RB/mQ+GW4MBCVQhIL--
