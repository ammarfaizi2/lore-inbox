Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318857AbSIIUT3>; Mon, 9 Sep 2002 16:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSIIUT3>; Mon, 9 Sep 2002 16:19:29 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:8145 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S318857AbSIIUT2>; Mon, 9 Sep 2002 16:19:28 -0400
Date: Mon, 9 Sep 2002 13:25:04 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.33 compile-time error with wireless lan support enabled
Message-ID: <Pine.LNX.4.44.0209091318220.16820-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in /usr/src/linux-2.5.33/include/linux/ptrace.h

make[3]: Entering directory `/usr/src/linux-2.5.33/drivers/net/wireless'
   rm -f built-in.o; ar rcs built-in.o
  gcc -Wp,-MD,./.orinoco.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include 
-Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing
 -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc 
-iwithpref
ix include -DMODULE -include 
/usr/src/linux-2.5.33/include/linux/modversions.h  
 -DKBUILD_BASENAME=orinoco -DEXPORT_SYMTAB  -c -o orinoco.o orinoco.c
  gcc -Wp,-MD,./.hermes.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include 
-Wall -
Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc 
-iwithprefi
x include -DMODULE -include 
/usr/src/linux-2.5.33/include/linux/modversions.h   
-DKBUILD_BASENAME=hermes -DEXPORT_SYMTAB  -c -o hermes.o hermes.c
In file included from hermes.c:48:
/usr/src/linux-2.5.33/include/linux/ptrace.h: In function `ptrace_link':
/usr/src/linux-2.5.33/include/linux/ptrace.h:41: dereferencing pointer to 
incomp
lete type
/usr/src/linux-2.5.33/include/linux/ptrace.h: In function `ptrace_unlink':
/usr/src/linux-2.5.33/include/linux/ptrace.h:46: dereferencing pointer to 
incomp
lete type
make[3]: *** [hermes.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.33/drivers/net/wireless'
make[2]: *** [wireless] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.33/drivers/net'
make[1]: *** [net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.33/drivers'
make: *** [drivers] Error 2


-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


