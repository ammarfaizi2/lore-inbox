Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTKGXnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbTKGWRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:17:20 -0500
Received: from adsl-63-207-60-234.dsl.lsan03.pacbell.net ([63.207.60.234]:38414
	"EHLO obsecurity.dyndns.org") by vger.kernel.org with ESMTP
	id S263903AbTKGGc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 01:32:26 -0500
Date: Thu, 6 Nov 2003 22:32:20 -0800
From: Kris Kennaway <kris@obsecurity.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Kris Kennaway <kris@obsecurity.org>, linux-kernel@vger.kernel.org,
       Jonathan Lennox <lennox@cs.columbia.edu>,
       Dan Nelson <dnelson@allantgroup.com>
Subject: Re: NFS Locking violates protocol spec (incompatible with FreeBSD)
Message-ID: <20031107063220.GA5265@rot13.obsecurity.org>
References: <20031107041051.GA4065@rot13.obsecurity.org> <shsk76c3hvr.fsf@charged.uio.no> <20031107045346.GA4583@rot13.obsecurity.org> <16299.14326.407197.204384@charged.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <16299.14326.407197.204384@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2003 at 01:13:10AM -0500, Trond Myklebust wrote:
> >>>>> " " =3D=3D Kris Kennaway <kris@obsecurity.org> writes:
>=20
>      > Thanks..obviously we'd like a fix to be committed to Linux so
>      > that it interoperates out of the box with FreeBSD.  What are
>      > the chances of this?
>=20
> For the moment I'm still waiting for confirmation that this patch does
> actually fix the problem on both FreeBSD and OSX/Panther. Once that is
> done, it's up to Marcelo to tell me when he wants it into 2.4.x. He
> has already announce that he only wants critical bugfixes in 2.4.23,
> though, so I would guess that we will have to wait for 2.4.24.
>=20
> As for 2.6.x, I expect we will have to wait until the code freeze
> lifts. When it does, I already have a backlog of lockd bugfixes to
> port forward from 2.4.x, so it will make sense to merge it together
> with that.
>=20
> Then we just have to wait for the distributions to catch up ;-)

Thanks.  Unfortunately the Linux server I experience this problem with
is not something I can play with, but I've CC'ed two people who
experience this problem with FreeBSD: perhaps they can test the patch
(http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-pre9/linux-2.4.23-01=
-fix_osx.dif)

Kris

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (FreeBSD)

iD8DBQE/qzx0Wry0BWjoQKURAqyvAJ0SMzNU0ZisMDdS2xAoJ5jFLuxFMwCeJDpZ
zj4bVJ+Y6OPALw1Ew8BiTfY=
=mYsM
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
