Return-Path: <linux-kernel-owner+w=401wt.eu-S1030381AbWLaRue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWLaRue (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 12:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWLaRue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 12:50:34 -0500
Received: from phlare.wyrms.net ([66.140.245.109]:33572 "EHLO phlare.wyrms.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030381AbWLaRud (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 12:50:33 -0500
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 12:50:33 EST
Subject: compile failure on 2.6.19
From: Robin Cook <rcook@wyrms.net>
To: Linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D87ZhYusDEKtcI0nB17Q"
Date: Sun, 31 Dec 2006 11:25:32 -0600
Message-Id: <1167585932.3730.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D87ZhYusDEKtcI0nB17Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I am getting this error when I try to compile 2.6.19 and 2.6.19.1.=20

I ran make mrproper and make menuconfig then ran make and got the below
error.

  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/i386/Kconfig
  CHK     include/linux/version.h
  UPD     include/linux/version.h
/bin/sh: -c: line 0: syntax error near unexpected token `('
/bin/sh: -c: line 0: `set -e; echo '  CHK
include/linux/utsrelease.h'; mkdir -p include/linux/;     if [ `echo -n
"2.6.19.1 .file null .ident
GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ];
then echo '"2.6.19.1 .file null .ident
GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits" exceeds 64
characters' >&2; exit 1; fi; (echo \#define UTS_RELEASE \"2.6.19.1 .file
null .ident GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits\";) <
include/config/kernel.release > include/linux/utsrelease.h.tmp; if [ -r
include/linux/utsrelease.h ] && cmp -s include/linux/utsrelease.h
include/linux/utsrelease.h.tmp; then rm -f
include/linux/utsrelease.h.tmp; else echo '  UPD
include/linux/utsrelease.h'; mv -f include/linux/utsrelease.h.tmp
include/linux/utsrelease.h; fi'
make: *** [include/linux/utsrelease.h] Error 2


--=-D87ZhYusDEKtcI0nB17Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARZfyjER0KI3mhyXmAQIHCA/+JUHJUpFk5VVq3AF5dz3nc37kufAKl7i5
zH5EnoRIuaTtwzOIiTzJYMXiwJqvIkB2/E6Pdb1BfGWOYD3kGrQJCVHNvMUV1OsA
HVnDMd0a8ynsrGm30zfIr1BUHXCEdcE//Isv7MRwrhdcfDByRBrbfV6IVdee51Qo
eGnrw7qe4Eq8MNtqDqah6+MlgopjUzHyxcSEr6FR7HeNxJTpRXU6p0NDViiCJlnp
QIrdo5Ue04MRQ/yqMuEpQS8XJCi0irqVfQKW/t2l6TF3IOPiBCYyG8BiQ4WPzlOG
v9b1ES79I4W3NNBLs+DRtEdByJL7tXP65lX7ik6Om7ptw84Zy9lDgDmZWpZOOfzi
YtW4MMipPgDAmzA/AX+v0kGpbs9KeosV23ocOLXurpx8PQYGxIy6C854hVr9Mn10
6i3F5+IdivWBpuLs92Kz7P/WS/mbDebJXlbqzDjRNn/m7tJW6KIvvavu0zl3pJS6
B4zHnzcU0Dsbt8dzKi257xGantVYBdVab1mSpAiDS8sIJc7K06zfXQcKkPG7Kntl
TbAwOQ4Du6k1AStPEzcz72Yha79cYh+3W7SJiBf8++YtjhygmHEtXE9NkhsNyawp
rEx2skhlouyoi3rjx5CgfYzeQVXyGDWE6awIIYLXs7ySgStgE25Eje6D8ZISoPVV
HqJZZKhGFPI=
=xApq
-----END PGP SIGNATURE-----

--=-D87ZhYusDEKtcI0nB17Q--

