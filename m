Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUFSUwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUFSUwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUFSUwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:52:22 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:60886 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264665AbUFSUwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:52:14 -0400
Subject: Re: 2.6.7 Samba OOPS (in smb_readdir)
From: Christophe Saout <christophe@saout.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406191648240.2228@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	 <20040618163759.GN1146@ens-lyon.fr> <20040618164125.GO1146@ens-lyon.fr>
	 <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com>
	 <1087585251.13235.3.camel@leto.cs.pocnet.net>
	 <1087586532.9085.1.camel@leto.cs.pocnet.net>
	 <Pine.LNX.4.58.0406191624430.2228@montezuma.fsmlabs.com>
	 <Pine.LNX.4.58.0406191648240.2228@montezuma.fsmlabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3t8DWmHjCRESVp/Zs8Xc"
Date: Sat, 19 Jun 2004 22:52:02 +0200
Message-Id: <1087678322.15681.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3t8DWmHjCRESVp/Zs8Xc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sa, den 19.06.2004 um 16:49 Uhr -0400 schrieb Zwane Mwaikambo:

> > > The oops is gone but the processes are still hanging. I'm posting the
> > > SysRq-T trace on bugzilla. Hope it helps. If you need some help
> > > debugging the problem, please tell me if I can do something.
> >
> > This is an updated debugging patch (which is also added to Bugzilla),
> > please give this a spin. There are still a few issues with this patch b=
ut
> > lets try at least avoid oopsing for now.
>=20
> Hold on, this is buggy garbage. i'll have something in a bit.

Well ok. smbiod was still hanging and all requests timed out, but I was
able to cleanly unmount the filesystem and unload the module this time.
No Oops.


--=-3t8DWmHjCRESVp/Zs8Xc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1KdxZCYBcts5dM0RAr0qAJ0X2AQJkj5S5b/08e30d01h+npewQCgphIX
FfA3x8qagqLAqr/Fl9tEuPA=
=6y2l
-----END PGP SIGNATURE-----

--=-3t8DWmHjCRESVp/Zs8Xc--

