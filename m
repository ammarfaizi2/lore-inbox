Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVAVNSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVAVNSF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 08:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVAVNSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 08:18:05 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:2240 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262714AbVAVNRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 08:17:47 -0500
Message-ID: <41F25279.4040307@tiscali.de>
Date: Sat, 22 Jan 2005 14:17:45 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: nvidia driver and Kernel 2.6.11-rc2: compilation error
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
If I try to compile the nvidia driver (version: 6629) module I get this:

NVIDIA: calling KBUILD...
   make CC=cc  KBUILD_VERBOSE=1 -C /lib/modules/2.6.11-rc2-ott/build 
SUBDIRS=/t
   mp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv modules
   mkdir -p 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/.tmp_vers
   ions
   make -f scripts/Makefile.build 
obj=/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629
   -pkg1/usr/src/nv
   echo \#define NV_COMPILER \"`cc -v 2>&1 | tail -n 1`\" > 
/tmp/selfgz7663/NVI
   DIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv_compiler.h
     cc 
-Wp,-MD,/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/.nv.o
   .d -nostdinc -isystem /usr/lib/gcc/i686-pc-linux-gnu/3.4.3/include 
-D__KERNE
   L__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs 
-fno-strict-aliasing
   -fno-common -ffreestanding -O2     -fomit-frame-pointer -pipe 
-msoft-float -
   mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i686 
-mtune=pentium4
   -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement  
-I/tmp/selfgz
   7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv -Wall -Wimplicit 
-Wreturn-typ
   e -Wswitch -Wformat
   -Wchar-subscripts -Wparentheses -Wpointer-arith  -Wno-multichar  
-Werror -O
   -fno-common -MD   -Wno-cast-qual -Wno-error -D_LOOSE_KERNEL_NAMES 
-D__KERNEL
   __ -DMODULE  -DNTRM -D_GNU_SOURCE -D_LOOSE_KERNEL_NAMES -D__KERNEL__ 
-DMODUL
   E  -DNV_MAJOR_VERSION=1 -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=6629  
-DNV_UNIX
     -DNV_LINUX   -DNV_INT64_OK   -DNVCPU_X86      -UDEBUG -U_DEBUG 
-DNDEBUG -D
   NV_REMAP_PFN_RANGE_PRESENT -DNV_CHANGE_PAGE_ATTR_PRESENT 
-DNV_PCI_DISABLE_DE
   VICE_PRESENT -DNV_CLASS_SIMPLE_CREATE_PRESENT 
-DNV_PCI_GET_CLASS_PRESENT  -D
   MODULE -DKBUILD_BASENAME=nv -DKBUILD_MODNAME=nvidia -c -o 
/tmp/selfgz7663/NV
   IDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/.tmp_nv.o 
/tmp/selfgz7663/NVIDIA-Lin
   ux-x86-1.0-6629-pkg1/usr/src/nv/nv.c
   In file included from include/linux/list.h:7,
                    from include/linux/wait.h:23,
                    from include/asm/semaphore.h:41,
                    from include/linux/sched.h:19,
                    from include/linux/module.h:10,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv-linux.h:52,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv.c:14:
   include/linux/prefetch.h: In function `prefetch_range':
   include/linux/prefetch.h:62: warning: pointer of type `void *' used 
in arith
   metic
   In file included from include/linux/dmapool.h:14,
                    from include/linux/pci.h:863,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv-linux.h:75,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv.c:14:
   include/asm/io.h: In function `check_signature':
   include/asm/io.h:242: warning: wrong type argument to increment
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv.c: In 
function
   `_get_phys_address':
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv.c:2509: 
warning
   : passing arg 1 of `pmd_offset' from incompatible pointer type
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv.c: In 
function
   `nv_agp_init':
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv.c:2992: 
warning
   : `inter_module_put' is deprecated (declared at 
include/linux/module.h:578)
     cc 
-Wp,-MD,/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/.nv-v
   m.o.d -nostdinc -isystem /usr/lib/gcc/i686-pc-linux-gnu/3.4.3/include 
-D__KE
   RNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs 
-fno-strict-alias
   ing -fno-common -ffreestanding -O2     -fomit-frame-pointer -pipe 
-msoft-flo
   at -mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i686 
-mtune=penti
   um4 -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement  
-I/tmp/se
   lfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv -Wall -Wimplicit 
-Wreturn
   -type -Wswitch -Wformat -Wchar-subscripts -Wparentheses 
-Wpointer-arith  -Wn
   o-multichar  -Werror -O -fno-common -MD   -Wno-cast-qual -Wno-error 
-D_LOOSE
   _KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNTRM -D_GNU_SOURCE 
-D_LOOSE_KERNEL_NA
   MES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1 -DNV_MINOR_VERSION=0 
-DNV_PA
   TCHLEVEL=6629  -DNV_UNIX   -DNV_LINUX   -DNV_INT64_OK   
-DNVCPU_X86      -UD
   EBU
   G -U_DEBUG -DNDEBUG -DNV_REMAP_PFN_RANGE_PRESENT 
-DNV_CHANGE_PAGE_ATTR_PRESE
   NT -DNV_PCI_DISABLE_DEVICE_PRESENT -DNV_CLASS_SIMPLE_CREATE_PRESENT 
-DNV_PCI
   _GET_CLASS_PRESENT  -DMODULE -DKBUILD_BASENAME=nv_vm 
-DKBUILD_MODNAME=nvidia
   -c -o 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/.tmp_nv-vm.o
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv-vm.c
   In file included from include/linux/list.h:7,
                    from include/linux/wait.h:23,
                    from include/asm/semaphore.h:41,
                    from include/linux/sched.h:19,
                    from include/linux/module.h:10,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv-linux.h:52,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv-vm.c:14:
   include/linux/prefetch.h: In function `prefetch_range':
   include/linux/prefetch.h:62: warning: pointer of type `void *' used 
in arith
   metic
   In file included from include/linux/dmapool.h:14,
                    from include/linux/pci.h:863,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv-linux.h:75,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv-vm.c:14:
   include/asm/io.h: In function `check_signature':
   include/asm/io.h:242: warning: wrong type argument to increment
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv-vm.c: At 
top le
   vel:
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/nv-vm.c:59: 
warnin
   g: 'cache_flush' defined but not used
     cc 
-Wp,-MD,/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/.os-a
   gp.o.d -nostdinc -isystem 
/usr/lib/gcc/i686-pc-linux-gnu/3.4.3/include -D__K
   ERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs 
-fno-strict-alia
   sing -fno-common -ffreestanding -O2     -fomit-frame-pointer -pipe 
-msoft-fl
   oat -mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=i686 
-mtune=pent
   ium4 -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement  
-I/tmp/s
   elfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv -Wall -Wimp
   licit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts -Wparentheses 
-Wpoin
   ter-arith  -Wno-multichar  -Werror -O -fno-common -MD   
-Wno-cast-qual -Wno-
   error -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNTRM 
-D_GNU_SOURCE -D_L
   OOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1 
-DNV_MINOR_VER
   SION=0 -DNV_PATCHLEVEL=6629  -DNV_UNIX   -DNV_LINUX   -DNV_INT64_OK   
-DNVCP
   U_X86      -UDEBUG -U_DEBUG -DNDEBUG -DNV_REMAP_PFN_RANGE_PRESENT 
-DNV_CHANG
   E_PAGE_ATTR_PRESENT -DNV_PCI_DISABLE_DEVICE_PRESENT 
-DNV_CLASS_SIMPLE_CREATE
   _PRESENT -DNV_PCI_GET_CLASS_PRESENT  -DMODULE 
-DKBUILD_BASENAME=os_agp -DKBU
   ILD_MODNAME=nvidia -c -o 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/
   src/nv/.tmp_os-agp.o 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/
   nv/os-agp.c
   In file included from include/linux/list.h:7,
                    from include/linux/wait.h:23,
                    from include/asm/semaphore.h:41,
                    from include/linux/sched.h:19,
                    from include/linux/module.h:10,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv-linux.h:52,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/os-agp.c:24:
   include/linux/prefetch.h: In function `prefetch_range':
   include/linux/prefetch.h:62: warning: pointer of type `void *' used 
in arith
   metic
   In file included from include/linux/dmapool.h:14,
                    from include/linux/pci.h:863,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/nv-linux.h:75,
                    from 
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv/os-agp.c:24:
   include/asm/io.h: In function `check_signature':
   include/asm/io.h:242: warning: wrong type argument to increment
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c: 
At top l
   evel:
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:48: error
   : parse error before '*' token
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:48: warni
   ng: type defaults to `int' in declaration of `drm_agp_p'
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:48: warni
   ng: data definition has no type or storage class
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c: 
In funct
   ion `KernInitAGP':
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:76: warni
   ng: assignment discards qualifiers from pointer target type
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:85: error
   : request for member `acquire' in something not a structure or union
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:88: warni
   ng: `inter_module_put' is deprecated (declared at 
include/linux/module.h:578
   )
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:113: erro
   r: request for member `copy_info' in something not a structure or union
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:173: erro
   r: request for member `enable' in something not a structure or union
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:185: erro
   r: request for member `release' in something not a structure or union
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:186: warn
   ing: `inter_module_put' is deprecated (declared at 
include/linux/module.h:57
   8)
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c: 
In funct
   ion `KernTeardownAGP':
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:216: erro
   r: request for member `release' in something not a structure or union
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:218: warn
   ing: `inter_module_put' is deprecated (declared at 
include/linux/module.h:57
   8)
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c: 
In funct
   ion `KernAllocAGPPages':
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:265: erro
   r: request for member `allocate_memory' in something not a structure 
or unio
   n
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:273: erro
   r: request for member `bind_memory' in something not a structure or union
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:290: erro
   r: request for member `unbind_memory' in something not a structure or 
union
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:305: erro
   r: request for member `free_memory' in something not a structure or union
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c: 
In funct
   ion `KernMapAGPPages':
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:345: erro
   r: request for member `unbind_memory' in something not a structure or 
union
   /tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c: 
In funct
   ion `KernFreeAGPPages':
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:444: erro
   r: request for member `unbind_memory' in something not a structure or 
union
   
/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-agp.c:445: erro
   r: request for member `free_memory' in something not a structure or union
   make[3]: *** 
[/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/os-a
   gp.o] Error 1
   make[2]: *** 
[_module_/tmp/selfgz7663/NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src
   /nv] Error 2
   NVIDIA: left KBUILD.
   nvidia.ko failed to build!
   make[1]: *** [module] Error 1
   make: *** [module] Error 2
-> Error.

Howto fix this?

Matthias-Christian Ott
