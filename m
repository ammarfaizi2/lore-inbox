Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318560AbSIKITn>; Wed, 11 Sep 2002 04:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSIKITn>; Wed, 11 Sep 2002 04:19:43 -0400
Received: from mta.sara.nl ([145.100.16.144]:9465 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S318560AbSIKITl>;
	Wed, 11 Sep 2002 04:19:41 -0400
Date: Wed, 11 Sep 2002 10:24:14 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: compile error in recent linuxppc-2.5 tree
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org, paulus@samba.org
Content-Transfer-Encoding: 7bit
Message-Id: <DB4B3636-C55F-11D6-81AC-000393911DE2@sara.nl>
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I rsynced to the linuxppc-2.5 tree just after linus releases 2.5.34. I 
got the following error while compiling:

   gcc -Wp,-MD,./.process.o.d -D__KERNEL__ 
- -I/usr/src/linuxppc-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs 
- -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
- -I/usr/src/linuxppc-2.5/arch/ppc -msoft-float -pipe -ffixed-r2 
- -Wno-uninitialized -mmultiple -mstring -nostdinc -iwithprefix include    
- -DKBUILD_BASENAME=process   -c -o process.o process.c
process.c:60: `INIT_SIGNALS' undeclared here (not in a function)
make[1]: *** [process.o] Error 1
make[1]: Leaving directory `/usr/src/linuxppc-2.5/arch/ppc/kernel'
make: *** [arch/ppc/kernel] Error 2

- ---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (Darwin)

iD8DBQE9fv23BIoCv9yTlOwRAoOAAJ9baQruSM7/6d6MlM4zZ8xQNPRYlACeNCbm
mpRnzoCaHmypJNL+HhELeGA=
=mmfN
-----END PGP SIGNATURE-----

