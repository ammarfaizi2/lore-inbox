Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269584AbRHMAB0>; Sun, 12 Aug 2001 20:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269583AbRHMABQ>; Sun, 12 Aug 2001 20:01:16 -0400
Received: from cx552039-a.elcjn1.sdca.home.com ([24.177.44.17]:56743 "EHLO
	tigger.azure-n-jade.foo") by vger.kernel.org with ESMTP
	id <S269551AbRHMABE>; Sun, 12 Aug 2001 20:01:04 -0400
Date: Sun, 12 Aug 2001 17:01:07 -0700 (PDT)
From: Gregory Ade <gkade@bigbrother.net>
X-X-Sender: <gkade@tigger.unnerving.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.8 compile error on sparc
Message-ID: <Pine.LNX.4.31.0108121651250.8416-100000@tigger.unnerving.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello.  Just downloaded linux-2.4.8.tar.bz2 and tried to build it on my
SPARCstation 5 running SuSE Linux 7.1 for sparc.

during the build (started with "make dep && make vmlinux && make
modules"), it dies with the following messages:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.8/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7    -c -o extable.o extable.c
extable.c: In function `search_exception_table':
extable.c:60: `modlist_lock' undeclared (first use in this function)
extable.c:60: (Each undeclared identifier is reported only once
extable.c:60: for each function it appears in.)
make[2]: *** [extable.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.8/arch/sparc/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.8/arch/sparc/mm'
make: *** [_dir_arch/sparc/mm] Error 2

Are there sparc-specific patches that I need to hunt down still?  I was
under the impression everything's been merged.

Checking the versions of my installed software against the versions
required as listed in /usr/src/linux/Documents/Changes, everything seems
up-to-date. I was attempting a fairly all-inclusive build, heavy on the
modules wherever possible, so as to support all my sparcstations with one
build.

Any help is appreciated.

- -- 
+---------------------------------------------------------------------------+
| Gregory K. Ade <gkade@bigbrother.net> | http://bigbrother.net/~gkade      |
+---------------------------------------------------------------------------+
| GnuPG Key Fingerprint: F4FC CC7D 613D BDBF 5365 E3D0 7905 0460 EAF4 844B  |
+---------------------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7dxjJeQUEYOr0hEsRAuPdAJ99C9w+slux5ygWRYyUttqMWIoeSACfZ9oc
fkJxF7OrkRGQQ26z7UuPziY=
=ronf
-----END PGP SIGNATURE-----


