Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVCUSIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVCUSIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVCUSIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:08:42 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:43664 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261407AbVCUSI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:08:26 -0500
From: Mws <mws@twisted-brains.org>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Date: Mon, 21 Mar 2005 19:08:40 +0100
User-Agent: KMail/1.8
References: <20050314170653.1ed105eb.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz>
In-Reply-To: <20050321101441.GA23456@elf.ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2651774.BZUJQqAiiK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503211908.46602.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2651774.BZUJQqAiiK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi everybody, hi pavel

>On Monday 21 March 2005 11:14, you wrote:
> Hi!
>=20
> > >Also, this filesystem seems to do the same thing as cramfs.  We'd need=
 to
> > >understand in some detail what advantages squashfs has over cramfs to
> > >justify merging it.  Again, that is something which is appropriate to =
the
> > >changelog for patch 1/1.
> >=20
> > Well, probably Phillip can answer this better than me, but the main=20
> > differences that affect end users (and that is why we are using SquashF=
S=20
> > right now) are:
> >                           CRAMFS          SquashFS
> >=20
> > Max File Size               16Mb               4Gb
> > Max Filesystem Size        256Mb              4Gb?
>=20
> So we are replacing severely-limited cramfs with also-limited
> squashfs... For live DVDs etc 4Gb filesystem size limit will hurt for
> sure, and 4Gb file size limit will hurt, too. Can those be fixed?
>=20
> 								Pavel
no - squashfs _is_ indeed an advantage for embedded systems in
comparison to cramfs. why does everybody think about huge systems=20
with tons of ram, cpu power whatever - there are also small embedded systems
which have real small resources.=20

some notes maybe parts are OT - but imho it must be said someday

=2D reviewing the code is absolutely ok.=20
=2D adding comments helps the coder and also the users to understand=20
  _how_ kernel coding is to be meant

=2D but why can't people just stop to blame every really good thing?

in this case it means:
	of course cramfs and squashfs are to different solutions for saving data
	in embedded environments like set-top-boxes, pda, ect., but there is=20
        a need for having inventions as higher compression rates or more da=
ta security.=20
=09
in other cases that means:
       of course there are finished network drivers from Syskonnect/Marvel/=
Yukon=20
       for the GBit network interfaces.=20
       Also they were send to the ml. but nearly the same thing happened to=
 them
       reviewing the code, critics, and rejection of their code.=20
=20
this all ends up in not supported hardware - or - someday supported hardwar=
e cause
somebody is in reel need of those features and just publishes the patches o=
nline like a=20
DIY-Patchset for different kernel versions.=20

Hasn't it been the aim of linux to run on different architectures, support =
lots of filesystems,=20
partition types, network adapters, bus-systems whatever?=20

but if there is a contribution from the outside - it is not taken "as is" a=
nd maybe fixed up, which
should be nearly possible in the same time like analysing and commenting th=
e code - it ends up
in having less supported hardware.=20

imho if a hardware company does indeed provide us with opensource drivers, =
we should take these
things as a gift, not as a "not coding guide a'like" intrusion which has to=
 be defeated.

ready to take your comments :)

regards
marcel



--nextPart2651774.BZUJQqAiiK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCPw2uPpA+SyJsko8RAma+AJ9NjEOPqGVXCuORxKGEEn/uTQIsHQCg349+
bafuIy+TkOpXxjkNelmO6uc=
=gzEJ
-----END PGP SIGNATURE-----

--nextPart2651774.BZUJQqAiiK--
