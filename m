Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132054AbRDJXmo>; Tue, 10 Apr 2001 19:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132483AbRDJXmb>; Tue, 10 Apr 2001 19:42:31 -0400
Received: from gso163-27-033.triad.rr.com ([24.163.27.33]:30470 "EHLO
	infinityalliance.2y.net") by vger.kernel.org with ESMTP
	id <S132054AbRDJXmS>; Tue, 10 Apr 2001 19:42:18 -0400
Date: Tue, 10 Apr 2001 19:41:46 -0400
From: Mordrid Nightshade <carbnsack@infinityalliance.2y.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel Compile errors - 2.4.3ac2 through ac4
Message-ID: <20010410194146.A18139@infinityalliance.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
I've been trying to compile 2.4.3ac2 - ac4 and have had the same problem everytime.
It deals with pmac_pic.c (I sent this to Cort <cort@fsmlabs.com> as well)
As I never meddle with kernel source I'm sorta at a loss (hope to change this one day)

Error is as follows:

gcc -D__KERNEL__ -I/usr/src/2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -c -o pmac_pic.o pmac_pic.c
In file included from /usr/src/2.4.3/include/linux/sched.h:9,
from pmac_pic.c:4:
/usr/src/2.4.3/include/linux/binfmts.h:45: warning: `struct mm_struct' declared inside parameter list
/usr/src/2.4.3/include/linux/binfmts.h:45: warning: its scope is only this definition or declaration, which is probably not what you want.
pmac_pic.c:47: parse error before `{'
make[1]: *** [pmac_pic.o] Error 1
make[1]: Leaving directory `/usr/src/2.4.3/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

I appreciate the help

