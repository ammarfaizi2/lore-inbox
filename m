Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269616AbUHZUcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269616AbUHZUcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269593AbUHZUbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:31:43 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:53414 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269595AbUHZU0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:26:13 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jonathan Abbey <jonabbey@arlut.utexas.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
In-Reply-To: <20040826201639.GA5733@mail.shareable.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
	 <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20040826193617.GA21248@arlut.utexas.edu>
	 <20040826201639.GA5733@mail.shareable.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/lH6kvm1JVZkuxIJ+gc8"
Date: Thu, 26 Aug 2004 22:25:56 +0200
Message-Id: <1093551956.13881.34.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/lH6kvm1JVZkuxIJ+gc8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 21:16 +0100 schrieb Jamie Lokier:

> > | Will it work out if "dir inside file" will only be visible when
> > referred as "file/."?
> >=20
> > I'm used to using ls symlink/. to get ls to show me the directory on
> > the far side of a symbolic link.  That's a pretty analagous case to
> > the one we're discussing here, I think?
>=20
> By the way, do symlinks have metadata?  Where do you find it? :)

Oops. :)

At least in reiser4 they don't have, or at least you can't access them.
ln -s foo bar; cd bar/metas shows me the content of foo/metas.

symlinks are special anyway. Their rights are 777. The only thing they
can have is an owner. No chance to do a symlink/metas/uid then. Hmm.


--=-/lH6kvm1JVZkuxIJ+gc8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLkdUZCYBcts5dM0RApi+AKCJO51/3aeYsKTo1mqaGneW7AsmVgCeJfFY
4tBtGpcs1InekspFwxpl42w=
=RuGd
-----END PGP SIGNATURE-----

--=-/lH6kvm1JVZkuxIJ+gc8--

