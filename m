Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288926AbSANTmZ>; Mon, 14 Jan 2002 14:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288921AbSANTlM>; Mon, 14 Jan 2002 14:41:12 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:6728 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S288952AbSANTkc>; Mon, 14 Jan 2002 14:40:32 -0500
Date: Mon, 14 Jan 2002 20:41:52 +0100
From: Jan-Hendrik Palic <jan.palic@linux-debian.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.2-pre11 with sched01-H7 doesn't build
Message-ID: <20020114194151.GA12487@billgotchy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Internet: http://www.billgotchy.de
gpg-key: http://www.billgotchy.de/bin/m.asc
Fingerprint: D146 9433 E94B DD1E AB41  398B 41C3 45C1 331F FF66
Key-ID: 331FFF66
OS: Linux Debian Unstable
Private-Debian-Site: http://www.linux-debian.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ..=20

I downloeded the linux-2.5.1.tar.bz2 and applied the patch for
linux-2.5.2-pre11 patch and the sched01-H7 patch .. at building I got
this :=20

make[2]: Entering directory
`/home/palic/Files/Projekte/Kernel/PPC/linux-2.5.2-pre11-sched-01H7/kernel'
gcc -D__KERNEL__
-I/home/palic/Files/Projekte/Kernel/PPC/linux-2.5.2-pre11-sched-01H7/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-fno-omit-frame-pointer -c -o sched.o sched.c
sched.c:21: asm/sched.h: No such file or directory
sched.c: In function `context_switch':
sched.c:430: warning: implicit declaration of function `enter_lazy_tlb'
sched.c:432: warning: implicit declaration of function `switch_mm'
sched.c: In function `schedule':
sched.c:785: warning: implicit declaration of function
`sched_find_first_zero_bit'
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory
`/home/palic/Files/Projekte/Kernel/PPC/linux-2.5.2-pre11-sched-01H7/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory
`/home/palic/Files/Projekte/Kernel/PPC/linux-2.5.2-pre11-sched-01H7/kernel'
make: *** [_dir_kernel] Error 2
palic@shaun:~/Files/Projekte/Kernel/PPC/linux$ ls
arch     CREDITS        fs       ipc     MAINTAINERS  mm
REPORTING-BUGS
build    Documentation  include  kernel  Makefile     net     Rules.make
COPYING  drivers        init     lib     Makefile~    README  scripts
palic@shaun:~/Files/Projekte/Kernel/PPC/linux$ cd .
palic@shaun:~/Files/Projekte/Kernel/PPC/linux$ cd ..
palic@shaun:~/Files/Projekte/Kernel/PPC$=20

What's wrong?

	Thnx

		Jan

--=20
One time, you all will be emulated by linux!

----
Jan- Hendrik Palic
Url:"http://www.billgotchy.de"
E-Mail: "palic@billgotchy.de"

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d- s: a-- C++ UL++ P+++ L+++ E W++ N+ o+ K- w---=20
O- M- V- PS++ PE Y+ PGP++ t--- 5- X+++ R-- tv- b++ DI-- D+++=20
G+++ e+++ h+ r++ z+=20
------END GEEK CODE BLOCK------

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8QzR/QcNFwTMf/2YRAQzTAKCPuQMjF3ggwr8Na2ahonxJdTgdEACfdyc3
ap/Drn6AJKuAFD6xf5T8svI=
=Li0L
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
