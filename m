Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbULDUjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbULDUjH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 15:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbULDUjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 15:39:07 -0500
Received: from sp36.amenworld.com ([62.193.200.26]:59624 "EHLO tuxedo-es.org")
	by vger.kernel.org with ESMTP id S261154AbULDUjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 15:39:00 -0500
Subject: SELinux port for 2.4.28 (and incoming backport from 2.6) released.
From: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
Reply-To: lorenzo@gnu.org
To: selinux@tycho.nsa.gov
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6J4wQB4+6SgNjy9Ob89j"
Date: Sat, 04 Dec 2004 21:38:43 +0100
Message-Id: <1102192723.19001.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6J4wQB4+6SgNjy9Ob89j
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I was wondering for a backport of SELinux patch for the 2.4 brand, and
i've observed that there's just a patch, deprecated, for 2.4.26.

As the first move for trying to backport the current 2.6 patch
capabilities i've ported the old 2.4.26 patch to 2.4.28, without huge
problems and just fixing some errors with proc fs stuff and others.

I've not tested it yet, but hopefully works.

I want to know if someone is interested in doing this, as the main
reasons are that 2.4 kernels are used by many people, possibly more than
the ones using revisions from the 2.6 brand, and also that we can offer
the possibility of using the SELinux enhancements without changing the
kernel.In addition, if you compare 2.6 revisions changelogs with 2.4
ones you can see that many things change between releases, and not in
2.4 that are only security related and critical or major enhancements.

The gzip'ed patch can be found at:
https://sourceforge.net/project/showfiles.php?group_id=3D118309&package_id=
=3D137453

Joshua was telling me that many things changed in the 2.6 releases, and
that many things are deprecated or obsolete in the old 2.4.26 patch, so,
i will appreciate any help for backporting them and giving support for
those new capabilities.

I'm CC'ing the LKML because this could be of interest for the kernel
hackers, in an hypothetical case of including a backported and updated
version of SELinux patch in the 2.4 brand.

Cheers and enjoy,
PS: I'm not an experienced developer in C terms, i just do what i can do
and often i get obsessed when i can't get something done, so, i think
that equilibrates the balance of knowledge<->attitudes (it's not easy to
fit all of this in time when you're just fifteen years old, but i can't
excuse unexpected kernel panics :) ).  =20
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro [1024D/6F2B2DEC]
Hardened Debian head developer & project manager.
http://www.debian-hardened.org=20

--=-6J4wQB4+6SgNjy9Ob89j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBsiBTDcEopW8rLewRAr1dAKCKWqroKehwlmhVmsn8tvTe/rjAjwCeLvHX
dFohCvkKK6BQvBbV8OCmf0k=
=cHDw
-----END PGP SIGNATURE-----

--=-6J4wQB4+6SgNjy9Ob89j--

