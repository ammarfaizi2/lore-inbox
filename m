Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbTGTQMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbTGTQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 12:12:35 -0400
Received: from quake.mweb.co.za ([196.2.45.76]:23469 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id S267323AbTGTQMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 12:12:32 -0400
Subject: Re: devfsd/2.6.0-test1
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: Mark Watts <m.watts@eris.qinetiq.com>, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030717183139.17023B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030717183139.17023B-100000@gatekeeper.tmr.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7Lt6k6a+JkixQBaZzKBJ"
Message-Id: <1058718448.19817.5.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Jul 2003 18:27:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7Lt6k6a+JkixQBaZzKBJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-18 at 00:39, Bill Davidsen wrote:
> On 17 Jul 2003, Martin Schlemmer wrote:
>=20
> > On Thu, 2003-07-17 at 11:17, Mark Watts wrote:
>=20
> > > I'm running devfs on a 2.6.0-test1 box (Mandrake 9.1 with the new ker=
nel)
> > >=20
> > > Every time I boot, it complains that I don't have an /etc/modprobe.de=
vfs.
> > > If I symlink modules.devfs, I get a wad of errors about 'probeall'.
> > > What should a modprobe.devfs look like for a 2.5/6 kernel?
> > >=20
> >=20
> > The module-init-tools tarball should include one.
>=20
> Agreed, it should. However, the last version I pulled had zero support fo=
r
> probeall, and more importantly for probe, which is somewhat harder to do
> cleanly without having to rewrite the config file for each kernel you
> boot.
>=20

Well, it implements probeall in another fashion.  Also, you might
try /sbin/generate-modprobe.conf to convert a modules.conf to
modprobe.conf syntax.

> I assume someone will need to write a functional config parser which
> handles these features before 2.6 is seriously ready for production.
> Giving up the ability to find the working module for a device would be a
> step back, and is needed to allow booting with changing configurations,
> such as docked or not laptops, PCMCIA cards inserted, various hardware
> such as printers and scanners attached, etc.

Also, read the threads on the list about udev/hotplug - apparently
devfsd is going out ...


Regards,

--=20

Martin Schlemmer




--=-7Lt6k6a+JkixQBaZzKBJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQA/GsLsqburzKaJYLYRAkJiAJMFjVBLSe7R1nhbfu2iyyrx1vClAJ9RFosg
TgQB50QD1bIBiKHo2A7xbA==
=5Vgy
-----END PGP SIGNATURE-----

--=-7Lt6k6a+JkixQBaZzKBJ--

