Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbTEDXpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 19:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTEDXpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 19:45:18 -0400
Received: from cpt-dial-196-30-179-171.mweb.co.za ([196.30.179.171]:14208 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S261847AbTEDXpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 19:45:13 -0400
Subject: Re: Re:[2.5] Update sk98lin driver
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <3EB5867D.1000404@wanadoo.es>
References: <3EB5867D.1000404@wanadoo.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Gejk86/Fg6QJkD6apIIJ"
Organization: 
Message-Id: <1052092571.4459.27.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 05 May 2003 01:56:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gejk86/Fg6QJkD6apIIJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-04 at 23:30, Xose Vazquez Perez wrote:
> Martin Schlemmer wrote:
>=20
> >I have a 3Com 3c940 gigabit LOM, that is basically a
> >SysKonnect chipset card. Here are later drivers that
> >do support it:
> >
> > ftp://ftp.asus.com.tw/pub/ASUS/lan/3com/3c940/041_Linux.zip
>=20
> latest drivers for SK-98xx and clones are 6.05 version.
> patch for 2.4.20: http://www.syskonnect.de/syskonnect/support/driver/zip/=
sk98lin_2.4.20_patch.gz
>=20

Ok, I updated it to 6.05, and can be found here:

  ftp://ftp.puk.ac.za/incoming/sk98lin-update-2.5.68.patch.bz2

A few issues though:

1)  Should MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT just be removed?
    I commented them for now.

2)  What other changes should be done for 2.5 ?


Thanks,

--=20

Martin Schlemmer
Gentoo Linux Developer, Desktop/System Team Developer
Cape Town, South Africa



--=-Gejk86/Fg6QJkD6apIIJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+taibqburzKaJYLYRApVWAKCcCcfCcpnsMq7+YJHwW5fe7SvMLwCgjLuj
+sJCYcZ4hPamefA2gtkfsfg=
=+Gn/
-----END PGP SIGNATURE-----

--=-Gejk86/Fg6QJkD6apIIJ--

