Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271418AbTHHQPk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTHHQPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:15:39 -0400
Received: from dhcp17.kph.uni-mainz.de ([134.93.135.217]:33951 "EHLO
	acucb1.irb.hr") by vger.kernel.org with ESMTP id S271418AbTHHQPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:15:37 -0400
Subject: PROBLEM: Compile Break 2.6.0-test2: More Broken Stuff
From: Michael Joy <mdj00b@acu.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060359336.12160.7.camel@acucb1.irb.hr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 08 Aug 2003 18:15:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More Broken Stuff

[7.] Environment
Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.2.2/specs
Configured with: ../configure --prefix=/usr --libdir=/usr/lib
--with-slibdir=/lib --mandir=/usr/share/man --infodir=/usr/share/info
--enable-shared --enable-threads=posix --disable-checking
--enable-long-long --enable-__cxa_atexit
--enable-languages=c,c++,ada,f77,objc,java
--host=i586-mandrake-linux-gnu --with-system-zlib
Thread model: posix
gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)


make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC [M]  drivers/net/wan/sdlamain.o
drivers/net/wan/sdlamain.c:221: warning: type defaults to `int' in
declaration of `DECLARE_TASK_QUEUE'
drivers/net/wan/sdlamain.c:221: warning: parameter names (without types)
in function declaration
drivers/net/wan/sdlamain.c:221: warning: data definition has no type or
storage class
drivers/net/wan/sdlamain.c:222: variable `wanpipe_tq_task' has
initializer but incomplete type
drivers/net/wan/sdlamain.c:224: unknown field `routine' specified in
initializer
drivers/net/wan/sdlamain.c:224: warning: excess elements in struct
initializer
drivers/net/wan/sdlamain.c:224: warning: (near initialization for
`wanpipe_tq_task')
drivers/net/wan/sdlamain.c:225: unknown field `data' specified in
initializer
drivers/net/wan/sdlamain.c:226: `wanpipe_tq_custom' undeclared here (not
in a function)
drivers/net/wan/sdlamain.c:226: warning: excess elements in struct
initializer
drivers/net/wan/sdlamain.c:226: warning: (near initialization for
`wanpipe_tq_task')
drivers/net/wan/sdlamain.c: In function `check_s508_conflicts':
drivers/net/wan/sdlamain.c:678: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:117)
drivers/net/wan/sdlamain.c: In function `sdla_isr':
drivers/net/wan/sdlamain.c:1032: warning: unused variable `handled'
drivers/net/wan/sdlamain.c: In function `wanpipe_open':
drivers/net/wan/sdlamain.c:1161: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:482)
drivers/net/wan/sdlamain.c: In function `wanpipe_close':
drivers/net/wan/sdlamain.c:1173: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:494)
drivers/net/wan/sdlamain.c: In function `run_wanpipe_tq':
drivers/net/wan/sdlamain.c:1224: `task_queue' undeclared (first use in
this function)
drivers/net/wan/sdlamain.c:1224: (Each undeclared identifier is reported
only once
drivers/net/wan/sdlamain.c:1224: for each function it appears in.)
drivers/net/wan/sdlamain.c:1224: `tq_queue' undeclared (first use in
this function)
drivers/net/wan/sdlamain.c:1224: parse error before ')' token
drivers/net/wan/sdlamain.c:1227: warning: implicit declaration of
function `run_task_queue'
drivers/net/wan/sdlamain.c: In function `wanpipe_queue_tq':
drivers/net/wan/sdlamain.c:1237: warning: implicit declaration of
function `queue_task'
drivers/net/wan/sdlamain.c:1237: `wanpipe_tq_custom' undeclared (first
use in this function)
drivers/net/wan/sdlamain.c: In function `wanpipe_mark_bh':
drivers/net/wan/sdlamain.c:1244: `tq_immediate' undeclared (first use in
this function)
drivers/net/wan/sdlamain.c:1245: warning: implicit declaration of
function `mark_bh'
drivers/net/wan/sdlamain.c:1245: `IMMEDIATE_BH' undeclared (first use in
this function)
drivers/net/wan/sdlamain.c: At top level:
drivers/net/wan/sdlamain.c:222: storage size of `wanpipe_tq_task' isn't
known
make[3]: *** [drivers/net/wan/sdlamain.o] Error 1
make[2]: *** [drivers/net/wan] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

