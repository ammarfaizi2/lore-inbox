Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWDERFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWDERFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWDERFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:05:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:24787 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751287AbWDERFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:05:15 -0400
X-Sasl-enc: zRGBjPqA7v4RtBF0V2CFSKLA/uiOveVr7uvQoN3tKo7g 1144256704
Message-ID: <4433F8F4.4060707@imap.cc>
Date: Wed, 05 Apr 2006 19:05:56 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: hjlipp@web.de, gigaset307x-common@lists.sourceforge.net, kkeil@suse.de,
       isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ISDN_DRV_GIGASET should select, not depend on CRC_CCITT
References: <20060405163202.GF8673@stusta.de>
In-Reply-To: <20060405163202.GF8673@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA5E0AE3385DC21E688C1E483"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA5E0AE3385DC21E688C1E483
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05.04.2006 18:32, Adrian Bunk wrote:
> CRC_CCITT is an internal helper function that should be select'ed.

Good point. Thanks.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Tilman Schmidt <tilman@imap.cc>

>=20
> --- linux-2.6.17-rc1-mm1-full/drivers/isdn/gigaset/Kconfig.old	2006-04-=
05 17:42:54.000000000 +0200
> +++ linux-2.6.17-rc1-mm1-full/drivers/isdn/gigaset/Kconfig	2006-04-05 1=
7:43:07.000000000 +0200
> @@ -3,7 +3,8 @@
> =20
>  config ISDN_DRV_GIGASET
>  	tristate "Siemens Gigaset support (isdn)"
> -	depends on ISDN_I4L && CRC_CCITT
> +	depends on ISDN_I4L
> +	select CRC_CCITT
>  	help
>  	  Say m here if you have a Gigaset or Sinus isdn device.
> =20
>=20


--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigA5E0AE3385DC21E688C1E483
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEM/j+MdB4Whm86/kRAssFAJ9L34vpvkQ8p7nf1VUXfj2v6ydawQCfekYF
3kSTYm6ZtWbSzLHwKs4Wqmo=
=e1Al
-----END PGP SIGNATURE-----

--------------enigA5E0AE3385DC21E688C1E483--
