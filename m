Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbUDMNLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 09:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUDMNLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 09:11:37 -0400
Received: from web60608.mail.yahoo.com ([216.109.119.82]:37209 "HELO
	web60608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263165AbUDMNL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 09:11:27 -0400
Message-ID: <20040413131124.26121.qmail@web60608.mail.yahoo.com>
Date: Tue, 13 Apr 2004 06:11:24 -0700 (PDT)
From: Ravi Kumar Munnangi <munnangi_ivar@yahoo.com>
Subject: linux-2.2.17 compilation error
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-644971758-1081861884=:23918"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-644971758-1081861884=:23918
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi Users,
  
  I have RedHat Linux-8.0(2.4.18-14).
  Now for some reasons I want to have 2.2.17 also.
  
  But I faced the following errors after make bzImage 

  during compilation.
  Iam sending the error in error.txt as attachment.
  Please look into that and suggest me the correction.

Thanks,
ravikumar


	
		
__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
--0-644971758-1081861884=:23918
Content-Type: text/plain; name="error.txt"
Content-Description: error.txt
Content-Disposition: inline; filename="error.txt"


ot@visionpc2 linux-2.2.17]# make bzImage
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/split-include
scripts/split-include.c
scripts/split-include include/linux/autoconf.h include/config
cc -D__KERNEL__ -I/usr/src/linux-2.2.17/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m386 -DCPU=386  -c -o init/main.o init/main.c
`-m386' is deprecated. Use `-march=i386' or `-mcpu=i386' instead.
In file included from /usr/src/linux-2.2.17/include/linux/string.h:37,
                 from /usr/src/linux-2.2.17/include/linux/signal.h:64,
                 from /usr/src/linux-2.2.17/include/linux/sched.h:23,
                 from /usr/src/linux-2.2.17/include/linux/mm.h:4,
                 from /usr/src/linux-2.2.17/include/linux/slab.h:14,
                 from /usr/src/linux-2.2.17/include/linux/malloc.h:4,
                 from /usr/src/linux-2.2.17/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.2.17/include/asm/string.h:476:17: warning: multi-line string literals are deprecated
In file included from /usr/src/linux-2.2.17/include/linux/sched.h:23,
                 from /usr/src/linux-2.2.17/include/linux/mm.h:4,
                 from /usr/src/linux-2.2.17/include/linux/slab.h:14,
                 from /usr/src/linux-2.2.17/include/linux/malloc.h:4,
                 from /usr/src/linux-2.2.17/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.2.17/include/linux/signal.h: In function `siginitset':
/usr/src/linux-2.2.17/include/linux/signal.h:193: warning: deprecated use of label at end of compound statement
/usr/src/linux-2.2.17/include/linux/signal.h: In function `siginitsetinv':
/usr/src/linux-2.2.17/include/linux/signal.h:205: warning: deprecated use of label at end of compound statement
In file included from /usr/src/linux-2.2.17/include/linux/blkdev.h:6,
                 from /usr/src/linux-2.2.17/include/linux/blk.h:4,
                 from init/main.c:23:
/usr/src/linux-2.2.17/include/linux/genhd.h: In function `ptype':
/usr/src/linux-2.2.17/include/linux/genhd.h:83: warning: deprecated use of label at end of compound statement
cc -D__KERNEL__ -I/usr/src/linux-2.2.17/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m386 -DCPU=386 -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
`-m386' is deprecated. Use `-march=i386' or `-mcpu=i386' instead.
make -C  kernel
make[1]: Entering directory `/usr/src/linux-2.2.17/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.2.17/kernel'
cc -D__KERNEL__ -I/usr/src/linux-2.2.17/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m386 -DCPU=386   -DEXPORT_SYMTAB -c signal.c
`-m386' is deprecated. Use `-march=i386' or `-mcpu=i386' instead.
In file included from /usr/src/linux-2.2.17/include/linux/string.h:37,
                 from /usr/src/linux-2.2.17/include/linux/signal.h:64,
                 from /usr/src/linux-2.2.17/include/linux/sched.h:23,
                 from /usr/src/linux-2.2.17/include/linux/mm.h:4,
                 from /usr/src/linux-2.2.17/include/linux/slab.h:14,
                 from signal.c:9:
/usr/src/linux-2.2.17/include/asm/string.h:476:17: warning: multi-line string literals are deprecated
In file included from /usr/src/linux-2.2.17/include/linux/sched.h:23,
                 from /usr/src/linux-2.2.17/include/linux/mm.h:4,
                 from /usr/src/linux-2.2.17/include/linux/slab.h:14,
                 from signal.c:9:
/usr/src/linux-2.2.17/include/linux/signal.h: In function `siginitset':
/usr/src/linux-2.2.17/include/linux/signal.h:193: warning: deprecated use of label at end of compound statement
/usr/src/linux-2.2.17/include/linux/signal.h: In function `siginitsetinv':
/usr/src/linux-2.2.17/include/linux/signal.h:205: warning: deprecated use of label at end of compound statement
cc -D__KERNEL__ -I/usr/src/linux-2.2.17/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m386 -DCPU=386   -DEXPORT_SYMTAB -c ksyms.c
`-m386' is deprecated. Use `-march=i386' or `-mcpu=i386' instead.
In file included from /usr/src/linux-2.2.17/include/linux/string.h:37,
                 from /usr/src/linux-2.2.17/include/linux/signal.h:64,
                 from /usr/src/linux-2.2.17/include/linux/sched.h:23,
                 from /usr/src/linux-2.2.17/include/linux/mm.h:4,
                 from /usr/src/linux-2.2.17/include/linux/slab.h:14,
                 from /usr/src/linux-2.2.17/include/linux/malloc.h:4,
                 from ksyms.c:13:
/usr/src/linux-2.2.17/include/asm/string.h:476:17: warning: multi-line string literals are deprecated
In file included from /usr/src/linux-2.2.17/include/linux/sched.h:23,
                 from /usr/src/linux-2.2.17/include/linux/mm.h:4,
                 from /usr/src/linux-2.2.17/include/linux/slab.h:14,
                 from /usr/src/linux-2.2.17/include/linux/malloc.h:4,
                 from ksyms.c:13:
/usr/src/linux-2.2.17/include/linux/signal.h: In function `siginitset':
/usr/src/linux-2.2.17/include/linux/signal.h:193: warning: deprecated use of label at end of compound statement
/usr/src/linux-2.2.17/include/linux/signal.h: In function `siginitsetinv':
/usr/src/linux-2.2.17/include/linux/signal.h:205: warning: deprecated use of label at end of compound statement
In file included from /usr/src/linux-2.2.17/include/linux/blkdev.h:6,
                 from ksyms.c:15:
/usr/src/linux-2.2.17/include/linux/genhd.h: In function `ptype':
/usr/src/linux-2.2.17/include/linux/genhd.h:83: warning: deprecated use of label at end of compound statement
cc -D__KERNEL__ -I/usr/src/linux-2.2.17/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m386 -DCPU=386   -fno-omit-frame-pointer -c -o sched.o sched.c
`-m386' is deprecated. Use `-march=i386' or `-mcpu=i386' instead.
In file included from /usr/src/linux-2.2.17/include/linux/string.h:37,
                 from /usr/src/linux-2.2.17/include/linux/signal.h:64,
                 from /usr/src/linux-2.2.17/include/linux/sched.h:23,
                 from /usr/src/linux-2.2.17/include/linux/mm.h:4,
                 from sched.c:27:
/usr/src/linux-2.2.17/include/asm/string.h:476:17: warning: multi-line string literals are deprecated
In file included from /usr/src/linux-2.2.17/include/linux/sched.h:23,
                 from /usr/src/linux-2.2.17/include/linux/mm.h:4,
                 from sched.c:27:
/usr/src/linux-2.2.17/include/linux/signal.h: In function `siginitset':
/usr/src/linux-2.2.17/include/linux/signal.h:193: warning: deprecated use of label at end of compound statement
/usr/src/linux-2.2.17/include/linux/signal.h: In function `siginitsetinv':
/usr/src/linux-2.2.17/include/linux/signal.h:205: warning: deprecated use of label at end of compound statement
sched.c: At top level:
sched.c:52: conflicting types for `xtime'
/usr/src/linux-2.2.17/include/linux/sched.h:479: previous declaration of `xtime'sched.c: In function `schedule':
sched.c:738: warning: deprecated use of label at end of compound statement
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.2.17/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.2.17/kernel'
make: *** [_dir_kernel] Error 2
[root@visionpc2 linux-2.2.17]#


--0-644971758-1081861884=:23918--
