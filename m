Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbWJCXFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbWJCXFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbWJCXFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:05:18 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47120 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030488AbWJCXFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:05:13 -0400
Date: Wed, 4 Oct 2006 01:05:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20061003230511.GB7398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following:

Adrian Bunk:
      input: remove obsolete contact information
      remove mentionings of devfs in documentation

Christian Borntraeger:
      Fix bytes <-> kilobytes  typo in Kconfig for ramdisk

Eric Sesterhenn:
      BUG_ON cleanup for drivers/md/
      BUG_ON cleanup in drivers/net/tokenring/
      BUG_ON cleanups in arch/i386
      BUG_ON conversion for fs/reiserfs
      BUG_ON() conversion in fs/nfsd/
      BUG_ON conversion for fs/xfs/

Henrik Kretzschmar:
      kerneldoc-typo in led-class.c

Jim Cromie:
      ite_gpio fix tabbage

Josh Triplett:
      rcutorture: Fix incorrect description of default for nreaders parameter

Komal Shah:
      debugfs: spelling fix

Matt LaPlante:
      Attack of "the the"s in arch
      Typos in fs/Kconfig
      fix an arch/alpha/Kconfig typo
      fix drivers/acpi/Kconfig typos
      Fix several typos in drivers/
      more misc typo fixes
      Still more typo fixes
      Fix some typos in Documentation/: 'A'
      Fix typos in Documentation/: 'B'-'C'
      Fix typos in Documentation/: 'D'-'E'
      Fix typos in Documentation/: 'F'-'G'
      Fix typos in Documentation/: 'H'-'M'
      Fix typos in Documentation/: 'N'-'P'
      Fix "can not" in Documentation and Kconfig
      Fix typos in Documentation/: 'Q'-'R'
      Fix typos in Documentation/: 'S'

Matthew Martin:
      parport: Remove space in function calls

Michael Opdenacker:
      reboot parameter in Documentation/kernel-parameters.txt
      Spelling fix: "control" instead of "cotrol"

Michal Wronski:
      Michal Wronski: update contact info

Paolo Ornati:
      Documentation: remove duplicated words

Riccardo Magliocchetti:
      fix a typo in Documentation/pi-futex.txt

Rolf Eike Beer:
      remove duplicate "until" from kernel/workqueue.c
      Fix copy&waste bug in comment in scripts/kernel-doc

Samuel Tardieu:
      Add missing maintainer countries in CREDITS

Uwe Zeisberger:
      fix file specification in comments


 CREDITS                                                      |    8 
 Documentation/DMA-mapping.txt                                |    4 
 Documentation/DocBook/libata.tmpl                            |    2 
 Documentation/DocBook/usb.tmpl                               |    5 
 Documentation/DocBook/writing_usb_driver.tmpl                |    7 
 Documentation/IPMI.txt                                       |    4 
 Documentation/MSI-HOWTO.txt                                  |    2 
 Documentation/RCU/whatisRCU.txt                              |    4 
 Documentation/aoe/todo.txt                                   |    2 
 Documentation/arm/SA1100/serial_UART                         |    4 
 Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt              |    2 
 Documentation/arm/Samsung-S3C24XX/GPIO.txt                   |    2 
 Documentation/arm/Samsung-S3C24XX/Overview.txt               |    2 
 Documentation/arm/Samsung-S3C24XX/S3C2412.txt                |    2 
 Documentation/block/as-iosched.txt                           |    4 
 Documentation/block/barrier.txt                              |    6 
 Documentation/block/biodoc.txt                               |   10 
 Documentation/block/deadline-iosched.txt                     |    4 
 Documentation/cciss.txt                                      |    4 
 Documentation/computone.txt                                  |   70 ---
 Documentation/cpu-freq/cpufreq-stats.txt                     |   10 
 Documentation/cpu-freq/governors.txt                         |   12 
 Documentation/cputopology.txt                                |    2 
 Documentation/dell_rbu.txt                                   |   22 -
 Documentation/devices.txt                                    |    8 
 Documentation/driver-model/class.txt                         |    2 
 Documentation/driver-model/driver.txt                        |    2 
 Documentation/driver-model/overview.txt                      |    2 
 Documentation/dvb/avermedia.txt                              |    4 
 Documentation/dvb/cards.txt                                  |    2 
 Documentation/dvb/ci.txt                                     |    4 
 Documentation/dvb/faq.txt                                    |    6 
 Documentation/eisa.txt                                       |    4 
 Documentation/exception.txt                                  |    2 
 Documentation/fb/fbcon.txt                                   |    2 
 Documentation/fb/sisfb.txt                                   |    2 
 Documentation/fb/sstfb.txt                                   |   42 -
 Documentation/feature-removal-schedule.txt                   |    2 
 Documentation/filesystems/00-INDEX                           |    2 
 Documentation/filesystems/befs.txt                           |    8 
 Documentation/filesystems/configfs/configfs.txt              |    8 
 Documentation/filesystems/directory-locking                  |    2 
 Documentation/filesystems/dlmfs.txt                          |    2 
 Documentation/filesystems/ext2.txt                           |    2 
 Documentation/filesystems/files.txt                          |    2 
 Documentation/filesystems/ntfs.txt                           |   10 
 Documentation/filesystems/proc.txt                           |   10 
 Documentation/filesystems/spufs.txt                          |    6 
 Documentation/filesystems/sysfs.txt                          |    2 
 Documentation/filesystems/tmpfs.txt                          |    4 
 Documentation/filesystems/vfat.txt                           |    2 
 Documentation/filesystems/vfs.txt                            |    2 
 Documentation/fujitsu/frv/mmu-layout.txt                     |    2 
 Documentation/highuid.txt                                    |    2 
 Documentation/hrtimers.txt                                   |   12 
 Documentation/ia64/efirtc.txt                                |    2 
 Documentation/ia64/fsys.txt                                  |    2 
 Documentation/ia64/mca.txt                                   |    4 
 Documentation/ibm-acpi.txt                                   |    2 
 Documentation/ide.txt                                        |    2 
 Documentation/input/amijoy.txt                               |    4 
 Documentation/input/atarikbd.txt                             |   10 
 Documentation/input/cs461x.txt                               |    2 
 Documentation/input/ff.txt                                   |    2 
 Documentation/input/gameport-programming.txt                 |    4 
 Documentation/input/input.txt                                |   31 -
 Documentation/input/joystick-parport.txt                     |    8 
 Documentation/input/joystick.txt                             |    2 
 Documentation/input/yealink.txt                              |    4 
 Documentation/ioctl/hdio.txt                                 |    2 
 Documentation/isdn/INTERFACE.fax                             |    2 
 Documentation/isdn/README.hysdn                              |    2 
 Documentation/java.txt                                       |    2 
 Documentation/kbuild/kconfig-language.txt                    |    4 
 Documentation/kdump/kdump.txt                                |    2 
 Documentation/kernel-docs.txt                                |   11 
 Documentation/kernel-parameters.txt                          |   10 
 Documentation/keys.txt                                       |    6 
 Documentation/kobject.txt                                    |    2 
 Documentation/laptop-mode.txt                                |    2 
 Documentation/lockdep-design.txt                             |    8 
 Documentation/m68k/kernel-options.txt                        |    2 
 Documentation/mca.txt                                        |    2 
 Documentation/md.txt                                         |   16 
 Documentation/memory-barriers.txt                            |    4 
 Documentation/mono.txt                                       |    2 
 Documentation/networking/3c509.txt                           |    2 
 Documentation/networking/NAPI_HOWTO.txt                      |    2 
 Documentation/networking/arcnet-hardware.txt                 |    2 
 Documentation/networking/bonding.txt                         |    2 
 Documentation/networking/cs89x0.txt                          |    6 
 Documentation/networking/cxgb.txt                            |    4 
 Documentation/networking/decnet.txt                          |    2 
 Documentation/networking/dl2k.txt                            |    4 
 Documentation/networking/dmfe.txt                            |    2 
 Documentation/networking/driver.txt                          |    2 
 Documentation/networking/e1000.txt                           |    2 
 Documentation/networking/fib_trie.txt                        |    2 
 Documentation/networking/gen_stats.txt                       |    8 
 Documentation/networking/ip-sysctl.txt                       |    4 
 Documentation/networking/netconsole.txt                      |    2 
 Documentation/networking/netif-msg.txt                       |    2 
 Documentation/networking/operstates.txt                      |    2 
 Documentation/networking/packet_mmap.txt                     |   24 -
 Documentation/networking/pktgen.txt                          |    8 
 Documentation/networking/s2io.txt                            |    2 
 Documentation/networking/sk98lin.txt                         |   16 
 Documentation/networking/skfp.txt                            |    4 
 Documentation/networking/slicecom.txt                        |    8 
 Documentation/networking/smctr.txt                           |    2 
 Documentation/networking/tcp.txt                             |    2 
 Documentation/networking/tms380tr.txt                        |    2 
 Documentation/networking/vortex.txt                          |    4 
 Documentation/networking/wan-router.txt                      |   16 
 Documentation/nfsroot.txt                                    |    2 
 Documentation/pci-error-recovery.txt                         |    2 
 Documentation/pi-futex.txt                                   |    2 
 Documentation/pm.txt                                         |    6 
 Documentation/pnp.txt                                        |    2 
 Documentation/power/pci.txt                                  |    2 
 Documentation/power/swsusp.txt                               |    8 
 Documentation/power/tricks.txt                               |    2 
 Documentation/power/userland-swsusp.txt                      |    2 
 Documentation/power/video.txt                                |    2 
 Documentation/powerpc/booting-without-of.txt                 |   43 --
 Documentation/powerpc/eeh-pci-error-recovery.txt             |    4 
 Documentation/powerpc/hvcs.txt                               |    2 
 Documentation/prio_tree.txt                                  |    2 
 Documentation/rocket.txt                                     |    6 
 Documentation/rpc-cache.txt                                  |    4 
 Documentation/s390/3270.txt                                  |    4 
 Documentation/s390/Debugging390.txt                          |   93 ++--
 Documentation/s390/cds.txt                                   |   14 
 Documentation/s390/crypto/crypto-API.txt                     |    4 
 Documentation/s390/driver-model.txt                          |    4 
 Documentation/s390/monreader.txt                             |    2 
 Documentation/s390/s390dbf.txt                               |   12 
 Documentation/sched-coding.txt                               |    2 
 Documentation/sched-design.txt                               |    4 
 Documentation/scsi/ChangeLog.1992-1997                       |    2 
 Documentation/scsi/NinjaSCSI.txt                             |   18 
 Documentation/scsi/aacraid.txt                               |    2 
 Documentation/scsi/aic79xx.txt                               |    4 
 Documentation/scsi/aic7xxx.txt                               |    2 
 Documentation/scsi/aic7xxx_old.txt                           |    6 
 Documentation/scsi/dc395x.txt                                |    2 
 Documentation/scsi/dpti.txt                                  |    2 
 Documentation/scsi/ibmmca.txt                                |   36 -
 Documentation/scsi/megaraid.txt                              |    4 
 Documentation/scsi/ncr53c8xx.txt                             |   20 
 Documentation/scsi/osst.txt                                  |    3 
 Documentation/scsi/ppa.txt                                   |    2 
 Documentation/scsi/scsi-changer.txt                          |    2 
 Documentation/scsi/scsi_eh.txt                               |    4 
 Documentation/scsi/st.txt                                    |    4 
 Documentation/scsi/sym53c8xx_2.txt                           |    4 
 Documentation/scsi/tmscsim.txt                               |    4 
 Documentation/sh/kgdb.txt                                    |    2 
 Documentation/sound/alsa/ALSA-Configuration.txt              |   26 -
 Documentation/sound/alsa/Audiophile-Usb.txt                  |    2 
 Documentation/sound/alsa/CMIPCI.txt                          |    6 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    2 
 Documentation/sound/alsa/MIXART.txt                          |    6 
 Documentation/sound/alsa/Procfile.txt                        |   10 
 Documentation/sound/oss/AWE32                                |    2 
 Documentation/sound/oss/solo1                                |    2 
 Documentation/sound/oss/ultrasound                           |    2 
 Documentation/sound/oss/vwsnd                                |    2 
 Documentation/sparc/sbus_drivers.txt                         |    6 
 Documentation/spi/pxa2xx                                     |    6 
 Documentation/spi/spi-summary                                |    4 
 Documentation/stable_kernel_rules.txt                        |    4 
 Documentation/uml/UserModeLinux-HOWTO.txt                    |   66 ---
 Documentation/unshare.txt                                    |    2 
 Documentation/usb/URB.txt                                    |    2 
 Documentation/usb/acm.txt                                    |   14 
 Documentation/usb/error-codes.txt                            |    4 
 Documentation/usb/hiddev.txt                                 |    2 
 Documentation/usb/mtouchusb.txt                              |    6 
 Documentation/usb/usb-serial.txt                             |   11 
 Documentation/video4linux/README.pvrusb2                     |    2 
 Documentation/video4linux/Zoran                              |    2 
 Documentation/video4linux/cx2341x/fw-decoder-api.txt         |    2 
 Documentation/video4linux/cx2341x/fw-encoder-api.txt         |    2 
 Documentation/video4linux/cx2341x/fw-osd-api.txt             |    2 
 Documentation/video4linux/cx88/hauppauge-wintv-cx88-ir.txt   |    2 
 Documentation/video4linux/et61x251.txt                       |    4 
 Documentation/video4linux/hauppauge-wintv-cx88-ir.txt        |    2 
 Documentation/video4linux/meye.txt                           |    2 
 Documentation/video4linux/sn9c102.txt                        |    4 
 Documentation/video4linux/w9968cf.txt                        |    2 
 Documentation/video4linux/zr36120.txt                        |    4 
 Documentation/vm/numa                                        |    2 
 Documentation/watchdog/watchdog-api.txt                      |    8 
 Documentation/x86_64/boot-options.txt                        |    2 
 arch/alpha/Kconfig                                           |    2 
 arch/alpha/kernel/alpha_ksyms.c                              |    2 
 arch/alpha/kernel/head.S                                     |    2 
 arch/alpha/kernel/machvec_impl.h                             |    2 
 arch/alpha/lib/dbg_stackcheck.S                              |    2 
 arch/alpha/lib/dbg_stackkill.S                               |    2 
 arch/alpha/lib/memset.S                                      |    2 
 arch/arm/Kconfig                                             |    2 
 arch/arm/boot/compressed/head-clps7500.S                     |    2 
 arch/arm/common/sa1111.c                                     |    2 
 arch/arm/mach-imx/leds.c                                     |    2 
 arch/arm/mach-imx/leds.h                                     |    2 
 arch/arm/mach-ixp4xx/coyote-pci.c                            |    2 
 arch/arm/mach-ixp4xx/ixdpg425-pci.c                          |    2 
 arch/arm/mach-lh7a40x/arch-lpd7a40x.c                        |    2 
 arch/arm/mach-omap1/serial.c                                 |    2 
 arch/arm/mach-omap2/board-apollon.c                          |    2 
 arch/arm/mach-omap2/board-generic.c                          |    2 
 arch/arm/mach-omap2/board-h4.c                               |    2 
 arch/arm/mach-omap2/irq.c                                    |    2 
 arch/arm/mach-omap2/prcm-regs.h                              |    2 
 arch/arm/mach-omap2/serial.c                                 |    2 
 arch/arm/mach-omap2/sram-fn.S                                |    2 
 arch/arm/mach-pxa/corgi_lcd.c                                |    2 
 arch/arm/mach-pxa/leds.h                                     |    2 
 arch/arm/mach-s3c2410/Kconfig                                |    2 
 arch/arm/mach-s3c2410/s3c2400-gpio.c                         |    2 
 arch/arm/mach-s3c2410/s3c2410-clock.c                        |    2 
 arch/arm/mach-s3c2410/s3c2410-gpio.c                         |    2 
 arch/arm/mach-s3c2410/s3c2442.c                              |    2 
 arch/arm/mach-s3c2410/s3c244x-irq.c                          |    2 
 arch/arm/mach-s3c2410/s3c244x.h                              |    2 
 arch/arm/mach-s3c2410/usb-simtec.h                           |    2 
 arch/arm/mach-sa1100/dma.c                                   |    2 
 arch/arm/mach-shark/leds.c                                   |    2 
 arch/arm/plat-omap/sram-fn.S                                 |    2 
 arch/cris/arch-v10/drivers/Kconfig                           |    4 
 arch/cris/arch-v32/Kconfig                                   |    2 
 arch/h8300/kernel/ints.c                                     |    2 
 arch/i386/Kconfig                                            |    2 
 arch/i386/kernel/cpu/common.c                                |    3 
 arch/i386/kernel/efi.c                                       |    3 
 arch/i386/kernel/ldt.c                                       |    2 
 arch/i386/mach-visws/visws_apic.c                            |    2 
 arch/i386/mm/discontig.c                                     |    3 
 arch/i386/mm/init.c                                          |    3 
 arch/i386/pci/fixup.c                                        |    2 
 arch/ia64/kernel/acpi-processor.c                            |    2 
 arch/ia64/kernel/entry.S                                     |    2 
 arch/ia64/kernel/irq_ia64.c                                  |    2 
 arch/ia64/sn/kernel/xpnet.c                                  |    2 
 arch/m68k/mm/motorola.c                                      |    2 
 arch/m68k/sun3/sun3dvma.c                                    |    2 
 arch/m68knommu/Kconfig                                       |    6 
 arch/m68knommu/platform/68328/head-pilot.S                   |    2 
 arch/mips/dec/boot/decstation.c                              |    2 
 arch/mips/dec/prom/call_o32.S                                |    2 
 arch/mips/mm/tlbex.c                                         |    2 
 arch/mips/pci/fixup-vr4133.c                                 |    2 
 arch/mips/tx4938/common/irq.c                                |    2 
 arch/parisc/kernel/entry.S                                   |    4 
 arch/powerpc/Kconfig                                         |    4 
 arch/powerpc/kernel/perfmon_fsl_booke.c                      |    2 
 arch/powerpc/oprofile/op_model_7450.c                        |    2 
 arch/powerpc/oprofile/op_model_fsl_booke.c                   |    2 
 arch/powerpc/platforms/83xx/mpc834x_sys.h                    |    2 
 arch/powerpc/platforms/85xx/mpc8540_ads.h                    |    2 
 arch/powerpc/platforms/85xx/mpc85xx.h                        |    2 
 arch/powerpc/platforms/85xx/mpc85xx_cds.h                    |    2 
 arch/powerpc/sysdev/ipic.c                                   |    2 
 arch/ppc/Kconfig                                             |    4 
 arch/ppc/boot/include/mpsc_defs.h                            |    2 
 arch/ppc/platforms/4xx/xparameters/xparameters.h             |    2 
 arch/ppc/platforms/85xx/Kconfig                              |   14 
 arch/ppc/platforms/lopec.h                                   |    2 
 arch/ppc/platforms/mpc8272ads_setup.c                        |    2 
 arch/ppc/platforms/mpc885ads_setup.c                         |    2 
 arch/ppc/platforms/mvme5100.h                                |    2 
 arch/ppc/platforms/powerpmc250.h                             |    2 
 arch/ppc/platforms/prpmc750.h                                |    2 
 arch/ppc/platforms/prpmc800.h                                |    2 
 arch/ppc/platforms/spruce.h                                  |    2 
 arch/sh/boards/bigsur/io.c                                   |    2 
 arch/sh/boards/bigsur/led.c                                  |    2 
 arch/sh/boards/ec3104/io.c                                   |    2 
 arch/sh/boards/hp6xx/setup.c                                 |    2 
 arch/sh/boards/mpc1211/led.c                                 |    2 
 arch/sh/boards/mpc1211/setup.c                               |    2 
 arch/sh/boards/renesas/hs7751rvoip/io.c                      |    2 
 arch/sh/boards/renesas/hs7751rvoip/pci.c                     |    2 
 arch/sh/boards/renesas/rts7751r2d/led.c                      |    2 
 arch/sh/boards/renesas/systemh/io.c                          |    2 
 arch/sh/boards/renesas/systemh/irq.c                         |    2 
 arch/sh/boards/renesas/systemh/setup.c                       |    2 
 arch/sh/boards/se/770x/led.c                                 |    2 
 arch/sh/boards/se/7751/led.c                                 |    2 
 arch/sh/boards/se/7751/pci.c                                 |    2 
 arch/sh/boards/superh/microdev/io.c                          |    2 
 arch/sh/boards/superh/microdev/led.c                         |    2 
 arch/sh/drivers/dma/dma-pvr2.c                               |    2 
 arch/sh/drivers/pci/dma-dreamcast.c                          |    2 
 arch/sh/drivers/pci/fixups-dreamcast.c                       |    2 
 arch/sh/drivers/pci/ops-bigsur.c                             |    2 
 arch/sh/drivers/pci/ops-dreamcast.c                          |    2 
 arch/sh/drivers/pci/ops-rts7751r2d.c                         |    2 
 arch/sh/kernel/cpu/ubc.S                                     |    2 
 arch/sh64/boot/compressed/misc.c                             |    2 
 arch/sh64/kernel/alphanum.c                                  |    2 
 arch/sh64/lib/c-checksum.c                                   |    2 
 arch/sh64/mach-cayman/led.c                                  |    2 
 arch/sh64/oprofile/op_model_null.c                           |    2 
 arch/sparc/kernel/sys_solaris.c                              |    2 
 arch/um/Kconfig                                              |    2 
 arch/um/Makefile                                             |    2 
 arch/um/drivers/line.c                                       |    2 
 arch/um/include/sysdep-x86_64/ptrace_user.h                  |    2 
 arch/v850/kernel/entry.S                                     |    2 
 arch/x86_64/Kconfig                                          |    2 
 arch/xtensa/Kconfig                                          |    4 
 arch/xtensa/kernel/module.c                                  |    2 
 arch/xtensa/kernel/pci-dma.c                                 |    2 
 arch/xtensa/kernel/pci.c                                     |    2 
 arch/xtensa/kernel/setup.c                                   |    2 
 arch/xtensa/kernel/syscalls.c                                |    2 
 arch/xtensa/lib/pci-auto.c                                   |    2 
 arch/xtensa/lib/usercopy.S                                   |    4 
 arch/xtensa/mm/pgtable.c                                     |    2 
 arch/xtensa/mm/tlb.c                                         |    2 
 drivers/acorn/block/mfmhd.c                                  |    2 
 drivers/acpi/Kconfig                                         |    6 
 drivers/block/Kconfig                                        |    5 
 drivers/cdrom/cdrom.c                                        |    2 
 drivers/char/hw_random/ixp4xx-rng.c                          |    2 
 drivers/char/hw_random/omap-rng.c                            |    2 
 drivers/char/ite_gpio.c                                      |   14 
 drivers/char/mwave/README                                    |    5 
 drivers/char/watchdog/ixp2000_wdt.c                          |    2 
 drivers/char/watchdog/ixp4xx_wdt.c                           |    2 
 drivers/firmware/Kconfig                                     |    2 
 drivers/firmware/edd.c                                       |    2 
 drivers/i2c/busses/Kconfig                                   |    4 
 drivers/i2c/busses/i2c-ibm_iic.c                             |    2 
 drivers/i2c/busses/i2c-ibm_iic.h                             |    2 
 drivers/i2c/busses/i2c-ixp4xx.c                              |    2 
 drivers/i2c/busses/scx200_i2c.c                              |    2 
 drivers/ide/h8300/ide-h8300.c                                |    2 
 drivers/ide/ppc/pmac.c                                       |    2 
 drivers/ieee1394/Kconfig                                     |    2 
 drivers/infiniband/ulp/ipoib/Kconfig                         |    2 
 drivers/input/joystick/Kconfig                               |    2 
 drivers/input/keyboard/Kconfig                               |    2 
 drivers/input/serio/Kconfig                                  |    4 
 drivers/isdn/hardware/eicon/Kconfig                          |    2 
 drivers/isdn/hisax/Kconfig                                   |    2 
 drivers/isdn/hisax/amd7930_fn.h                              |    2 
 drivers/leds/led-class.c                                     |    2 
 drivers/leds/leds-locomo.c                                   |    2 
 drivers/macintosh/Kconfig                                    |    2 
 drivers/macintosh/adbhid.c                                   |    2 
 drivers/md/md.c                                              |    3 
 drivers/md/raid5.c                                           |    2 
 drivers/media/dvb/cinergyT2/Kconfig                          |    2 
 drivers/media/radio/Kconfig                                  |    3 
 drivers/media/video/Kconfig                                  |    2 
 drivers/media/video/cx88/Kconfig                             |    2 
 drivers/media/video/pwc/philips.txt                          |    4 
 drivers/mtd/chips/Kconfig                                    |    2 
 drivers/mtd/maps/bast-flash.c                                |    2 
 drivers/mtd/maps/dmv182.c                                    |    2 
 drivers/mtd/nand/Kconfig                                     |    2 
 drivers/mtd/onenand/Kconfig                                  |    2 
 drivers/net/Kconfig                                          |    2 
 drivers/net/arm/am79c961a.h                                  |    2 
 drivers/net/ibm_emac/ibm_emac_debug.h                        |    2 
 drivers/net/ibm_emac/ibm_emac_rgmii.h                        |    2 
 drivers/net/tokenring/tmspci.c                               |    3 
 drivers/net/wireless/Kconfig                                 |    2 
 drivers/parisc/power.c                                       |    2 
 drivers/parport/daisy.c                                      |  212 +++++-----
 drivers/pci/hotplug/Kconfig                                  |    2 
 drivers/rapidio/Kconfig                                      |    2 
 drivers/rtc/rtc-max6902.c                                    |    2 
 drivers/sbus/char/cpwatchdog.c                               |    2 
 drivers/scsi/Kconfig                                         |    6 
 drivers/scsi/aic7xxx/Kconfig.aic79xx                         |    4 
 drivers/scsi/aic7xxx/Kconfig.aic7xxx                         |    4 
 drivers/scsi/arm/arxescsi.c                                  |    2 
 drivers/serial/21285.c                                       |    2 
 drivers/serial/Kconfig                                       |    6 
 drivers/serial/cpm_uart/cpm_uart_cpm1.h                      |    2 
 drivers/serial/cpm_uart/cpm_uart_cpm2.h                      |    2 
 drivers/usb/atm/Kconfig                                      |    2 
 drivers/usb/core/file.c                                      |    2 
 drivers/usb/core/usb.c                                       |    2 
 drivers/usb/gadget/Kconfig                                   |    2 
 drivers/usb/storage/Kconfig                                  |    2 
 drivers/video/Kconfig                                        |   10 
 drivers/video/s3c2410fb.h                                    |    2 
 drivers/w1/Kconfig                                           |    2 
 fs/Kconfig                                                   |   18 
 fs/befs/befs_fs_types.h                                      |    2 
 fs/cifs/README                                               |    6 
 fs/debugfs/inode.c                                           |    2 
 fs/hfsplus/part_tbl.c                                        |    2 
 fs/jbd/commit.c                                              |    2 
 fs/jbd/journal.c                                             |    2 
 fs/nfsd/nfs2acl.c                                            |    2 
 fs/nfsd/nfs4xdr.c                                            |    3 
 fs/nfsd/nfsxdr.c                                             |    2 
 fs/nls/nls_ascii.c                                           |    2 
 fs/nls/nls_base.c                                            |    2 
 fs/nls/nls_cp1250.c                                          |    2 
 fs/nls/nls_cp1251.c                                          |    2 
 fs/nls/nls_cp1255.c                                          |    2 
 fs/nls/nls_cp437.c                                           |    2 
 fs/nls/nls_cp737.c                                           |    2 
 fs/nls/nls_cp775.c                                           |    2 
 fs/nls/nls_cp850.c                                           |    2 
 fs/nls/nls_cp852.c                                           |    2 
 fs/nls/nls_cp855.c                                           |    2 
 fs/nls/nls_cp857.c                                           |    2 
 fs/nls/nls_cp860.c                                           |    2 
 fs/nls/nls_cp861.c                                           |    2 
 fs/nls/nls_cp862.c                                           |    2 
 fs/nls/nls_cp863.c                                           |    2 
 fs/nls/nls_cp864.c                                           |    2 
 fs/nls/nls_cp865.c                                           |    2 
 fs/nls/nls_cp866.c                                           |    2 
 fs/nls/nls_cp869.c                                           |    2 
 fs/nls/nls_cp874.c                                           |    2 
 fs/nls/nls_cp932.c                                           |    2 
 fs/nls/nls_cp936.c                                           |    2 
 fs/nls/nls_cp949.c                                           |    2 
 fs/nls/nls_cp950.c                                           |    2 
 fs/nls/nls_euc-jp.c                                          |    2 
 fs/nls/nls_iso8859-1.c                                       |    2 
 fs/nls/nls_iso8859-13.c                                      |    2 
 fs/nls/nls_iso8859-14.c                                      |    2 
 fs/nls/nls_iso8859-15.c                                      |    2 
 fs/nls/nls_iso8859-2.c                                       |    2 
 fs/nls/nls_iso8859-3.c                                       |    2 
 fs/nls/nls_iso8859-4.c                                       |    2 
 fs/nls/nls_iso8859-5.c                                       |    2 
 fs/nls/nls_iso8859-6.c                                       |    2 
 fs/nls/nls_iso8859-7.c                                       |    2 
 fs/nls/nls_iso8859-9.c                                       |    2 
 fs/nls/nls_koi8-r.c                                          |    2 
 fs/nls/nls_koi8-ru.c                                         |    2 
 fs/nls/nls_koi8-u.c                                          |    2 
 fs/reiserfs/file.c                                           |    6 
 fs/reiserfs/item_ops.c                                       |   12 
 fs/reiserfs/journal.c                                        |   49 --
 fs/reiserfs/namei.c                                          |    9 
 fs/reiserfs/stree.c                                          |    4 
 fs/xfs/support/debug.c                                       |    6 
 include/asm-arm/arch-clps711x/entry-macro.S                  |    2 
 include/asm-arm/arch-ebsa285/entry-macro.S                   |    2 
 include/asm-arm/arch-h720x/system.h                          |    2 
 include/asm-arm/arch-ixp4xx/system.h                         |    2 
 include/asm-arm/arch-omap/dmtimer.h                          |    2 
 include/asm-arm/arch-omap/mcbsp.h                            |    2 
 include/asm-arm/arch-omap/pm.h                               |    2 
 include/asm-arm/arch-pnx4008/platform.h                      |    2 
 include/asm-arm/arch-s3c2410/fb.h                            |    2 
 include/asm-arm/arch-s3c2410/regs-adc.h                      |    2 
 include/asm-arm/arch-s3c2410/regs-clock.h                    |    2 
 include/asm-arm/arch-s3c2410/regs-dsc.h                      |    2 
 include/asm-arm/arch-s3c2410/regs-gpio.h                     |    2 
 include/asm-arm/arch-s3c2410/regs-gpioj.h                    |    2 
 include/asm-arm/arch-s3c2410/regs-iis.h                      |    2 
 include/asm-arm/arch-s3c2410/regs-irq.h                      |    2 
 include/asm-arm/arch-s3c2410/regs-lcd.h                      |    2 
 include/asm-arm/arch-s3c2410/regs-rtc.h                      |    2 
 include/asm-arm/arch-s3c2410/regs-sdi.h                      |    2 
 include/asm-arm/arch-s3c2410/regs-timer.h                    |    2 
 include/asm-arm/arch-s3c2410/regs-udc.h                      |    2 
 include/asm-arm/arch-s3c2410/spi-gpio.h                      |    2 
 include/asm-arm/arch-sa1100/neponset.h                       |    2 
 include/asm-arm/arch-sa1100/uncompress.h                     |    2 
 include/asm-arm/arch-shark/vmalloc.h                         |    2 
 include/asm-arm/hardware/debug-8250.S                        |    2 
 include/asm-arm/hardware/debug-pl01x.S                       |    2 
 include/asm-arm/hardware/entry-macro-iomd.S                  |    2 
 include/asm-arm/hardware/sa1111.h                            |    2 
 include/asm-arm26/assembler.h                                |    2 
 include/asm-arm26/namei.h                                    |    2 
 include/asm-arm26/semaphore.h                                |    2 
 include/asm-frv/namei.h                                      |    2 
 include/asm-generic/mutex-dec.h                              |    2 
 include/asm-generic/mutex-null.h                             |    2 
 include/asm-generic/mutex-xchg.h                             |    2 
 include/asm-generic/rtc.h                                    |    2 
 include/asm-generic/tlb.h                                    |    2 
 include/asm-m32r/m32104ut/m32104ut_pld.h                     |    2 
 include/asm-m32r/m32700ut/m32700ut_lan.h                     |    2 
 include/asm-m32r/m32700ut/m32700ut_lcd.h                     |    2 
 include/asm-m32r/m32700ut/m32700ut_pld.h                     |    2 
 include/asm-m32r/mappi2/mappi2_pld.h                         |    2 
 include/asm-m32r/mappi3/mappi3_pld.h                         |    2 
 include/asm-m32r/opsput/opsput_lan.h                         |    2 
 include/asm-m32r/opsput/opsput_lcd.h                         |    2 
 include/asm-m32r/opsput/opsput_pld.h                         |    2 
 include/asm-m68k/rtc.h                                       |    2 
 include/asm-m68knommu/processor.h                            |    2 
 include/asm-mips/tx4938/tx4938_mips.h                        |    2 
 include/asm-parisc/rtc.h                                     |    2 
 include/asm-powerpc/ipic.h                                   |    2 
 include/asm-ppc/mv64x60_defs.h                               |    2 
 include/asm-ppc/rheap.h                                      |    2 
 include/asm-ppc/rtc.h                                        |    2 
 include/asm-s390/qdio.h                                      |    2 
 include/asm-sh/bigsur/io.h                                   |    2 
 include/asm-sh/bigsur/serial.h                               |    2 
 include/asm-sh/dreamcast/sysasic.h                           |    2 
 include/asm-sh/hd64465/io.h                                  |    2 
 include/asm-sh/mpc1211/io.h                                  |    2 
 include/asm-sh64/serial.h                                    |    2 
 include/asm-sparc/reg.h                                      |    2 
 include/asm-x86_64/cache.h                                   |    2 
 include/asm-xtensa/a.out.h                                   |    2 
 include/asm-xtensa/cache.h                                   |    2 
 include/asm-xtensa/coprocessor.h                             |    2 
 include/asm-xtensa/dma-mapping.h                             |    2 
 include/asm-xtensa/ioctls.h                                  |    2 
 include/asm-xtensa/pgtable.h                                 |    2 
 include/asm-xtensa/siginfo.h                                 |    2 
 include/linux/aio_abi.h                                      |    2 
 include/linux/awe_voice.h                                    |    2 
 include/linux/harrier_defs.h                                 |    2 
 include/linux/lockd/xdr4.h                                   |    2 
 include/linux/mtd/plat-ram.h                                 |    2 
 include/linux/nfsd/stats.h                                   |    2 
 include/linux/nfsd/xdr.h                                     |    2 
 include/linux/ppdev.h                                        |    2 
 include/linux/slab.h                                         |    2 
 include/linux/sunrpc/auth_gss.h                              |    2 
 include/linux/sunrpc/gss_api.h                               |    2 
 include/linux/sunrpc/msg_prot.h                              |    2 
 include/linux/sunrpc/svcauth_gss.h                           |    2 
 include/linux/writeback.h                                    |    2 
 include/video/s1d13xxxfb.h                                   |    2 
 ipc/mqueue.c                                                 |    2 
 ipc/msgutil.c                                                |    2 
 kernel/posix-timers.c                                        |    2 
 kernel/rcutorture.c                                          |    2 
 kernel/workqueue.c                                           |    2 
 lib/reed_solomon/reed_solomon.c                              |    2 
 mm/Kconfig                                                   |    4 
 mm/nommu.c                                                   |    2 
 mm/page-writeback.c                                          |    2 
 mm/vmalloc.c                                                 |    6 
 net/ipv4/Kconfig                                             |    6 
 net/ipv4/arp.c                                               |    2 
 net/ipv4/ipvs/Kconfig                                        |    4 
 net/ipv4/netfilter/Kconfig                                   |    2 
 net/sunrpc/auth_gss/auth_gss.c                               |    2 
 scripts/kernel-doc                                           |    4 
 security/selinux/Kconfig                                     |    4 
 sound/oss/Kconfig                                            |    2 
 sound/oss/ad1848.c                                           |    2 
 sound/oss/ad1848_mixer.h                                     |    2 
 sound/oss/adlib_card.c                                       |    2 
 sound/oss/audio.c                                            |    2 
 sound/oss/awe_hw.h                                           |    2 
 sound/oss/awe_wave.c                                         |    2 
 sound/oss/awe_wave.h                                         |    2 
 sound/oss/dev_table.c                                        |    2 
 sound/oss/dmabuf.c                                           |    2 
 sound/oss/gus_card.c                                         |    2 
 sound/oss/gus_midi.c                                         |    2 
 sound/oss/gus_wave.c                                         |    2 
 sound/oss/harmony.c                                          |    2 
 sound/oss/ics2101.c                                          |    2 
 sound/oss/iwmem.h                                            |    2 
 sound/oss/maui.c                                             |    2 
 sound/oss/midi_synth.c                                       |    2 
 sound/oss/midibuf.c                                          |    2 
 sound/oss/mpu401.c                                           |    2 
 sound/oss/opl3.c                                             |    2 
 sound/oss/opl3sa.c                                           |    2 
 sound/oss/opl3sa2.c                                          |    2 
 sound/oss/pas2_card.c                                        |    2 
 sound/oss/pas2_midi.c                                        |    2 
 sound/oss/pas2_mixer.c                                       |    2 
 sound/oss/pss.c                                              |    2 
 sound/oss/sb_audio.c                                         |    2 
 sound/oss/sb_common.c                                        |    2 
 sound/oss/sb_midi.c                                          |    2 
 sound/oss/sb_mixer.c                                         |    2 
 sound/oss/sb_mixer.h                                         |    2 
 sound/oss/sequencer.c                                        |    2 
 sound/oss/sgalaxy.c                                          |    2 
 sound/oss/sound_timer.c                                      |    2 
 sound/oss/soundcard.c                                        |    2 
 sound/oss/sscape.c                                           |    2 
 sound/oss/sys_timer.c                                        |    2 
 sound/oss/trix.c                                             |    2 
 sound/oss/uart401.c                                          |    2 
 sound/oss/uart6850.c                                         |    2 
 sound/oss/v_midi.c                                           |    2 
 sound/oss/waveartist.c                                       |    2 
 sound/oss/waveartist.h                                       |    2 
 sound/oss/wf_midi.c                                          |    2 
 598 files changed, 1103 insertions(+), 1341 deletions(-)

