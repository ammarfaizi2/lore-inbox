Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269353AbUJKXgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269353AbUJKXgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUJKXgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:36:07 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:19721 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S269353AbUJKXfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:35:37 -0400
Subject: Re: 2.6.9-rc4-mm1
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Andrew Morton <akpm@osdl.org>
Cc: Jack Byer <ojbyer@usa.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20041011145838.051c1a9d.akpm@osdl.org>
References: <20041011032502.299dc88d.akpm@osdl.org>
	 <cke3fj$eoh$1@sea.gmane.org>  <20041011145838.051c1a9d.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KgV2HXAauG4pOx89xfqd"
Organization: Linux Networx
Date: Mon, 11 Oct 2004 17:14:44 -0600
Message-Id: <1097536484.29953.41.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KgV2HXAauG4pOx89xfqd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-10-11 at 14:58 -0700, Andrew Morton wrote:
> Please don't remove me from Cc:
>=20
> Jack Byer <ojbyer@usa.net> wrote:
> >
> > When I try to compile this kernel, I get the following error:
> >=20
> >    Using /usr/src/linux-2.6.9-rc4-mm1 as source for kernel
> >    CHK     include/linux/version.h
> > make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
> >    CHK     include/asm-i386/asm_offsets.h
> >    CHK     include/linux/compile.h
> >    GEN_INITRAMFS_LIST usr/initramfs_list
> > Using shipped usr/initramfs_list
> >    CPIO    usr/initramfs_data.cpio
> > ERROR: unable to open 'usr/initramfs_list': No such file or directory
>=20
> You need to create usr/initramfs_list.

Err, there should be a default usr/initramfs_list - was this deleted by
the patch that added the initramfs_list generation script?  It would be
nice to see the V=3D1 output.  There might also be a problem with O=3D<dir>
here so that the default usr/initramfs_list isn't used.

> Thayne, some documentation would be nice.

You are, of course correct.  Where do you suggest that I put the
documentation?  Should I make changes to
Documentation/early-userspace/README?

BTW, I have to make an emergency trip for the rest of the week and I may
not get to this until next week.


--=-KgV2HXAauG4pOx89xfqd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBaxPksYFQl3A+qS0RAn/LAKChOOlsKXKsr+9QHZTgPLdVqkTtRQCeMW/K
ysJhtL/moGPs0oASf510bqA=
=Cfs1
-----END PGP SIGNATURE-----

--=-KgV2HXAauG4pOx89xfqd--

