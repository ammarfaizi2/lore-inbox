Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965472AbWI0Jtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbWI0Jtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965489AbWI0Jtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:49:39 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:14985 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S965472AbWI0Jth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:49:37 -0400
Date: Wed, 27 Sep 2006 18:49:17 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] sh: 2.6.19 merge
Message-ID: <20060927094917.GA8550@localhost.hsdv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Alexey Dobriyan:
      sh: remove cpu_online() definition from <asm/smp.h>

Andriy Skulysh:
      sh: hp6xx mach-type cleanups.
      video: hitfb suspend/resume and updates.
      sound: SH DAC audio driver updates.
      video: Update header location in hp680_bl.
      sh: APM/PM support.

Jamie Lenehan:
      sh: Titan board support.

kogiidena:
      sh: landisk board support.

Nobuhiro Iwamatsu:
      sh: Fix memcpy() build error on sh4eb.

Ollie Wild:
      sh: Fix TCP payload csum bug in csum_partial_copy_generic().

Paul Mundt:
      sh: Move smc37c93x.h for SystemH board use.
      sh: flush_cache_range() cleanup and optimizations.
      sh: Fixup some uninitialized spinlocks.
      sh: Move syscall table in to syscall.S.
      sh: Fix kGDB NMI handling.
      sh: Kill off the .stack section.
      sh: Make hs7751rvoip/rts7751r2d use pm_power_off.
      sh: Various cosmetic cleanups.
      sh: hugetlb updates.
      video: Disable vgacon for SuperH.
      sh: Kill off dead code for SE and SystemH boards.
      sh: Fixup TMU_TOCR definition for SH7300.
      sh: Move hd64461.h to a more sensible location.
      sh: HS7751RVoIP board updates.
      sh: RTS7751R2D board updates.
      sh: Support for SH-4A memory barriers.
      sh: Refactor PRR masking to catch newer SH7760 cuts.
      sh: prefetch()/prefetchw() support.
      sh: earlyprintk= support and cleanups.
      sh: Add SH7750S/SH7091 rules for SH7750 oprofile driver.
      sh: Support for SH7770/SH7780 CPU subtypes.
      sh: Wire up new syscalls.
      sh: Fix fatal oops in copy_user_page() on sh4a (SH7780).
      sh: Fix libata build.
      sh: Add flag for MMU PTEA capability.
      sh: Add control register barriers.
      sh: BSS init bugfix and barrier in entry point.
      sh: SH-4A Privileged Space Mapping Buffer (PMB) support.
      sh: export clear_user_page() for the modules that need it.
      sh: page table alloc cleanups and page fault optimizations.
      sh: ioremap() overhaul.
      sh: Fixup SHMLBA definition for SH7705.
      sh: Fix split ptlock for user mappings in __do_page_fault().
      sh: Board updates for I/O routine rework.
      sh: Store Queue API rework.
      sh: Add support for R7780RP and R7780MP boards.
      sh: Cleanup and document register bank usage.
      video: Update pvr2fb for sq API changes.
      sh: Drop incdir rule for SE7751.
      sh: xchg()/__xchg() always_inline fixes for gcc4.
      sh: Make O= builds work again.
      sh: SE73180 updates for IRQ changes.
      sh: Update new-machine.txt so it's more accurate.
      sh: Free up some and document PTEL flags.
      sh: Use generic CONFIG_FRAME_POINTER.
      sh: kgdb stub cleanups.
      serial: Rework sh-sci for driver model.
      sh: Consolidated SH7751/SH7780 PCI support.
      sh: Inhibit mapping PCI apertures through page tables.
      sh: VoyagerGX cleanups and 8250 UART support.
      sh: G2 DMA IRQ and residue sampling.
      sh: Fixup TEI IRQ requests in request_dma().
      sh: More cosmetic cleanups and trivial fixes.
      sh: Fixup __strnlen_user() behaviour.
      sh: Rename rtc_get/set_time() to avoid RTC_CLASS conflict.
      rtc: New RTC driver for SuperH On-Chip RTC.
      sh: Move voyagergx_reg.h to a more sensible place.
      sh: Make PAGE_OFFSET configurable.
      sh: __NR_restart_syscall support.
      sh: pselect6 and ppoll, along with signal trampoline rework.
      sh: sem2mutex conversion for clock framework.
      sh: Add setup code for various CPU subtypes.
      serial: Add SERIAL_SH_SCI_NR_UARTS for sh-sci.
      sh: Add support for SH7706/SH7710/SH7343 CPUs.
      sh: Kill off the rest of the legacy rtc mess.
      sh: Add support for cacheline poking through debugfs.
      sh: New atomic ops for SH-4A movli.l/movco.l
      watchdog: Add a simple mmap() stub for shwdt.
      sh: Kill off dead boards.
      sh: maskreg IRQ support.
      sh: Cleanup IRQ disabling for hardirq handlers.
      sh: Enable verbose BUG() support.
      sh: SH7710VoIPGW board support.
      sh: Solution Engine SH7343 board support.
      sh: machvec rework.
      sh: select CONFIG_EMBEDDED.
      sh: stack debugging support.
      sh: Enable /proc/kcore support.
      sh: Add support for 4K stacks.
      sh: CPU flags in AT_HWCAP in ELF auxvt.
      sh: Report movli.l/movco.l capabilities.
      sh: Optimized readsl()/writesl() support.
      sh: Update kexec support for API changes.
      sh: Support for L2 cache on newer SH-4A CPUs.
      sh: More intelligent entry_mask/way_size calculation.
      sh: Selective flush_cache_mm() flushing.
      sh: Clean up PAGE_SIZE definition for assembly use.
      sh: Initial vsyscall page support.
      sh: dma-mapping compile fixes.
      sh: Calculate shm alignment at runtime.
      sh: Fix occasional flush_cache_4096() stack corruption.

Richard Curnow:
      sh: Optimized cache handling for SH-4/SH-4A caches.

Takashi YOSHII:
      sh: math-emu support
      sh: SHMIN board support.

Tom Rini:
      sh: Add a simple cmpxchg().

Toshinobu Sugioka:
      sh: Fix a sign extension bug in memset().

Yoshinori Sato:
      sh: Various nommu fixes.
      sh: __addr_ok() and other misc nommu fixups.

 Documentation/sh/new-machine.txt             |  128 +-
 Documentation/sh/register-banks.txt          |   33 
 arch/sh/Kconfig                              |  173 +--
 arch/sh/Kconfig.debug                        |   36 
 arch/sh/Makefile                             |   40 
 arch/sh/boards/adx/Makefile                  |    6 
 arch/sh/boards/adx/irq.c                     |   31 
 arch/sh/boards/adx/irq_maskreg.c             |  106 --
 arch/sh/boards/adx/setup.c                   |   56 -
 arch/sh/boards/bigsur/irq.c                  |   47 
 arch/sh/boards/bigsur/setup.c                |   47 
 arch/sh/boards/cat68701/Makefile             |    6 
 arch/sh/boards/cat68701/irq.c                |   28 
 arch/sh/boards/cat68701/setup.c              |   85 -
 arch/sh/boards/cqreek/Makefile               |    6 
 arch/sh/boards/cqreek/irq.c                  |  128 --
 arch/sh/boards/cqreek/setup.c                |  100 -
 arch/sh/boards/dmida/Makefile                |    7 
 arch/sh/boards/dmida/mach.c                  |   59 -
 arch/sh/boards/dreamcast/irq.c               |   15 
 arch/sh/boards/dreamcast/rtc.c               |   22 
 arch/sh/boards/dreamcast/setup.c             |   40 
 arch/sh/boards/ec3104/setup.c                |   49 
 arch/sh/boards/harp/Makefile                 |    8 
 arch/sh/boards/harp/irq.c                    |  147 --
 arch/sh/boards/harp/led.c                    |   51 -
 arch/sh/boards/harp/mach.c                   |   62 -
 arch/sh/boards/harp/pcidma.c                 |   42 
 arch/sh/boards/harp/setup.c                  |   90 -
 arch/sh/boards/hp6xx/Makefile                |    5 
 arch/sh/boards/hp6xx/hp6xx_apm.c             |  123 ++
 arch/sh/boards/hp6xx/pm.c                    |   88 +
 arch/sh/boards/hp6xx/pm_wakeup.S             |   58 +
 arch/sh/boards/hp6xx/setup.c                 |   62 +
 arch/sh/boards/landisk/Makefile              |    5 
 arch/sh/boards/landisk/io.c                  |  250 ++++
 arch/sh/boards/landisk/irq.c                 |   99 +
 arch/sh/boards/landisk/landisk_pwb.c         |  348 ++++++
 arch/sh/boards/landisk/rtc.c                 |   93 +
 arch/sh/boards/landisk/setup.c               |  177 +++
 arch/sh/boards/mpc1211/rtc.c                 |    4 
 arch/sh/boards/mpc1211/setup.c               |   71 -
 arch/sh/boards/overdrive/Makefile            |    8 
 arch/sh/boards/overdrive/fpga.c              |  133 --
 arch/sh/boards/overdrive/galileo.c           |  587 -----------
 arch/sh/boards/overdrive/io.c                |  172 ---
 arch/sh/boards/overdrive/irq.c               |  191 ---
 arch/sh/boards/overdrive/led.c               |   58 -
 arch/sh/boards/overdrive/mach.c              |   62 -
 arch/sh/boards/overdrive/pcidma.c            |   46 
 arch/sh/boards/overdrive/setup.c             |   36 
 arch/sh/boards/renesas/edosk7705/Makefile    |    4 
 arch/sh/boards/renesas/edosk7705/setup.c     |   29 
 arch/sh/boards/renesas/hs7751rvoip/Kconfig   |   12 
 arch/sh/boards/renesas/hs7751rvoip/Makefile  |    6 
 arch/sh/boards/renesas/hs7751rvoip/io.c      |  252 ++--
 arch/sh/boards/renesas/hs7751rvoip/irq.c     |    6 
 arch/sh/boards/renesas/hs7751rvoip/led.c     |   26 
 arch/sh/boards/renesas/hs7751rvoip/mach.c    |   54 -
 arch/sh/boards/renesas/hs7751rvoip/setup.c   |   94 +
 arch/sh/boards/renesas/r7780rp/Kconfig       |   14 
 arch/sh/boards/renesas/r7780rp/Makefile      |    6 
 arch/sh/boards/renesas/r7780rp/io.c          |  301 +++++
 arch/sh/boards/renesas/r7780rp/irq.c         |  117 ++
 arch/sh/boards/renesas/r7780rp/led.c         |   45 
 arch/sh/boards/renesas/r7780rp/setup.c       |  163 +++
 arch/sh/boards/renesas/rts7751r2d/Kconfig    |   12 
 arch/sh/boards/renesas/rts7751r2d/Makefile   |    8 
 arch/sh/boards/renesas/rts7751r2d/io.c       |  191 +--
 arch/sh/boards/renesas/rts7751r2d/irq.c      |    6 
 arch/sh/boards/renesas/rts7751r2d/led.c      |   11 
 arch/sh/boards/renesas/rts7751r2d/mach.c     |   69 -
 arch/sh/boards/renesas/rts7751r2d/setup.c    |  139 ++
 arch/sh/boards/renesas/sh7710voipgw/Makefile |    1 
 arch/sh/boards/renesas/sh7710voipgw/setup.c  |  109 ++
 arch/sh/boards/renesas/systemh/io.c          |  163 ---
 arch/sh/boards/renesas/systemh/irq.c         |   10 
 arch/sh/boards/renesas/systemh/setup.c       |   30 
 arch/sh/boards/saturn/setup.c                |   14 
 arch/sh/boards/se/7300/io.c                  |    8 
 arch/sh/boards/se/7300/irq.c                 |    2 
 arch/sh/boards/se/7300/led.c                 |   18 
 arch/sh/boards/se/7300/setup.c               |   20 
 arch/sh/boards/se/73180/io.c                 |    6 
 arch/sh/boards/se/73180/irq.c                |    9 
 arch/sh/boards/se/73180/led.c                |   15 
 arch/sh/boards/se/73180/setup.c              |   22 
 arch/sh/boards/se/7343/Makefile              |    7 
 arch/sh/boards/se/7343/io.c                  |  275 +++++
 arch/sh/boards/se/7343/irq.c                 |  193 +++
 arch/sh/boards/se/7343/led.c                 |   46 
 arch/sh/boards/se/7343/setup.c               |   84 +
 arch/sh/boards/se/770x/Makefile              |    4 
 arch/sh/boards/se/770x/io.c                  |   61 -
 arch/sh/boards/se/770x/irq.c                 |    2 
 arch/sh/boards/se/770x/led.c                 |   17 
 arch/sh/boards/se/770x/mach.c                |   67 -
 arch/sh/boards/se/770x/setup.c               |   65 -
 arch/sh/boards/se/7751/Makefile              |    4 
 arch/sh/boards/se/7751/io.c                  |  171 ---
 arch/sh/boards/se/7751/irq.c                 |    2 
 arch/sh/boards/se/7751/led.c                 |   18 
 arch/sh/boards/se/7751/mach.c                |   54 -
 arch/sh/boards/se/7751/setup.c               |  109 --
 arch/sh/boards/sh03/rtc.c                    |    9 
 arch/sh/boards/sh03/setup.c                  |   49 
 arch/sh/boards/sh2000/Makefile               |    6 
 arch/sh/boards/sh2000/setup.c                |   70 -
 arch/sh/boards/shmin/Makefile                |    5 
 arch/sh/boards/shmin/setup.c                 |   41 
 arch/sh/boards/snapgear/io.c                 |  145 --
 arch/sh/boards/snapgear/rtc.c                |   34 
 arch/sh/boards/snapgear/setup.c              |  115 --
 arch/sh/boards/superh/microdev/irq.c         |   39 
 arch/sh/boards/superh/microdev/setup.c       |  113 --
 arch/sh/boards/titan/Makefile                |    5 
 arch/sh/boards/titan/io.c                    |  126 ++
 arch/sh/boards/titan/setup.c                 |   48 
 arch/sh/boards/unknown/setup.c               |   13 
 arch/sh/boot/compressed/Makefile             |   11 
 arch/sh/cchips/Kconfig                       |    6 
 arch/sh/cchips/hd6446x/hd64461/io.c          |   20 
 arch/sh/cchips/hd6446x/hd64461/setup.c       |   10 
 arch/sh/cchips/hd6446x/hd64465/setup.c       |    6 
 arch/sh/cchips/voyagergx/irq.c               |   23 
 arch/sh/cchips/voyagergx/setup.c             |    2 
 arch/sh/configs/landisk_defconfig            | 1373 +++++++++++++++++++++++++++
 arch/sh/configs/r7780rp_defconfig            | 1099 +++++++++++++++++++++
 arch/sh/configs/se73180_defconfig            |    1 
 arch/sh/configs/se7343_defconfig             |  997 +++++++++++++++++++
 arch/sh/configs/sh7710voipgw_defconfig       |  913 +++++++++++++++++
 arch/sh/configs/shmin_defconfig              |  827 ++++++++++++++++
 arch/sh/configs/titan_defconfig              | 1367 ++++++++++++++++++++++++++
 arch/sh/drivers/dma/Kconfig                  |    3 
 arch/sh/drivers/dma/dma-g2.c                 |   54 -
 arch/sh/drivers/dma/dma-pvr2.c               |    5 
 arch/sh/drivers/dma/dma-sh.c                 |   19 
 arch/sh/drivers/pci/Makefile                 |    6 
 arch/sh/drivers/pci/fixups-dreamcast.c       |   38 
 arch/sh/drivers/pci/fixups-r7780rp.c         |   45 
 arch/sh/drivers/pci/fixups-rts7751r2d.c      |   24 
 arch/sh/drivers/pci/fixups-sh03.c            |   38 
 arch/sh/drivers/pci/ops-bigsur.c             |   18 
 arch/sh/drivers/pci/ops-landisk.c            |   68 +
 arch/sh/drivers/pci/ops-r7780rp.c            |   75 +
 arch/sh/drivers/pci/ops-rts7751r2d.c         |   13 
 arch/sh/drivers/pci/ops-sh4.c                |  164 +++
 arch/sh/drivers/pci/ops-snapgear.c           |   21 
 arch/sh/drivers/pci/ops-titan.c              |   83 +
 arch/sh/drivers/pci/pci-auto.c               |   48 
 arch/sh/drivers/pci/pci-sh4.h                |  180 +++
 arch/sh/drivers/pci/pci-sh7751.c             |  326 +-----
 arch/sh/drivers/pci/pci-sh7751.h             |  174 ---
 arch/sh/drivers/pci/pci-sh7780.c             |  139 ++
 arch/sh/drivers/pci/pci-sh7780.h             |   94 +
 arch/sh/drivers/pci/pci-st40.c               |   19 
 arch/sh/drivers/pci/pci.c                    |  105 +-
 arch/sh/kernel/Makefile                      |    5 
 arch/sh/kernel/apm.c                         |  539 ++++++++++
 arch/sh/kernel/cf-enabler.c                  |   12 
 arch/sh/kernel/cpu/Makefile                  |    1 
 arch/sh/kernel/cpu/clock.c                   |   19 
 arch/sh/kernel/cpu/init.c                    |   21 
 arch/sh/kernel/cpu/irq/Makefile              |    5 
 arch/sh/kernel/cpu/irq/intc2.c               |    6 
 arch/sh/kernel/cpu/irq/ipr.c                 |   14 
 arch/sh/kernel/cpu/irq/maskreg.c             |   93 +
 arch/sh/kernel/cpu/irq/pint.c                |    8 
 arch/sh/kernel/cpu/rtc.c                     |  128 --
 arch/sh/kernel/cpu/sh3/Makefile              |   13 
 arch/sh/kernel/cpu/sh3/clock-sh7706.c        |   84 +
 arch/sh/kernel/cpu/sh3/ex.S                  |   54 +
 arch/sh/kernel/cpu/sh3/probe.c               |    6 
 arch/sh/kernel/cpu/sh3/setup-sh7300.c        |   43 
 arch/sh/kernel/cpu/sh3/setup-sh7705.c        |   48 
 arch/sh/kernel/cpu/sh3/setup-sh7708.c        |   43 
 arch/sh/kernel/cpu/sh3/setup-sh7709.c        |   53 +
 arch/sh/kernel/cpu/sh3/setup-sh7710.c        |   43 
 arch/sh/kernel/cpu/sh4/Makefile              |   10 
 arch/sh/kernel/cpu/sh4/ex.S                  |  176 +++
 arch/sh/kernel/cpu/sh4/probe.c               |  138 ++
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c       |   43 
 arch/sh/kernel/cpu/sh4/setup-sh73180.c       |   43 
 arch/sh/kernel/cpu/sh4/setup-sh7343.c        |   43 
 arch/sh/kernel/cpu/sh4/setup-sh7750.c        |   48 
 arch/sh/kernel/cpu/sh4/setup-sh7760.c        |   53 +
 arch/sh/kernel/cpu/sh4/setup-sh7770.c        |   53 +
 arch/sh/kernel/cpu/sh4/setup-sh7780.c        |   79 +
 arch/sh/kernel/cpu/sh4/sq.c                  |  543 ++++------
 arch/sh/kernel/early_printk.c                |  106 +-
 arch/sh/kernel/entry.S                       |  333 ------
 arch/sh/kernel/head.S                        |   43 
 arch/sh/kernel/io.c                          |   67 +
 arch/sh/kernel/irq.c                         |  168 +++
 arch/sh/kernel/kgdb_stub.c                   |   33 
 arch/sh/kernel/machine_kexec.c               |    6 
 arch/sh/kernel/pm.c                          |   88 +
 arch/sh/kernel/process.c                     |   28 
 arch/sh/kernel/ptrace.c                      |    1 
 arch/sh/kernel/semaphore.c                   |    2 
 arch/sh/kernel/setup.c                       |  117 --
 arch/sh/kernel/sh_ksyms.c                    |   32 
 arch/sh/kernel/signal.c                      |  158 +--
 arch/sh/kernel/sys_sh.c                      |   56 -
 arch/sh/kernel/syscalls.S                    |  353 ++++++
 arch/sh/kernel/time.c                        |   68 -
 arch/sh/kernel/timers/timer-tmu.c            |   24 
 arch/sh/kernel/traps.c                       |  184 ++-
 arch/sh/kernel/vmlinux.lds.S                 |   17 
 arch/sh/kernel/vsyscall/Makefile             |   36 
 arch/sh/kernel/vsyscall/vsyscall-note.S      |   25 
 arch/sh/kernel/vsyscall/vsyscall-sigreturn.S |   39 
 arch/sh/kernel/vsyscall/vsyscall-syscall.S   |   10 
 arch/sh/kernel/vsyscall/vsyscall-trapa.S     |   42 
 arch/sh/kernel/vsyscall/vsyscall.c           |  150 ++
 arch/sh/kernel/vsyscall/vsyscall.lds.S       |   74 +
 arch/sh/lib/checksum.S                       |    3 
 arch/sh/lib/memcpy-sh4.S                     |    4 
 arch/sh/lib/memset.S                         |    1 
 arch/sh/math-emu/Makefile                    |    1 
 arch/sh/math-emu/math.c                      |  624 ++++++++++++
 arch/sh/math-emu/sfp-util.h                  |   72 +
 arch/sh/mm/Kconfig                           |   78 +
 arch/sh/mm/Makefile                          |   16 
 arch/sh/mm/cache-debugfs.c                   |  147 ++
 arch/sh/mm/cache-sh4.c                       |  685 ++++++++++---
 arch/sh/mm/cache-sh7705.c                    |   19 
 arch/sh/mm/clear_page.S                      |   99 -
 arch/sh/mm/consistent.c                      |    2 
 arch/sh/mm/fault.c                           |  207 ----
 arch/sh/mm/hugetlbpage.c                     |   52 -
 arch/sh/mm/init.c                            |   32 
 arch/sh/mm/ioremap.c                         |   17 
 arch/sh/mm/pg-nommu.c                        |   17 
 arch/sh/mm/pg-sh4.c                          |   24 
 arch/sh/mm/pmb.c                             |  400 +++++++
 arch/sh/mm/tlb-flush.c                       |  134 ++
 arch/sh/mm/tlb-sh4.c                         |    8 
 arch/sh/oprofile/Makefile                    |    4 
 arch/sh/tools/mach-types                     |   10 
 drivers/char/Kconfig                         |    2 
 drivers/char/watchdog/Kconfig                |    8 
 drivers/char/watchdog/shwdt.c                |  110 +-
 drivers/input/touchscreen/hp680_ts_input.c   |   14 
 drivers/net/stnic.c                          |    2 
 drivers/rtc/Kconfig                          |   10 
 drivers/rtc/Makefile                         |    1 
 drivers/rtc/rtc-sh.c                         |  467 +++++++++
 drivers/serial/Kconfig                       |    9 
 drivers/serial/sh-sci.c                      | 1146 ++++++++--------------
 drivers/serial/sh-sci.h                      |   90 -
 drivers/video/backlight/hp680_bl.c           |    4 
 drivers/video/console/Kconfig                |    2 
 drivers/video/hitfb.c                        |  229 +++-
 drivers/video/pvr2fb.c                       |   22 
 include/asm-sh/addrspace.h                   |    8 
 include/asm-sh/adx/io.h                      |   86 -
 include/asm-sh/apm.h                         |   46 
 include/asm-sh/atomic.h                      |  106 +-
 include/asm-sh/auxvec.h                      |   14 
 include/asm-sh/bitops.h                      |   16 
 include/asm-sh/bugs.h                        |    4 
 include/asm-sh/cache.h                       |   30 
 include/asm-sh/cacheflush.h                  |    3 
 include/asm-sh/cat68701/io.h                 |   22 
 include/asm-sh/checksum.h                    |    2 
 include/asm-sh/cpu-features.h                |   24 
 include/asm-sh/cpu-sh2/shmparam.h            |   16 
 include/asm-sh/cpu-sh3/cache.h               |    4 
 include/asm-sh/cpu-sh3/cacheflush.h          |   52 -
 include/asm-sh/cpu-sh3/freq.h                |    4 
 include/asm-sh/cpu-sh3/mmu_context.h         |    8 
 include/asm-sh/cpu-sh3/shmparam.h            |   16 
 include/asm-sh/cpu-sh3/timer.h               |    8 
 include/asm-sh/cpu-sh3/ubc.h                 |   15 
 include/asm-sh/cpu-sh4/addrspace.h           |    3 
 include/asm-sh/cpu-sh4/cache.h               |    2 
 include/asm-sh/cpu-sh4/cacheflush.h          |   36 
 include/asm-sh/cpu-sh4/dma-sh7780.h          |   39 
 include/asm-sh/cpu-sh4/dma.h                 |   11 
 include/asm-sh/cpu-sh4/shmparam.h            |   19 
 include/asm-sh/cpu-sh4/sq.h                  |   23 
 include/asm-sh/cqreek/cqreek.h               |   27 
 include/asm-sh/dma-mapping.h                 |   42 
 include/asm-sh/dma.h                         |    1 
 include/asm-sh/dmida/io.h                    |   10 
 include/asm-sh/elf.h                         |   30 
 include/asm-sh/fixmap.h                      |    2 
 include/asm-sh/flat.h                        |    2 
 include/asm-sh/harp/harp.h                   |   43 
 include/asm-sh/harp/io.h                     |   10 
 include/asm-sh/hd64461.h                     |  208 ++++
 include/asm-sh/hd64461/hd64461.h             |  202 ---
 include/asm-sh/hd64461/io.h                  |   43 
 include/asm-sh/hp6xx/hp6xx.h                 |   53 +
 include/asm-sh/hp6xx/io.h                    |    2 
 include/asm-sh/hs7751rvoip/hs7751rvoip.h     |   11 
 include/asm-sh/io.h                          |   16 
 include/asm-sh/irq-sh73180.h                 |    2 
 include/asm-sh/irq-sh7343.h                  |  317 ++++++
 include/asm-sh/irq-sh7780.h                  |    5 
 include/asm-sh/irq.h                         |  137 ++
 include/asm-sh/kexec.h                       |    9 
 include/asm-sh/kgdb.h                        |   15 
 include/asm-sh/landisk/gio.h                 |   45 
 include/asm-sh/landisk/ide.h                 |   14 
 include/asm-sh/landisk/iodata_landisk.h      |   79 +
 include/asm-sh/machvec.h                     |    7 
 include/asm-sh/mc146818rtc.h                 |  169 ---
 include/asm-sh/mmu.h                         |   77 +
 include/asm-sh/mmu_context.h                 |   15 
 include/asm-sh/overdrive/fpga.h              |   15 
 include/asm-sh/overdrive/gt64111.h           |  109 --
 include/asm-sh/overdrive/io.h                |   39 
 include/asm-sh/overdrive/overdrive.h         |   88 -
 include/asm-sh/page.h                        |   33 
 include/asm-sh/pci.h                         |   44 
 include/asm-sh/pgalloc.h                     |   37 
 include/asm-sh/pgtable.h                     |  154 +--
 include/asm-sh/pm.h                          |   17 
 include/asm-sh/processor.h                   |   52 -
 include/asm-sh/r7780rp/ide.h                 |    8 
 include/asm-sh/r7780rp/r7780rp.h             |  177 +++
 include/asm-sh/rtc.h                         |   25 
 include/asm-sh/rts7751r2d/rts7751r2d.h       |    2 
 include/asm-sh/rts7751r2d/voyagergx_reg.h    |  313 ------
 include/asm-sh/scatterlist.h                 |    9 
 include/asm-sh/sci.h                         |   34 
 include/asm-sh/se.h                          |   80 +
 include/asm-sh/se/io.h                       |   35 
 include/asm-sh/se/se.h                       |   77 -
 include/asm-sh/se/smc37c93x.h                |  190 ---
 include/asm-sh/se7300.h                      |   64 +
 include/asm-sh/se7300/io.h                   |   29 
 include/asm-sh/se7300/se7300.h               |   61 -
 include/asm-sh/se73180.h                     |   65 +
 include/asm-sh/se73180/io.h                  |   32 
 include/asm-sh/se73180/se73180.h             |   62 -
 include/asm-sh/se7343.h                      |   82 +
 include/asm-sh/se7751.h                      |   71 +
 include/asm-sh/se7751/io.h                   |   42 
 include/asm-sh/se7751/se7751.h               |   68 -
 include/asm-sh/setup.h                       |    2 
 include/asm-sh/sfp-machine.h                 |   86 +
 include/asm-sh/sh03/io.h                     |   10 
 include/asm-sh/sh2000/sh2000.h               |    8 
 include/asm-sh/shmin/shmin.h                 |    9 
 include/asm-sh/shmparam.h                    |   20 
 include/asm-sh/smc37c93x.h                   |  190 +++
 include/asm-sh/smp.h                         |    5 
 include/asm-sh/snapgear.h                    |   79 +
 include/asm-sh/snapgear/io.h                 |   92 -
 include/asm-sh/system.h                      |  199 ++-
 include/asm-sh/systemh/7751systemh.h         |   68 -
 include/asm-sh/systemh/io.h                  |   43 
 include/asm-sh/systemh7751.h                 |   71 +
 include/asm-sh/thread_info.h                 |   43 
 include/asm-sh/timer.h                       |    2 
 include/asm-sh/titan.h                       |   43 
 include/asm-sh/uaccess.h                     |   79 -
 include/asm-sh/unistd.h                      |   44 
 include/asm-sh/voyagergx.h                   |  313 ++++++
 include/asm-sh/watchdog.h                    |    3 
 lib/Kconfig.debug                            |    4 
 sound/oss/sh_dac_audio.c                     |   60 -
 365 files changed, 21863 insertions(+), 10160 deletions(-)
