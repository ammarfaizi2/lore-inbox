Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTCAXfj>; Sat, 1 Mar 2003 18:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTCAXfj>; Sat, 1 Mar 2003 18:35:39 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:11140 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267278AbTCAXfh>; Sat, 1 Mar 2003 18:35:37 -0500
Subject: Re: Help porting MPPE PPP patch
From: Shawn <core@enodev.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1046543807.4607.10.camel@localhost.localdomain>
References: <1046543807.4607.10.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jrIUsM0WT8KjG2RPYKFr"
Organization: 
Message-Id: <1046562361.15129.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 01 Mar 2003 17:46:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jrIUsM0WT8KjG2RPYKFr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ok, how about just pointing me to some documentation? That's really what
I wanted.

Can someone be bothered to reply?

On Sat, 2003-03-01 at 12:36, Shawn wrote:
> Hi! I'm posting to humbly ask for help...
>=20
> I was wondering if one of you kind souls might like to help me port the
> attached patch over to the current 2.5?
>=20
> So far all I know how to do is, in place of the current
> drivers/net/Makefile and drivers/net/Config.in patches are the
> following:
>=20
> ->drivers/net/Kconfig:
> config PPP_MPPE
> 	tristate "PPP MPPE compression (encryption)"
>=20
> ->drivers/net/Makefile:
> obj-$(CONFIG_PPP_MPPE) =3D ppp_mppe_compress.o sha1.o arcfour.o
>=20
> But I end up with the following when I try to build the module. Those
> symbols are in sha1.c and arcfour.c.
>=20
> *** Warning: Can't handle class_mask in drivers/ieee1394/ohci1394:FFFFFF
> *** Warning: "ppp_unregister_compressor"
> [drivers/net/ppp_mppe_compress.ko] undefined!
> *** Warning: "ppp_register_compressor"
> [drivers/net/ppp_mppe_compress.ko] undefined!
> *** Warning: "arcfour_encrypt" [drivers/net/ppp_mppe_compress.ko]
> undefined!
> *** Warning: "arcfour_setkey" [drivers/net/ppp_mppe_compress.ko]
> undefined!
> *** Warning: "SHA1_Final" [drivers/net/ppp_mppe_compress.ko] undefined!
> *** Warning: "SHA1_Update" [drivers/net/ppp_mppe_compress.ko] undefined!
> *** Warning: "SHA1_Init" [drivers/net/ppp_mppe_compress.ko] undefined!
> *** Warning: "page_states__per_cpu" [fs/nfs/nfs.ko] has no CRC!
>=20
> Any help would be endlessly appreciated.
>=20

--=-jrIUsM0WT8KjG2RPYKFr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+YUY5ubgCGkrWpN4RAnhsAJ9c0mcROYQdHoe4aWeIJWd9AvWJBQCfXzBM
4xdw6uqB2+gvzwivBD2RIRE=
=Qdhc
-----END PGP SIGNATURE-----

--=-jrIUsM0WT8KjG2RPYKFr--
