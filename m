Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTLRSOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 13:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbTLRSOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 13:14:39 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:25994 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265279AbTLRSOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 13:14:33 -0500
Subject: Re: gcc-3.3.2 vs 2.6.0-test11
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20031218000452.GA4289@werewolf.able.es>
References: <20031217113742.GC2074@werewolf.able.es>
	 <20031218000452.GA4289@werewolf.able.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jd0XhGH58wrPsBNULsvO"
Message-Id: <1071771392.11705.17.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Dec 2003 20:16:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jd0XhGH58wrPsBNULsvO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-12-18 at 02:04, J.A. Magallon wrote:
> On 12.17, J.A. Magallon wrote:
> > hi all..
> >=20
> > Are there any known issues wrt gcc-3.3.2 ?
> > I built test11 with gcc-3.3.1 and worked fine, the same config built wi=
th
> > 3.3.2 does not pass init launch:
> >=20
> > INIT version 2.85 booting
> >=20
> > and nothing more....
> >=20
> > I have to check, but I think it also miscompiles 2.4. I rebuilt a kerne=
l on a
> > remote box (2.4.23 + assorted patches), that worked fine under 3.3.1, a=
nd
> > after reboot the box didn't came to life, no ping.
> >=20
>=20
> Well, it fails to compile also 2.4. A 2.4 kernel that worked fine hangs w=
hen
> launching init if built with this gcc. It boots again if is built at -O i=
nstead
> of -O2.
>=20
> I think it is a Mandrake specific problem, as changelog reads:
>=20
> * Tue Dec 16 2003 Gwenole Beauchesne <gbeauchesne@mandrakesoft.com> 3.3.2=
-2mdk
>=20
> - Add gcj(1), aka make gc happy
> - Add [ep]mmintrin.h for even for SSE/PNI intrinsics
> - Move cc1 to gcc-cpp, thusly nuking gcc dep for XFree86
> - Remove -funit-at-a-time from -O2 since it is memory hungry
>=20
> * Mon Dec 15 2003 Gwenole Beauchesne <gbeauchesne@mandrakesoft.com> 3.3.2=
-1mdk
>=20
> - 3.3.2 + 3.3-hammer branch (2003/12/08)
>=20
> I think I don't like that hammer branch...

I wont add my opinion here about the hammer branch, but try
the gcc-3_3-rhl-branch which is gcc-3.3.relative_current maintained
by Jakub, and used by us with a patch or two added.


Regards,

--=20

Martin Schlemmer




--=-Jd0XhGH58wrPsBNULsvO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/4e8AqburzKaJYLYRAi6qAKCAxdUL1lltUmADtz2k6wu3KGtPhQCfVVGo
RI0u+xG8DqNltwrUjG10GJU=
=Rc67
-----END PGP SIGNATURE-----

--=-Jd0XhGH58wrPsBNULsvO--

