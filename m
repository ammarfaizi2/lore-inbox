Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269613AbUHZU7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269613AbUHZU7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269603AbUHZUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:55:26 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:20136 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269601AbUHZUuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:50:46 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Will Dyson <will_dyson@pobox.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1093552705.5678.96.camel@krustophenia.net>
References: <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de>
	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
	 <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826001152.GB23423@mail.shareable.org>
	 <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826010049.GA24731@mail.shareable.org>
	 <20040826100530.GA20805@taniwha.stupidest.org>
	 <20040826110258.GC30449@mail.shareable.org>  <412E06B2.7060106@pobox.com>
	 <1093552705.5678.96.camel@krustophenia.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-njmBt7sJI+Y+Bwmp5TfP"
Date: Thu, 26 Aug 2004 22:50:29 +0200
Message-Id: <1093553429.13881.48.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-njmBt7sJI+Y+Bwmp5TfP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 16:38 -0400 schrieb Lee Revell:

> > It has always bugged me that Gnome and KDE implement their own VFS laye=
rs.=20
>=20
> Same here.  This always seemed like something the kernel should be able
> to handle.  It seems to me that if reiser4 had been available at the
> time the Gnome and KDE developers would not have needed to do this.

Well, the kernel doesn't have a filesystem that speaks http, scp and
those things. GnomeVFS is URL-based. It has some pseudo-protocols that
extract a pseudo directory-tree for all installed applications + the
changes the used made, created on the fly from a set of XML files that
are read-only and system-wide and the user-overridden changes. I don't
know if all of these things would really make sense inside the kernel.


--=-njmBt7sJI+Y+Bwmp5TfP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLk0VZCYBcts5dM0RAgg0AKCLz0jkrP0PfSpQg147pJCZJb8iVACfbeyv
HzBIA9kmJoG/31QvfBIzeYE=
=/7ga
-----END PGP SIGNATURE-----

--=-njmBt7sJI+Y+Bwmp5TfP--

