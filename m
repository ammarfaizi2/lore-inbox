Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269493AbUHZTXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269493AbUHZTXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269232AbUHZTTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:19:00 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:48803 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269369AbUHZTOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:14:35 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.44.0408261457320.27909-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0408261457320.27909-100000@chimarrao.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jv2CIMyIb75JW1A5gOC/"
Date: Thu, 26 Aug 2004 21:14:18 +0200
Message-Id: <1093547658.13881.2.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jv2CIMyIb75JW1A5gOC/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 14:59 -0400 schrieb Rik van Riel:

> open("/tmp/bash", O_WRONLY|O_CREAT|O_LARGEFILE, 0100755) =3D 4
>=20
> What do we do with O_CREAT ?
>=20
> Do we always allow both a directory and a file to be created with
> the same name ?

I would say that the directory under a file is implicit. There are still
the pseudo-files a filesystem might want to provide or the VFS if there
should be an agreement to generally provide file/pseudo/uid or possibly
some security hooks. Some filesystem might want to provide those pseudo
files but doesn't have the technical possibility to store non-pseudeo
files from the user under such a directory.


--=-jv2CIMyIb75JW1A5gOC/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLjaKZCYBcts5dM0RAnXAAJ9M62HfQEVLXKnVcGsOA59apAQ/ngCfTlud
1XjhRsilWc3irmjiCOTg8XI=
=c159
-----END PGP SIGNATURE-----

--=-jv2CIMyIb75JW1A5gOC/--

