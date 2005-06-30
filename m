Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263120AbVF3XhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbVF3XhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 19:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbVF3XhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 19:37:18 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:28039 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S263120AbVF3XhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 19:37:09 -0400
Date: Fri, 1 Jul 2005 09:36:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: chris@zankel.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: xtensa-cleanups-for-errno-and-ipc.patch added to -mm tree
Message-Id: <20050701093650.5c211b31.sfr@canb.auug.org.au>
In-Reply-To: <200506301308.00186.arnd@arndb.de>
References: <200506300113.j5U1DxLH013112@shell0.pdx.osdl.net>
	<200506301308.00186.arnd@arndb.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__1_Jul_2005_09_36_50_+1000_WmfOjyby0L9hdpv0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__1_Jul_2005_09_36_50_+1000_WmfOjyby0L9hdpv0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jun 2005 13:07:59 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Dunnersdag 30 Juni 2005 03:13, akpm@osdl.org wrote:
>=20
> > From: Chris Zankel <chris@zankel.net>
> >
> > I noticed this because I was doing some more ipc cleanups and I did the
> > original errno and ipc cleanups for other architectures, so it stuck ou=
t.
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Chris Zankel <chris@zankel.net>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
>=20
> Actually, it would be better not to have sys_ipc or include/asm-xtensa/ip=
c.h
> at all but rather have all ipc syscalls as separate entry points.

Absolutely true and I think the patch xtensa-remove-old-syscalls.patch
that is in -mm also gets rid of sys_ipc.  If that is the case, then=20
include/asm-xtensa/ipc.h can, indeed, be completely removed.

> IIRC, parisc is the only architecture to get this right so far, so please
> have a look there.

alpha, x86_64 also has this done.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__1_Jul_2005_09_36_50_+1000_WmfOjyby0L9hdpv0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxIIXFdBgD/zoJvwRAqiuAJ9P65odiVBcIy4XHPlIdJmREClWNACfWyGi
O4uDYz4gf66FVgfFlFn3zZo=
=qz9H
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Jul_2005_09_36_50_+1000_WmfOjyby0L9hdpv0--
