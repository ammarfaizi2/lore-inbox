Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbTDIWbF (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTDIWbF (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:31:05 -0400
Received: from cpt-dial-196-30-180-211.mweb.co.za ([196.30.180.211]:43392 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263976AbTDIWbB (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:31:01 -0400
Subject: Re: Slab corruption with ext3-handle-cache.patch
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Andrew Morton <akpm@digeo.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030405151025.249b261e.akpm@digeo.com>
References: <1049580790.29758.8.camel@nosferatu.lan>
	 <20030405143852.67833364.akpm@digeo.com>
	 <1049582687.29758.11.camel@nosferatu.lan>
	 <20030405151025.249b261e.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FY5M10tk1uXCwC89361V"
Organization: 
Message-Id: <1049927148.6793.44.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 10 Apr 2003 00:25:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FY5M10tk1uXCwC89361V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-04-06 at 01:10, Andrew Morton wrote:
> Martin Schlemmer <azarah@gentoo.org> wrote:
> >
> > > Do you have CONFIG_EXT3_FS_POSIX_ACL enabled?
> >=20
> > Nope.
>=20
> So we're leaving an inode on the orphan list.  I wonder why that started
> happening.  Thanks.

I moved all my data off that partition, removed it, and recreated it
without HTREE/dir_index, and moved everything back.  All issues are
resolved, as well as the weird corruption I had.

It seems thus that its only related to HTREE ...


Regards,

--=20

Martin Schlemmer


--=-FY5M10tk1uXCwC89361V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQA+lJ3sqburzKaJYLYRAhHcAJjIzdXef2aM9cpAZsXItQiOKA6CAJ46XG9h
548xTpsT0HGdtAqd4w29aQ==
=TsR6
-----END PGP SIGNATURE-----

--=-FY5M10tk1uXCwC89361V--

