Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbUJZVLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUJZVLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUJZVLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:11:14 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:21485 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261471AbUJZVHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:07:48 -0400
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for
	initramfs image updates [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20041026221216.GA30918@mars.ravnborg.org>
References: <200410200849.i9K8n5921516@mail.osdl.org>
	 <1098533188.668.9.camel@nosferatu.lan>
	 <20041026221216.GA30918@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AcwpL8BgY+MTw6yKxJG2"
Date: Tue, 26 Oct 2004 23:07:29 +0200
Message-Id: <1098824849.12420.60.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AcwpL8BgY+MTw6yKxJG2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-10-27 at 00:12 +0200, Sam Ravnborg wrote:
> On Sat, Oct 23, 2004 at 02:06:28PM +0200, Martin Schlemmer [c] wrote:
> > Hi,
> >=20
> > Here is some updates after talking to Sam Ravnborg.  He did not yet com=
e
> > back to me, I am not sure if I understood 100% what he meant, but hopef=
ully
> > somebody else will be so kind as to comment.
>=20
> Hi Martin.
> Took a look at your patch and did not like it.
> Attached my version which I will push towards Linus soon.
>=20

Thats ok - I never said I was an expert with kbuild =3D)

> Main difference is that I move logic to gen_initramfs_list-sh.
> Then I also use filechk - so I actually generate the file - but
> do not update the final file unless needed.
>=20

Much more elegant, thanks.

> Current patch will not rebuild image if one of the
> programs listed are changed. But it should give a good
> foundation to do so.
>=20

I will see if I get the time to get that implemented elegantly if
you do not beat me to it.


Thanks,

--=20
Martin Schlemmer


--=-AcwpL8BgY+MTw6yKxJG2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBfryRqburzKaJYLYRAmo8AJ9E3YAt5ilQHH87W06OyxdIrgrNPACeO1cf
N2wK3aCo0e6QouydSw4bnc4=
=f/0h
-----END PGP SIGNATURE-----

--=-AcwpL8BgY+MTw6yKxJG2--

