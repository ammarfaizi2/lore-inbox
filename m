Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269558AbUHZU7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269558AbUHZU7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269660AbUHZU5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:57:15 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:41383 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269626AbUHZUiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:38:21 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Dmitry Baryshkov <mitya@school.ioffe.ru>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
In-Reply-To: <20040826203017.GA14361@school.ioffe.ru>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>
	 <20040826014542.4bfe7cc3.akpm@osdl.org> <412DAC59.4010508@namesys.com>
	 <1093548414.5678.74.camel@krustophenia.net>
	 <20040826203017.GA14361@school.ioffe.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iRiqRY6UDa+JwpiIC1hF"
Date: Thu, 26 Aug 2004 22:38:12 +0200
Message-Id: <1093552692.13881.43.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iRiqRY6UDa+JwpiIC1hF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 27.08.2004, 00:30 +0400 schrieb Dmitry Baryshkov:

> Another example: Can ext2/etx3/reiserfsv3/xfs be implemented as reiser4
> plugins? From Hans' words it seems so. If this is correct, then maybe
> reiser4 core should be updated to completely replace current VFS layer?
> Then it's a good point to create a branch (in old development model it
> would be 2.7, dunno for new :), replace VFS layer with reiser4 core, and
> rewrite all (or at least most used) FS as reiser4 plugins. Then
> everybody will be happy.
>=20
> But this looks too good to be true. Perhaps I misunderstood Hans' words
> aboud 'new disk format', did I?

No. You can change the format the reiser4 storage tree is stored in. As
long as other filesystems don't use the same underlying storage tree
this is not possible.


--=-iRiqRY6UDa+JwpiIC1hF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLko0ZCYBcts5dM0RAifHAJoDtiifngYh4ZiRKhfWPv/yKHeNBACfSpa/
dzAAXkO7oaVv7W4rgMIhrk8=
=h/iE
-----END PGP SIGNATURE-----

--=-iRiqRY6UDa+JwpiIC1hF--

