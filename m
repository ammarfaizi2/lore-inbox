Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTDEWh7 (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbTDEWh7 (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:37:59 -0500
Received: from cpt-dial-196-30-178-31.mweb.co.za ([196.30.178.31]:16257 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262700AbTDEWh5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:37:57 -0500
Subject: Re: Slab corruption with ext3-handle-cache.patch
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Andrew Morton <akpm@digeo.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030405143852.67833364.akpm@digeo.com>
References: <1049580790.29758.8.camel@nosferatu.lan>
	 <20030405143852.67833364.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-u4bSYd6J/v4LqbOmF1XH"
Organization: 
Message-Id: <1049582687.29758.11.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 06 Apr 2003 00:44:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u4bSYd6J/v4LqbOmF1XH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-04-06 at 00:38, Andrew Morton wrote:
> Martin Schlemmer <azarah@gentoo.org> wrote:
> >
> > Hi
> >=20
> > I tried this patch a few days again, but not in the mm patch set.  So
> > when I got problems with slab corruption, I figured it was maybe a
> > patch I missed, and dropped it.
> >=20
> > Now with 2.5.66-bk10+, it is merged, and I get it again.
> >=20
> > ----------------------------------------------------------
> > Slab corruption: start=3Dcfaeecc4, expend=3Dcfaeee77, problemat=3Dcfaee=
d28
> > Last user: [<c01890de>](ext3_destroy_inode+0x1b/0x1f)
> > Data:
> > ***********************************************************************=
*****************************3C 26 99 DF **********************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
************************************************************************A5=20
>=20
> Do you have CONFIG_EXT3_FS_POSIX_ACL enabled?

Nope.

-------------------
 # grep CONFIG_EXT3_FS_POSIX_ACL .config
# CONFIG_EXT3_FS_POSIX_ACL is not set
 #=20
-------------------


--=20

Martin Schlemmer




--=-u4bSYd6J/v4LqbOmF1XH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+j1xfqburzKaJYLYRAv2pAKCQ4rlbWs4iFGCRNZd1eLsbuaoz8ACfTzgE
guDWSATwRyHK4GGtqN6EPIw=
=erPW
-----END PGP SIGNATURE-----

--=-u4bSYd6J/v4LqbOmF1XH--

