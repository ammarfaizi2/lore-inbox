Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265574AbUFYJbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbUFYJbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 05:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUFYJbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 05:31:13 -0400
Received: from alpha.zarz.agh.edu.pl ([149.156.125.5]:3342 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S265574AbUFYJbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 05:31:07 -0400
Date: Fri, 25 Jun 2004 13:23:47 +0200 (CEST)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com, SPARC Linux kernel list <sparclinux@vger.kernel.org>
Subject: [SPARC64] kernel 2.6.7+cset-20040625_0611 = ERROR
Message-ID: <Pine.LNX.4.58L.0406251320310.6037@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to build this on my machine 

cpu		: TI UltraSparc II  (BlackBird)
fpu		: UltraSparc II integrated FPU
promlib		: Version 3 Revision 12
prom		: 3.12.3
type		: sun4u
ncpus probed	: 4
ncpus active	: 4

and:
make image
[...]
  CC      arch/sparc64/kernel/process.o
In file included from include/linux/byteorder/big_endian.h:11,
                 from include/asm/byteorder.h:48,
                 from include/asm/bitops.h:11,
                 from include/linux/bitops.h:4,
                 from include/linux/thread_info.h:20,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from include/linux/module.h:10,
                 from arch/sparc64/kernel/process.c:16:
include/linux/byteorder/swab.h: In function `__swab16p':
include/linux/byteorder/swab.h:139: warning: passing arg 1 of 
`___arch__swab16p' discards qualifiers from pointer target type
include/linux/byteorder/swab.h: In function `__swab32p':
include/linux/byteorder/swab.h:152: warning: passing arg 1 of 
`___arch__swab32p' discards qualifiers from pointer target type
include/linux/byteorder/swab.h: In function `__swab64p':
include/linux/byteorder/swab.h:172: warning: passing arg 1 of 
`___arch__swab64p' discards qualifiers from pointer target type
In file included from include/linux/sched.h:15,
                 from include/linux/module.h:10,
                 from arch/sparc64/kernel/process.c:16:
include/linux/cpumask.h: In function `__first_cpu':
include/linux/cpumask.h:210: warning: passing arg 1 of `find_next_bit' 
discards qualifiers from pointer target type
include/linux/cpumask.h: In function `__next_cpu':
include/linux/cpumask.h:216: warning: passing arg 1 of `find_next_bit' 
discards qualifiers from pointer target type
make[1]: *** [arch/sparc64/kernel/process.o] Error 1
make: *** [arch/sparc64/kernel] Error 2

-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
