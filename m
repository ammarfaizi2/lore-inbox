Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312964AbSC2Ebf>; Thu, 28 Mar 2002 23:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313347AbSC2Eb0>; Thu, 28 Mar 2002 23:31:26 -0500
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:1430 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S312964AbSC2EbJ>; Thu, 28 Mar 2002 23:31:09 -0500
Subject: Re: mkinitrd w/ 2.4.18
From: NyQuist <nyquist@ntlworld.com>
To: Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-MGewNDVNkq3a75TDXPxj"
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 29 Mar 2002 04:27:53 +0000
Message-Id: <1017376074.2785.1.camel@stinky.pussy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MGewNDVNkq3a75TDXPxj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-03-29 at 03:01, Matthew Walburn wrote:
> > I would appreciate if you hit enter about every 70 keystrokes.
>=20
> Sorry about that didnt realize it wasn't wrapping.
>=20
> > Also, describing a symptom rather than vague "i'm having problems"
> > may help.
>=20
> Specifically, i get the error message:
> "all of your loopback devices are in use"
>=20
you need to have loop.o insmodd'ed (insmod loop) to mkinitrd. If you're
using rh's stock kernel, I *believe* this is included as a module. If
you're running mkinitrd from your rebuilt kernel, check
/lib/modules/2.4.18/kernel/drivers/net for loop.o (methinks).
hth

> I have the follow kernel options enabled, using Redhat's kernel
> config as a guide:
>=20
> CONFIG_BLK_DEV_LOOP=3Dm
> CONFIG_BLK_DEV_NBD=3Dm
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_SIZE=3D4096
> CONFIG_BLK_DEV_INITRD=3Dy
>=20
> Thanks for the help.
>=20
> -Matt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
NyQuist | Matthew Hall -- NyQuist at ntlworld dot com --
http://NyQuist.port5.com
Sig: Any sufficiently advanced technology is indistinguishable from a
rigged demo.


--=-MGewNDVNkq3a75TDXPxj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8o+1JHgHoS2SXebARAv1MAJ9hgfAmka+RQzskxMN2mEA0BfDvLQCgmqK5
gkaWQOSaortWnB5B0bnZfMc=
=6JQ7
-----END PGP SIGNATURE-----

--=-MGewNDVNkq3a75TDXPxj--

