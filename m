Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbRGPSPt>; Mon, 16 Jul 2001 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267531AbRGPSPj>; Mon, 16 Jul 2001 14:15:39 -0400
Received: from mail3.dow.com ([204.136.184.21]:3596 "EHLO txnte27.nam.dow.com")
	by vger.kernel.org with ESMTP id <S267530AbRGPSPW>;
	Mon, 16 Jul 2001 14:15:22 -0400
Message-ID: <911A53117F96D31184500000F8BDCA870A320BE8@TXNTE21>
From: "Peredo, Dee" <dperedo@dow.com>
To: linux-kernel@vger.kernel.org
Subject: Compile Errors
Date: Mon, 16 Jul 2001 13:14:40 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to compile on a Dual Pentium Pro machines.  The make dep
runs fine but when I run the make I am getting the following errors:  I have
been working on this for two days now and have run out of options.  I have
checked all of the supporting tools and made sure they are up to date.

The errors are:

make[2]: Entering directory `/usr/src/linux-2.4.6/fs'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.6/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-march=i686    -c -o open.o open.c
open.c: In function `sys_truncate':
open.c:149: internal error--insn does not satisfy its constraints:
(insn 275 248 276 (set (cc0)
        (compare (mem:DI (plus:SI (reg:SI 7 %esp)
                    (const_int 20)))
            (reg/v:DI 5 %edi))) 14 {cmpdi_1} (insn_list 134 (nil))
    (nil))
toplev.c:1438: Internal compiler error in function fatal_insn
cpp: output pipe has been closed
make[2]: *** [open.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.6/fs'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.6/fs'
make: *** [_dir_fs] Error 2
[u370471@bashful linux]# 


Dee Dickerson
System Administrator
The Dow Chemical Company
> *  979-238-4449
> *     979-238-0244
> *    dperedo@dow.com
> 
"If it's not running UNIX it's just a toy"



