Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbUBIM2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUBIM2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:28:30 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:58532 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S265061AbUBIM21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:28:27 -0500
Date: Mon, 9 Feb 2004 12:28:25 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org,
       Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Message-ID: <20040209122825.GA22679@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org,
	Nico Schottelius <nico-kernel@schottelius.org>
References: <20040209115852.GB877@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20040209115852.GB877@schottelius.org>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2004 at 12:58:52PM +0100, Nico Schottelius wrote:
> Morning!
>=20
> What Linux supported filesystems support UTF-8 filenames?
>=20
> Looks like at least xfs and reiserfs are not able of handling them,

   I'm using ReiserFS on my media drive, and I can tell you that the
UTF-8 works fine on the filesystem:

hrm@vlad:Les-Granges-Brul=E9es $ ls
Descente-Au-Village.ogg		    Les-Granges-Brul=E9es.ogg
G=E9n=E9rique.ogg			    L'H=E9licopt=E8re.ogg
H=E9sitation.ogg			    Reconstitution.ogg
La-Chanson-Des-Grange-Brul=E9es.ogg   Rose.ogg
La-Perquisition-Et-Les-Paysans.ogg  Th=E9me-De-L'Argent.ogg
La-V=E9rit=E9.ogg			    typescript
Le-Car+Le-Chasse-Neige.ogg	    Une-Morte-Dans-La-Neige.ogg
Le-Juge.ogg			    Zig-Zag.ogg
Le-Pays-de-Rose.ogg

> As Apache with UTF-8 as default charset delievers wrong names, when
> accessing files with German umlauts.

   I'd suspect a problem with Apache more than a problem with the
filesystem.

   Hugo.

--=20
=3D=3D=3D Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk=
 =3D=3D=3D
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
    --- There's an infinite number of monkeys outside who want to ---   =20
               talk to us about this new script for Hamlet              =20
                           they've worked out!                          =20

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJ3zpssJ7whwzWGARAqlkAJwIvBE6T4zo3UFOHgAg/eLnWg2oCgCgrwuK
fqw58aLElMTAcHF4qCs8avg=
=BSNd
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
