Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWHSFhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWHSFhA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 01:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWHSFhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 01:37:00 -0400
Received: from ozlabs.org ([203.10.76.45]:41141 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750763AbWHSFg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 01:36:59 -0400
Subject: Re: [2.6.19 PATCH 7/7] ehea: Makefile & Kconfig
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
In-Reply-To: <200608181337.44153.ossthema@de.ibm.com>
References: <200608181337.44153.ossthema@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d/zVtJ0sXMaA9uYIOfCS"
Date: Sat, 19 Aug 2006 15:25:57 +1000
Message-Id: <1155965157.1388.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d/zVtJ0sXMaA9uYIOfCS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-08-18 at 13:37 +0200, Jan-Bernd Themann wrote:
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>=20
>=20
>=20
>  drivers/net/Kconfig  |    6 ++++++
>  drivers/net/Makefile |    1 +
>  2 files changed, 7 insertions(+)
>=20
>=20
>=20
> diff -Nurp -X dontdiff linux-2.6.18-rc4/drivers/net/Kconfig patched_kerne=
l/drivers/net/Kconfig
> --- linux-2.6.18-rc4/drivers/net/Kconfig	2006-08-06 11:20:11.000000000 -0=
700
> +++ patched_kernel/drivers/net/Kconfig	2006-08-08 03:00:49.526421944 -070=
0
> @@ -2277,6 +2277,12 @@ config CHELSIO_T1
>            To compile this driver as a module, choose M here: the module
>            will be called cxgb.
> =20
> +config EHEA
> +        tristate "eHEA Ethernet support"
> +        depends on IBMEBUS
> +        ---help---
> +          This driver supports the IBM pSeries ethernet adapter
> +

Please give it a more detailed description. I have a pSeries machine
here with three NICs and none of them are eHEA.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-d/zVtJ0sXMaA9uYIOfCS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE5qDldSjSd0sB4dIRAjdxAKCPxNLMPLzPoSlWprLmOr8tzBMOwQCfR8zd
bJUO/0D0cZJTpGHNTepB/08=
=eqF6
-----END PGP SIGNATURE-----

--=-d/zVtJ0sXMaA9uYIOfCS--

