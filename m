Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265551AbSJSHu2>; Sat, 19 Oct 2002 03:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265552AbSJSHu2>; Sat, 19 Oct 2002 03:50:28 -0400
Received: from mout1.freenet.de ([194.97.50.132]:31429 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S265551AbSJSHu1>;
	Sat, 19 Oct 2002 03:50:27 -0400
Message-ID: <3DB1110A.2050907@athlon.maya.org>
Date: Sat, 19 Oct 2002 10:00:10 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021007
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compile problems with 2.4.20pre kernels
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm not sure, but I think that there are compile problems since the
2.4.20pre-kernels with pcmcia-cs package 3.2.1. I get the following
warnings:

In file included from /usr/src/linux/include/linux/rwsem.h:29,
                  from /usr/src/linux/include/asm/semaphore.h:42,
                  from /usr/src/linux/include/linux/fs.h:200,
                  from /usr/src/linux/include/linux/capability.h:17,
                  from /usr/src/linux/include/linux/binfmts.h:5,
                  from /usr/src/linux/include/linux/sched.h:9,
                  from ../include/linux/sched.h:5,
                  from /usr/src/linux/include/linux/mm.h:4,
                  from /usr/src/linux/include/linux/slab.h:14,
                  from ../include/linux/slab.h:9,
                  from cs.c:41:
/usr/src/linux/include/asm/rwsem.h: In function `__down_write_trylock':
/usr/src/linux/include/asm/rwsem.h:176: warning: implicit declaration of
function `cmpxchg'


In file included from /usr/src/linux/include/linux/wait.h:13,
                  from ../include/linux/wait.h:5,
                  from /usr/src/linux/include/linux/fs.h:12,
                  from /usr/src/linux/include/linux/capability.h:17,
                  from /usr/src/linux/include/linux/binfmts.h:5,
                  from /usr/src/linux/include/linux/sched.h:9,
                  from ../include/linux/sched.h:5,
                  from /usr/src/linux/include/linux/vmalloc.h:4,
                  from ../include/linux/vmalloc.h:7,
                  from /usr/src/linux/include/asm/io.h:47,
                  from ../include/asm/io.h:5,
                  from wvlan_hcfcfg.h:580,
                  from wvlan_hcf.h:101,
                  from wvlan_hcfio.c:121:
../include/linux/kernel.h:10: warning: `EXPORT_SYMTAB' redefined


Is this a problem of the kernel haeders or should the pcmcia-package be
fixed?


Regards,
Andreas Hartmann

