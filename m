Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSJPMVQ>; Wed, 16 Oct 2002 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262488AbSJPMTr>; Wed, 16 Oct 2002 08:19:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2688 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S262480AbSJPMTj>;
	Wed, 16 Oct 2002 08:19:39 -0400
Date: Tue, 15 Oct 2002 17:21:42 -0400 (EDT)
From: davidsen <root@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.4.51 - I2O will not build as a module
Message-ID: <Pine.LNX.4.44.0210151719530.5423-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Partial assortment of the error messages...


drivers/message/i2o/i2o_pci.c: In function `i2o_pci_core_attach':
drivers/message/i2o/i2o_pci.c:371: warning: implicit declaration of function `i2o_sys_init'
  gcc -Wp,-MD,drivers/message/i2o/.i2o_block.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=i2o_block   -c -o drivers/message/i2o/i2o_block.o drivers/message/i2o/i2o_block.c
drivers/message/i2o/i2o_block.c:43:2: #error Please convert me to Documentation/DMA-mapping.txt
  gcc -Wp,-MD,drivers/ide/.ide-cd.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ide_cd   -c -o drivers/ide/ide-cd.o drivers/ide/ide-cd.c
  gcc -Wp,-MD,drivers/ide/.setup-pci.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=setup_pci -DEXPORT_SYMTAB  -c -o drivers/ide/setup-pci.o drivers/ide/setup-pci.c
drivers/char/drm/radeon_mem.c:134: warning: `print_heap' defined but not used
  gcc -Wp,-MD,drivers/char/drm/.radeon_irq.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=radeon_irq   -c -o drivers/char/drm/radeon_irq.o drivers/char/drm/radeon_irq.c
  gcc -Wp,-MD,drivers/char/.softdog.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=softdog   -c -o drivers/char/softdog.o drivers/char/softdog.c
drivers/message/i2o/i2o_block.c: In function `i2ob_send':
drivers/message/i2o/i2o_block.c:324: warning: comparison between pointer and integer
  gcc -Wp,-MD,drivers/char/.consolemap_deftbl.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=consolemap_deftbl   -c -o drivers/char/consolemap_deftbl.o drivers/char/consolemap_deftbl.c
  gcc -Wp,-MD,drivers/char/.defkeymap.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=defkeymap   -c -o drivers/char/defkeymap.o drivers/char/defkeymap.c
  gcc -Wp,-MD,drivers/ide/.ide-dma.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ide_dma -DEXPORT_SYMTAB  -c -o drivers/ide/ide-dma.o drivers/ide/ide-dma.c
make[3]: *** [drivers/message/i2o/i2o_core.o] Error 1
make[3]: *** Waiting for unfinished jobs....
  gcc -Wp,-MD,drivers/char/drm/.tdfx_drv.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=tdfx_drv   -c -o drivers/char/drm/tdfx_drv.o drivers/char/drm/tdfx_drv.c
drivers/message/i2o/i2o_block.c: In function `i2ob_install_device':
drivers/message/i2o/i2o_block.c:1236: structure has no member named `queue_buggy'
drivers/message/i2o/i2o_block.c:1239: structure has no member named `queue_buggy'
  gcc -Wp,-MD,drivers/ide/.ide-proc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ide_proc -DEXPORT_SYMTAB  -c -o drivers/ide/ide-proc.o drivers/ide/ide-proc.c
  gcc -Wp,-MD,drivers/ide/.ide-floppy.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ide_floppy   -c -o drivers/ide/ide-floppy.o drivers/ide/ide-floppy.c
drivers/message/i2o/i2o_block.c: At top level:
drivers/message/i2o/i2o_block.c:1712: parse error before `i2o_block_init'
drivers/message/i2o/i2o_block.c:1713: warning: return type defaults to `int'
drivers/message/i2o/i2o_block.c:1820: parse error before `i2o_block_exit'
drivers/message/i2o/i2o_block.c:1821: warning: return type defaults to `int'
drivers/message/i2o/i2o_block.c: In function `i2o_block_exit':
drivers/message/i2o/i2o_block.c:1875: warning: control reaches end of non-void function
drivers/message/i2o/i2o_block.c: At top level:
drivers/message/i2o/i2o_block.c:1882: parse error before `module_exit'
drivers/message/i2o/i2o_block.c:1883: parse error at end of input
make[3]: *** [drivers/message/i2o/i2o_block.o] Error 1
make[2]: *** [drivers/message/i2o] Error 2
make[1]: *** [drivers/message] Error 2
make[1]: *** Waiting for unfinished jobs....
   ld -m elf_i386  -r -o drivers/ide/built-in.o drivers/ide/pci/built-in.o drivers/ide/ide-probe.o drivers/ide/ide-geometry.o drivers/ide/ide-iops.o drivers/ide/ide-taskfile.o drivers/ide/ide.o drivers/ide/ide-lib.o drivers/ide/ide-disk.o drivers/ide/ide-cd.o drivers/ide/setup-pci.o drivers/ide/ide-dma.o drivers/ide/ide-proc.o drivers/ide/legacy/built-in.o drivers/ide/ppc/built-in.o drivers/ide/arm/built-in.o
  ld -m elf_i386  -r -o drivers/char/drm/tdfx.o drivers/char/drm/tdfx_drv.o
  ld -m elf_i386  -r -o drivers/char/drm/radeon.o drivers/char/drm/radeon_drv.o drivers/char/drm/radeon_cp.o drivers/char/drm/radeon_state.o drivers/char/drm/radeon_mem.o drivers/char/drm/radeon_irq.o
   ld -m elf_i386  -r -o drivers/char/drm/built-in.o drivers/char/drm/tdfx.o drivers/char/drm/radeon.o
   ld -m elf_i386  -r -o drivers/char/built-in.o drivers/char/mem.o drivers/char/tty_io.o drivers/char/n_tty.o drivers/char/tty_ioctl.o drivers/char/pty.o drivers/char/misc.o drivers/char/random.o drivers/char/vt_ioctl.o drivers/char/vc_screen.o drivers/char/consolemap.o drivers/char/consolemap_deftbl.o drivers/char/selection.o drivers/char/keyboard.o drivers/char/vt.o drivers/char/defkeymap.o drivers/char/sysrq.o drivers/char/genrtc.o drivers/char/agp/built-in.o drivers/char/drm/built-in.o drivers/char/pcmcia/built-in.o
make: *** [drivers] Error 2

real	6m21.966s
user	11m33.490s
sys	1m1.500s
bilbo:root> exit
exit

Script done on Tue Oct 15 10:32:50 2002

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


