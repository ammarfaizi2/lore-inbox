Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUFTA3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUFTA3J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUFTA3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:29:09 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:47068 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264788AbUFTA3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:29:02 -0400
Subject: Re: 2.6.7 Samba OOPS (in smb_readdir)
From: Christophe Saout <christophe@saout.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406191946360.2228@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	 <20040618163759.GN1146@ens-lyon.fr> <20040618164125.GO1146@ens-lyon.fr>
	 <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com>
	 <1087585251.13235.3.camel@leto.cs.pocnet.net>
	 <1087586532.9085.1.camel@leto.cs.pocnet.net>
	 <Pine.LNX.4.58.0406191624430.2228@montezuma.fsmlabs.com>
	 <Pine.LNX.4.58.0406191648240.2228@montezuma.fsmlabs.com>
	 <Pine.LNX.4.58.0406191946360.2228@montezuma.fsmlabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3EsD/Ebv8Ag9OqhYRZ6+"
Date: Sun, 20 Jun 2004 02:28:55 +0200
Message-Id: <1087691335.19685.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3EsD/Ebv8Ag9OqhYRZ6+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sa, den 19.06.2004 um 20:27 Uhr -0400 schrieb Zwane Mwaikambo:

> > > This is an updated debugging patch (which is also added to Bugzilla),
> > > please give this a spin. There are still a few issues with this patch=
 but
> > > lets try at least avoid oopsing for now.
> >
> > Hold on, this is buggy garbage. i'll have something in a bit.
>=20
> Index: linux-2.6.7/include/linux/smb_fs_sb.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /home/cvsroot/linux-2.6.7/include/linux/smb_fs_sb.h,v

Ha! Success! :-)


--=-3EsD/Ebv8Ag9OqhYRZ6+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1NpGZCYBcts5dM0RAoldAJ94YqsYkfdzrds9sJmVK5S8KNOFBwCeLFKt
+TJUtmxD2EGa9dqp6FbeJcA=
=CrRu
-----END PGP SIGNATURE-----

--=-3EsD/Ebv8Ag9OqhYRZ6+--

