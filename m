Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265512AbSKAAUW>; Thu, 31 Oct 2002 19:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbSKAAUW>; Thu, 31 Oct 2002 19:20:22 -0500
Received: from dhcp31182033.columbus.rr.com ([24.31.182.33]:30337 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id <S265512AbSKAAUV>; Thu, 31 Oct 2002 19:20:21 -0500
Date: Thu, 31 Oct 2002 19:24:19 -0500
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [BK] 0/11  Ext2/3 Updates: Extended attributes, ACL, etc.
Message-ID: <20021101002419.GA1683@rivenstone.net>
Mail-Followup-To: tytso@mit.edu, linux-kernel@vger.kernel.org
References: <E187Agn-0003b9-00@snap.thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <E187Agn-0003b9-00@snap.thunk.org>
User-Agent: Mutt/1.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2002 at 03:28:29AM -0500, tytso@mit.edu wrote:
> Hi Linus,
>=20
> I've updated the ext2/3 patches for 2.5.45.  All of these changes can
> also be grabbed by pulling from:
>=20
> 	bk://extfs.bkbits.net/extfs-2.5-update
>=20
> Linus, please pull; these patches have been tested as part of Andrew
> Morton's mm tree, and have minimal risks if the relevant config turned
> off.  (People have also been using the ACL and Extended Attributes
> patches enabled for quite some time as well.  :-)
>=20
> A complete set of all of these patches can also be found at:
>=20
>         http://thunk.org/tytso/linux/extfs-2.5
>=20
> 						- Ted



   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do=
_mounts.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel=
/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i=
386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/buil=
t-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  se=
curity/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drive=
rs/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o -=
-end-group  -o vmlinux
fs/built-in.o(.text+0x42d8a): In function `ext3_xattr_put_super':
: undefined reference to `mb_cache_shrink'
fs/built-in.o(.text+0x42dc2): In function `ext3_xattr_cache_insert':
: undefined reference to `mb_cache_entry_alloc'
fs/built-in.o(.text+0x42deb): In function `ext3_xattr_cache_insert':
: undefined reference to `mb_cache_entry_insert'
fs/built-in.o(.text+0x42df9): In function `ext3_xattr_cache_insert':
: undefined reference to `mb_cache_entry_free'
fs/built-in.o(.text+0x42e18): In function `ext3_xattr_cache_insert':
: undefined reference to `mb_cache_entry_release'
fs/built-in.o(.text+0x42f4f): In function `ext3_xattr_cache_find':
: undefined reference to `mb_cache_entry_find_first'
fs/built-in.o(.text+0x42fb7): In function `ext3_xattr_cache_find':
: undefined reference to `mb_cache_entry_find_next'
fs/built-in.o(.text+0x42fe3): In function `ext3_xattr_cache_find':
: undefined reference to `mb_cache_entry_release'
fs/built-in.o(.text+0x4303e): In function `ext3_xattr_cache_remove':
: undefined reference to `mb_cache_entry_get'
fs/built-in.o(.text+0x43134): In function `exit_ext3_xattr':
: undefined reference to `mb_cache_destroy'
fs/built-in.o(.text+0x4304e): In function `ext3_xattr_cache_remove':
: undefined reference to `mb_cache_entry_free'
fs/built-in.o(.init.text+0x1253): In function `init_ext3_xattr':
: undefined reference to `mb_cache_create'
make: *** [vmlinux] Error 1
jhf@caphernaum: linux-2.5.45$


--=20
Joseph Fannin
jhf@rivenstone.net

"For future reference - don't anybody else try to send patches as vi
scripts, please. Yes, it's manly, but let's face it, so is bungee-jumping
with the cord tied to your testicles." -- Linus Torvalds

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9wcmzWv4KsgKfSVgRAiuFAJ0aOhLWoxv27LpojcViMVQ9qh04UACbBpzn
ZkVXntKRXNhsPJ/4FX6y2Bw=
=lgnW
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
