Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269829AbRHSBWy>; Sat, 18 Aug 2001 21:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269811AbRHSBWp>; Sat, 18 Aug 2001 21:22:45 -0400
Received: from jupter.networx.com.br ([200.187.100.102]:48772 "EHLO
	jupter.networx.com.br") by vger.kernel.org with ESMTP
	id <S269824AbRHSBW3>; Sat, 18 Aug 2001 21:22:29 -0400
Message-Id: <200108190120.f7J1KNn10926@jupter.networx.com.br>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Thiago Vinhas de Moraes <tvlists@networx.com.br>
To: seawolf-list@redhat.com, linux-kernel@vger.kernel.org
Subject: VMWare Modules Error on Kernel 2.4.8
Date: Sat, 18 Aug 2001 22:15:02 -0300
X-Mailer: KMail [version 1.3]
Organization: NetWorx - A SuaCompanhia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I'm trying to compile VMWare Express 2.0.4 (latest build) modules so I can 
run Windows on my redhat 7.1 box, but I got the following errors:

make: Entrando no diretório `/tmp/vmware-config4/vmmon-only'
make[1]: Entrando no diretório `/tmp/vmware-config4/vmmon-only'
make[2]: Entrando no diretório `/tmp/vmware-config4/vmmon-only/driver-2.4.8'
In file included from .././linux/driver.c:22:
/lib/modules/2.4.8/build/include/linux/malloc.h:3:2: warning: #warning The 
Use of linux/malloc.h is deprecated, use linux/
slab.h
In file included from .././linux/hostif.c:25:
/lib/modules/2.4.8/build/include/linux/malloc.h:3:2: warning: #warning The 
Use of linux/malloc.h is deprecated, use linux/
slab.h
make[2]: Saindo do diretório `/tmp/vmware-config4/vmmon-only/driver-2.4.8'
make[2]: Entrando no diretório `/tmp/vmware-config4/vmmon-only/driver-2.4.8'
In file included from .././linux/driver.c:22:
/lib/modules/2.4.8/build/include/linux/malloc.h:3:2: warning: #warning The 
Use of linux/malloc.h is deprecated, use linux/
slab.h
In file included from /lib/modules/2.4.8/build/include/linux/highmem.h:5,
                 from /lib/modules/2.4.8/build/include/linux/pagemap.h:16,
                 from /lib/modules/2.4.8/build/include/linux/locks.h:8,
                 from 
/lib/modules/2.4.8/build/include/linux/devfs_fs_kernel.h:6,
                 from /lib/modules/2.4.8/build/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/lib/modules/2.4.8/build/include/asm/pgalloc.h: In function `get_pgd_slow':
/lib/modules/2.4.8/build/include/asm/pgalloc.h:62: `PAGE_OFFSET' undeclared 
(first use in this function)
/lib/modules/2.4.8/build/include/asm/pgalloc.h:62: (Each undeclared 
identifier is reported only once
/lib/modules/2.4.8/build/include/asm/pgalloc.h:62: for each function it 
appears in.)
/lib/modules/2.4.8/build/include/asm/pgalloc.h: In function `pte_alloc_one':
/lib/modules/2.4.8/build/include/asm/pgalloc.h:109: `PAGE_SIZE' undeclared 
(first use in this function)
In file included from /lib/modules/2.4.8/build/include/linux/pagemap.h:16,
                 from /lib/modules/2.4.8/build/include/linux/locks.h:8,
                 from 
/lib/modules/2.4.8/build/include/linux/devfs_fs_kernel.h:6,
                 from /lib/modules/2.4.8/build/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/lib/modules/2.4.8/build/include/linux/highmem.h: In function 
`clear_user_highpage':
/lib/modules/2.4.8/build/include/linux/highmem.h:48: `PAGE_SIZE' undeclared 
(first use in this function)
/lib/modules/2.4.8/build/include/linux/highmem.h: In function 
`clear_highpage':
/lib/modules/2.4.8/build/include/linux/highmem.h:54: `PAGE_SIZE' undeclared 
(first use in this function)
/lib/modules/2.4.8/build/include/linux/highmem.h: In function 
`memclear_highpage':
/lib/modules/2.4.8/build/include/linux/highmem.h:62: `PAGE_SIZE' undeclared 
(first use in this function)
/lib/modules/2.4.8/build/include/linux/highmem.h: In function 
`memclear_highpage_flush':
/lib/modules/2.4.8/build/include/linux/highmem.h:76: `PAGE_SIZE' undeclared 
(first use in this function)
/lib/modules/2.4.8/build/include/linux/highmem.h: In function 
`copy_user_highpage':
/lib/modules/2.4.8/build/include/linux/highmem.h:90: `PAGE_SIZE' undeclared 
(first use in this function)
/lib/modules/2.4.8/build/include/linux/highmem.h: In function `copy_highpage':
/lib/modules/2.4.8/build/include/linux/highmem.h:101: `PAGE_SIZE' undeclared 
(first use in this function)
.././linux/driver.c: In function `LinuxDriver_Ioctl':
.././linux/driver.c:928: structure has no member named `dumpable'
make[2]: ** [driver.o] Erro 1
make[2]: Saindo do diretório `/tmp/vmware-config4/vmmon-only/driver-2.4.8'
make[1]: ** [driver] Erro 2
make[1]: Saindo do diretório `/tmp/vmware-config4/vmmon-only'
make: ** [auto-build] Erro 2
make: Saindo do diretório `/tmp/vmware-config4/vmmon-only'
Unable to build the vmmon module.
 
For more information on how to troubleshoot module-related problems, please 
have
a look at "http://www.vmware.com/download/modules/modules.html".
 
Execution aborted.


I'm sure it's not a GCC problem. Does anyone have a patch to fix this, or any 
tip? I tried to run the binary module, but it prints out a lot of unresolved 
symbols.

Any help will be apreciated.

Regards,
Thiago

