Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318294AbSIBPWk>; Mon, 2 Sep 2002 11:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSIBPWk>; Mon, 2 Sep 2002 11:22:40 -0400
Received: from mta.sara.nl ([145.100.16.144]:23032 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S318294AbSIBPWj>;
	Mon, 2 Sep 2002 11:22:39 -0400
Date: Mon, 2 Sep 2002 17:26:55 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: another compile error 2.5.33
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <69A76D8C-BE88-11D6-9030-000393911DE2@sara.nl>
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

again gcc 2.95.4 binutils 2.13 on powerpc (woody):

   gcc -Wp,-MD,./.irq.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include 
- -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
- -fno-strict-aliasing -fno-common -I/usr/src/linux-2.5.33/arch/ppc 
- -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
- -mmultiple -mstring -nostdinc -iwithprefix include    
- -DKBUILD_BASENAME=irq   -c -o irq.o irq.c
In file included from irq.c:33:
/usr/src/linux-2.5.33/include/linux/ptrace.h:28: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:28: warning: its scope is 
only this definition or declaration, which is probably not what you want.
/usr/src/linux-2.5.33/include/linux/ptrace.h:29: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:30: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:31: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:32: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:33: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:35: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:36: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h:39: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h: In function `ptrace_link':
/usr/src/linux-2.5.33/include/linux/ptrace.h:41: dereferencing pointer 
to incomplete type
/usr/src/linux-2.5.33/include/linux/ptrace.h:42: warning: passing arg 1 
of `__ptrace_link' from incompatible pointer type
/usr/src/linux-2.5.33/include/linux/ptrace.h:42: warning: passing arg 2 
of `__ptrace_link' from incompatible pointer type
/usr/src/linux-2.5.33/include/linux/ptrace.h: At top level:
/usr/src/linux-2.5.33/include/linux/ptrace.h:44: warning: `struct 
task_struct' declared inside parameter list
/usr/src/linux-2.5.33/include/linux/ptrace.h: In function 
`ptrace_unlink':
/usr/src/linux-2.5.33/include/linux/ptrace.h:46: dereferencing pointer 
to incomplete type
/usr/src/linux-2.5.33/include/linux/ptrace.h:47: warning: passing arg 1 
of `__ptrace_unlink' from incompatible pointer type
make[1]: *** [irq.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.33/arch/ppc/kernel'
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

iD8DBQE9c4NKBIoCv9yTlOwRAnqpAKCEWH6Gq+vjSopArALXNF4WeDI8AACeLzyK
k6pcKrvIllqrg7Mk8xFR0Xg=
=69/A
-----END PGP SIGNATURE-----

