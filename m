Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSKNQbm>; Thu, 14 Nov 2002 11:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSKNQbm>; Thu, 14 Nov 2002 11:31:42 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:23373 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S264956AbSKNQbj>;
	Thu, 14 Nov 2002 11:31:39 -0500
Subject: "Intermezzo" Compile Error
From: Adam Voigt <adam@cryptocomm.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Acn4rlRUdjHJJ6BMImt4"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Nov 2002 11:38:30 -0500
Message-Id: <1037291911.5549.4.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 14 Nov 2002 16:38:30.0451 (UTC) FILETIME=[43C09830:01C28BFC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Acn4rlRUdjHJJ6BMImt4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was trying to compile just a straight default Kernel so I could
get it up quick and try something. So, I downloaded 2.5.47, untar'd
it, and did "make xconfig", turned on NTFS support, but other then that
left everything default, hit save, did "make dep", no problems, did
"make" and I get the following after a while:

gcc -Wp,-MD,fs/intermezzo/.cache.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
-march=3Di686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DMODULE -include include/linux/modversions.h =20
-DKBUILD_BASENAME=3Dcache   -c -o fs/intermezzo/cache.o
fs/intermezzo/cache.c
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h:30:34: linux/intermezzo_lib.h: No such
file or directory
include/linux/intermezzo_fs.h:31:34: linux/intermezzo_idl.h: No such
file or directory
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h:49: field `remote_version' has incomplete
type
include/linux/intermezzo_fs.h:52: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:52: warning: its scope is only this
definition or
declaration, which is probably not what you want
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h:399: field `fd_version' has incomplete
type
include/linux/intermezzo_fs.h:645: warning: `struct izo_rcvd_rec'
declared inside parameter list
include/linux/intermezzo_fs.h:648: warning: `struct izo_upcall_hdr'
declared inside parameter list
include/linux/intermezzo_fs.h:652: warning: `struct izo_rcvd_rec'
declared inside parameter list
include/linux/intermezzo_fs.h:654: warning: `struct izo_rcvd_rec'
declared inside parameter list
include/linux/intermezzo_fs.h:655: warning: `struct izo_rcvd_rec'
declared inside parameter list
include/linux/intermezzo_fs.h: In function `izo_ioctl_getdata':
include/linux/intermezzo_fs.h:727: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:733: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:733: `IZO_IOCTL_VERSION' undeclared (first
use in
this function)
include/linux/intermezzo_fs.h:733: (Each undeclared identifier is
reported only
once
include/linux/intermezzo_fs.h:733: for each function it appears in.)
include/linux/intermezzo_fs.h:738: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:743: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:743: sizeof applied to an incomplete type
include/linux/intermezzo_fs.h:748: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:754: warning: passing arg 1 of
`izo_ioctl_is_invalid' from incompatible pointer type
include/linux/intermezzo_fs.h:759: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:760: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:760: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:763: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:764: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:764: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:765: warning: implicit declaration of
function `size_round'
include/linux/intermezzo_fs.h:765: dereferencing pointer to incomplete
type
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h: At top level:
include/linux/intermezzo_fs.h:777: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:778: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:779: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:862: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h: In function `izo_ioctl_packlen':
include/linux/intermezzo_fs.h:864: sizeof applied to an incomplete type
include/linux/intermezzo_fs.h:865: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:866: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h: At top level:
include/linux/intermezzo_fs.h:870: warning: `struct izo_ioctl_data'
declared inside parameter list
include/linux/intermezzo_fs.h:871: conflicting types for
`izo_ioctl_is_invalid'
include/linux/intermezzo_fs.h:52: previous declaration of
`izo_ioctl_is_invalid'include/linux/intermezzo_fs.h: In function
`izo_ioctl_is_invalid':
include/linux/intermezzo_fs.h:872: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:876: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:880: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:884: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:884: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:888: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:888: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:892: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:892: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:896: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:896: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:900: warning: passing arg 1 of
`izo_ioctl_packlen' from incompatible pointer type
include/linux/intermezzo_fs.h:900: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:904: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:905: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:905: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:909: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:910: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:910: dereferencing pointer to incomplete
type
include/linux/intermezzo_fs.h:910: dereferencing pointer to incomplete
type
In file included from fs/intermezzo/cache.c:42:
include/linux/intermezzo_fs.h: At top level:
include/linux/intermezzo_fs.h:919: warning: `struct kml_rec' declared
inside parameter list
include/linux/intermezzo_fs.h:920: warning: `struct kml_rec' declared
inside parameter list
make[2]: *** [fs/intermezzo/cache.o] Error 1
make[1]: *** [fs/intermezzo] Error 2
make: *** [fs] Error 2

--=20
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

--=-Acn4rlRUdjHJJ6BMImt4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA909GGF9k9BmZXCWYRAkVuAJsHicFovjwmD2UUemUa5Owvi0ZLYQCfRXe5
LUiSEvRXMiNgOL2wLWw/bQs=
=mew0
-----END PGP SIGNATURE-----

--=-Acn4rlRUdjHJJ6BMImt4--

