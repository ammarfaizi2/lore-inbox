Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUBHV2C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 16:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUBHV2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 16:28:02 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:52437 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263539AbUBHV16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 16:27:58 -0500
Date: Sun, 8 Feb 2004 22:27:57 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IPV4 as module?
Message-ID: <20040208212757.GW28571@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040204200610.GB3802@localhost.localdomain> <20040205122921.GB28571@lug-owl.de> <Pine.LNX.4.58L.0402080257060.29247@rudy.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gb4bweTRjl1pQhan"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402080257060.29247@rudy.mif.pg.gda.pl>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gb4bweTRjl1pQhan
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-02-08 03:14:20 +0100, Tomasz K?oczko <kloczek@rudy.mif.pg.gda.=
pl>
wrote in message <Pine.LNX.4.58L.0402080257060.29247@rudy.mif.pg.gda.pl>:
> On Thu, 5 Feb 2004, Jan-Benedict Glaw wrote:
> > On Wed, 2004-02-04 23:06:10 +0300, Andrey Borzenkov <arvidjaar@mail.ru>
> > wrote in message <20040204200610.GB3802@localhost.localdomain>:
> > > Any technical reaon IPV4 cannot be built as module? Current kernel
> > > barely fits on floopy (even with IDE as module); factoring out IPV4
> > > would allow to reduce size even more.
> >=20
> > Some hard work need to be done to do that, but why shouldn't a kernel
> > fit onto a floppy? My vmlinuz'es are at about 600 to 900 KB for i386 and
> > a floppy can handle nearly about twice that size...
>=20
> Better will be ask why you must recompile kernel for add ipv4 abilities
> if you uses (olny) for example ipv6 stack ? :)

That's the other way around :) Let's just omit legacy IPv4!

> PS. Many modern PCs wave now only CD drive .. one CD can fit much=20
> more than kernel image and all kernel modules. So step your quostion path=
=20
> it will be "much more correct" ask why the hell kernel is (still ?)=20
> modular (?) 8^>

That's not all correct. You can fit 700 MB data on a CD-ROM, but booting
is still emulated from a 1.44 MB floppy (or some other floppy/HDD
images, but many BIOSses won't accept those (or handle them correctly)).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--gb4bweTRjl1pQhan
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAJqndHb1edYOZ4bsRAtpDAJwJ/6xAHgCfvB4HfNiY04FvX29wkgCeLFIq
TEsOD/GzlnXGSv/tETzXwps=
=eEzu
-----END PGP SIGNATURE-----

--gb4bweTRjl1pQhan--
