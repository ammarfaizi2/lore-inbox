Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUBKDpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 22:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBKDpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 22:45:21 -0500
Received: from c-24-15-25-98.client.comcast.net ([24.15.25.98]:25984 "EHLO
	chris.pebenito.dhs.org") by vger.kernel.org with ESMTP
	id S262564AbUBKDpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 22:45:17 -0500
Subject: Re: 2.6.3-rc1-mm1 (SELinux + ext3 + nfsd oops)
From: Chris PeBenito <pebenito@gentoo.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Stephen Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <Xine.LNX.4.44.0402102128210.9747-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0402102128210.9747-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Dvp8nMBgu1M5cWVFmjD7"
Message-Id: <1076471114.4925.0.camel@chris.pebenito.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 21:45:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Dvp8nMBgu1M5cWVFmjD7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Still oopses.  I also tried with 2.6.3-rc2, and it also oopses.

On Tue, 2004-02-10 at 20:29, James Morris wrote:
> On Tue, 10 Feb 2004, Chris PeBenito wrote:
>=20
> > I got an oops on boot when nfsd is starting up on a SELinux+ext3
> > machine.  It exports /home, which is mounted thusly:
> >=20
>=20
> What happens if you try this this patch:
>=20
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107637246127197&w=3D2 =
?
>=20
>=20
>=20
> - James
--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-Dvp8nMBgu1M5cWVFmjD7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAKaVKvI7kLeavkkMRAk+RAJ94V0FvfsP6h1ftrL2c6iIegNXIMwCdEIea
2ZGYQDOlXyGuKDvElAve9h4=
=9wRk
-----END PGP SIGNATURE-----

--=-Dvp8nMBgu1M5cWVFmjD7--
