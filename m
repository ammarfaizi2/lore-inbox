Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVLaAY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVLaAY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVLaAY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:24:29 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:12456 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750740AbVLaAY2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:24:28 -0500
Message-ID: <43B5CFB1.3080304@ens-lyon.org>
Date: Sat, 31 Dec 2005 01:24:17 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerhard Mack <gmack@innerfire.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ati X300 support?
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net> <200512270149.24440.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512270817340.15649@innerfire.net> <200512271545.31224.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512271047260.2104@innerfire.net> <Pine.LNX.4.60.0512280103100.29982@kepler.fjfi.cvut.cz> <Pine.LNX.4.64.0512271927130.5956@innerfire.net> <Pine.LNX.4.60.0512280229530.30594@kepler.fjfi.cvut.cz> <Pine.LNX.4.64.0512272121230.11181@innerfire.net>
In-Reply-To: <Pine.LNX.4.64.0512272121230.11181@innerfire.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack wrote:

>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module
>ATI module generator V 2.0
>==========================
>initializing...
>cleaning...
>patching 'highmem.h'...
>assuming new VMA API since we do have kernel 2.6.x...
>doing Makefile based build for kernel 2.6.x and higher
>make -C /lib/modules/2.6.15-rc7/build SUBDIRS=/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/2.6.x modules
>make[1]: Entering directory `/usr/src/linux-2.6.15-rc7'
>mkdir -p /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/2.6.x/.tmp_versions
>make -f scripts/Makefile.build obj=/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/2.6.x
>  Building modules, stage 2.
>make -rR -f /usr/src/linux-2.6.15-rc7/scripts/Makefile.modpost
>  scripts/mod/modpost -m -a -i /usr/src/linux-2.6.15-rc7/Module.symvers vmlinux /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/2.6.x/fglrx.o
>Warning: could not find /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/2.6.x/.libfglrx_ip.a.GCC4.cmd for /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/2.6.x/libfglrx_ip.a.GCC4
>make[1]: Leaving directory `/usr/src/linux-2.6.15-rc7'
>build succeeded with return value 0
>  
>
fglrx.ko got build at this point, didn't it ? I am also seeing a build
problem on my (32bits) Thinkpad T43 _after_ fglrx.ko got build
successfully. I just don't care about the build error, only load
fglrx.ko and it works.

Brice



> compiling fglrx_agp.ko module
>make -C /lib/modules/2.6.15-rc7/build SUBDIRS=/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart modules
>make[1]: Entering directory `/usr/src/linux-2.6.15-rc7'
>mkdir -p /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/.tmp_versions
>make -f scripts/Makefile.build obj=/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart
>  gcc -Wp,-MD,/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/.firegl_wrap.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-linux-gnu/4.0.3/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -Os     -fomit-frame-pointer -march=k8 -mno-red-zone -mcmodel=kernel -pipe -fno-reorder-blocks	 -Wno-sign-compare -fno-asynchronous-unwind-tables -funit-at-a-time -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -Wdeclaration-after-statement -Wno-pointer-sign -I/usr/src/linux-2.6.15-rc7 -D__AGP__ -DFGL -DFGL_LINUX -DFGL_GART_RESERVED_SLOT -DFGL_LINUX253P1_VMA_API -DPAGE_ATTR_FIX=1   -DMODULE -DATI_AGP_HOOK -DATI -DFGL -DFGL_RX -DFGL_CUSTOM_MODULE -DPAGE_ATTR_FIX=1  -DMODVERSIONS -DKBUILD_BASENAME=firegl_wrap -DKBUILD_MODNAME=fglrx_agp -c -o /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/.tmp_firegl_wrap.o /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c
>In file included from /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:113:
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_agp.h:755:1: warning: "PCI_DEVICE_ID_INTEL_ICH7_1" redefined
>In file included from include/linux/pci.h:26,
>                 from /usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:74:
>include/linux/pci_ids.h:2051:1: warning: this is the location of the previous definition
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:121:25: error: asm/ioctl32.h: No such file or directory
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:171: error: static declaration of 'errno' follows non-static declaration
>include/linux/unistd.h:4: error: previous declaration of 'errno' was here
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_phys_to_virt':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:660: warning: passing argument 1 of 'phys_to_virt' makes integer from pointer without a cast
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:660: warning: return makes integer from pointer without a cast
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: At top level:
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:695: error: conflicting types for '__ke_pci_find_class'
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.h:419: error: previous declaration of '__ke_pci_find_class' was here
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_pci_find_class':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:697: warning: implicit declaration of function 'pci_find_class'
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:697: error: incompatible types in return
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function 'firegl_get_user_ptr':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:762: warning: assignment makes pointer from integer without a cast
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function 'firegl_put_user_ptr':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:794: warning: cast from pointer to integer of different size
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:794: warning: cast from pointer to integer of different size
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:794: warning: cast from pointer to integer of different size
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:794: warning: cast from pointer to integer of different size
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_verify_area':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:1123: warning: implicit declaration of function 'verify_area'
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_get_vm_phys_addr':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:1362: error: 'struct <anonymous>' has no member named 'pud'
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_register_ioctl32_conversion':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:1689: warning: implicit declaration of function 'register_ioctl32_conversion'
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_unregister_ioctl32_conversion':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:1694: warning: implicit declaration of function 'unregister_ioctl32_conversion'
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_vm_phys_addr_str':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:1818: error: 'struct <anonymous>' has no member named 'pud'
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c: In function '__ke_smp_call_function':
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.c:2252: warning: statement with no effect
>make[2]: *** [/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart/firegl_wrap.o] Error 1
>make[1]: *** [_module_/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module/build_mod/firegl_agpgart] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.6.15-rc7'
>make: *** [default] Error 2
>AGPGART module build failed with return value 2
>duplication skipped - generator was not called from regular lib tree
>done.
>==============================
>/usr/local/src/fglrx64-assemble_scripts/fglrx-8.20.8-x86_64-kernel-module
>--
>Gerhard Mack
>
>gmack@innerfire.net
>
><>< As a computer I find your faith in technology amusing.
>


