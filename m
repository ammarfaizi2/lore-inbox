Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSE2MKt>; Wed, 29 May 2002 08:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSE2MKs>; Wed, 29 May 2002 08:10:48 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35597 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315178AbSE2MKr>; Wed, 29 May 2002 08:10:47 -0400
Date: Wed, 29 May 2002 14:10:40 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.19-pre9 ChangeLog Summary
Message-ID: <20020529121040.GD4452@merlin.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0205281905260.7798-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shameless OpenSource Promotion:

  Use the GPL'd lk-changelog.pl program to get the format below.
  lk-changelog.pl is available from http://mandree.home.pages.de/linux/kernel/

Summary of changes from v2.4.19-pre8 to v2.4.19-pre9
====================================================

  o give better information which chipsets hpt366.c is for     (Adrian Bunk)
  o CONFIG_AGP_HP_ZX1 should only be available on ia64         (Adrian Bunk)
  o doc thinko                                                    (Alan Cox)
  o wrong URL                                                     (Alan Cox)
  o I2O update first part                                         (Alan Cox)
  o I2O update                                                    (Alan Cox)
  o ufs/super.c fix                                         (Alexander Viro)
  o change_floppy(): O_NDELAY is needed when opening floppy for FD_EJECT
                                                            (Alexander Viro)
  o do_mounts.c printk fix                                  (Alexander Viro)
  o Fix panic for gcc 3.1                                       (Andi Kleen)
  o long -> unsigned long flags for softirq                     (Andi Kleen)
  o Fix acenic driver and 867 MHz G4 sound problems        (Anton Blanchard)
  o PPC 745x CPU updates                            (Benjamin Herrenschmidt)
  o PPC Small PCI fixes                             (Benjamin Herrenschmidt)
  o PPC PowerMac PCI fix                            (Benjamin Herrenschmidt)
  o PPC Missing pci_ids                             (Benjamin Herrenschmidt)
  o Add walk_gendisk                                (Benjamin Herrenschmidt)
  o PPC Updated Pmac root discovery                 (Benjamin Herrenschmidt)
  o PPC Updated MESH driver                         (Benjamin Herrenschmidt)
  o PPC planb driver update                         (Benjamin Herrenschmidt)
  o fix for /proc/stat                                    (Benjamin LaHaise)
  o arch/cris for 2.4.19-pre8                                  (Bjorn Wesen)
  o memsetup fixes (again)                               (Christoph Hellwig)
  o fix compile warning in ini/do_mount.c                (Christoph Hellwig)
  o cleanup/remove memlist wrappers                      (Christoph Hellwig)
  o fix gcc 3.1 compiler warnings in asm-i386/floppy.h   (Christoph Hellwig)
  o remove compile warning in drivers/pnp/isapnp.c       (Christoph Hellwig)
  o fix gcc 3.1 warnings in bfs                          (Christoph Hellwig)
  o fix gcc 3.1 warnings in drivers/i2c/i2c-core.c       (Christoph Hellwig)
  o gcc 3.1 fixes for fs/file.c                          (Christoph Hellwig)
  o gcc 3.1 fixes for drivers/block/ll_rw_blk.c          (Christoph Hellwig)
  o remove noisy printk in fs/block_device.c             (Christoph Hellwig)
  o ClearPageLaunder instead of opencoded bitops         (Christoph Hellwig)
  o fix ad1816 isapnp handling                           (Christoph Hellwig)
  o remove unused variable in fs/proc/proc_misc.c        (Christoph Hellwig)
  o copy_mm fix                                                (Colin Gibbs)
  o Sparc: Do not BUG in srmmu_pte_alloc_one.                  (Colin Gibbs)
  o include/asm-sparc/pgalloc.h: In pmd_alloc_one, dont BUG just return
    NULL                                                       (Colin Gibbs)
  o 2.4.19-pre7 usb-ohci and wmb()                          (David Brownell)
  o 2.4.19-pre7 sync ehci-hcd with 2.5                      (David Brownell)
  o 2.4.19-pre7 sync ehci.txt                               (David Brownell)
  o ehci -- interrupt xfer requeue                          (David Brownell)
  o 2.5.14 -- ehci misc fixes                               (David Brownell)
  o in_ntoa: Did not kill off all references properly.     (David S. Miller)
  o arch/sparc64/defconfig: Update.                        (David S. Miller)
  o arch/sparc/kernel/check_asm.sh                         (David S. Miller)
  o arch/sparc/kernel/check_asm.sh: Fix typo.              (David S. Miller)
  o arch/sparc/defconfig: Update.                          (David S. Miller)
  o soft-fp fix                                            (David S. Miller)
  o Sparc64 fix                                            (David S. Miller)
  o Sparc64: Make use of USE_STANDARD_AS_RULE.             (David S. Miller)
  o Sparc64 fixes                                          (David S. Miller)
  o Sparc: Fix unistd.h __NR_tkill numbers.                (David S. Miller)
  o Sparc64: Missed parts of math-emu fixes.               (David S. Miller)
  o Sparc fixes                                            (David S. Miller)
  o Sparc: Use dma_addr_t and size_t in sparc32 DMA function args.
                                                           (David S. Miller)
  o Sparc: More sparc32 dma_addr_t fixups.                 (David S. Miller)
  o drivers/net/sunlance.c: Make init_block_dvma a dma_addr_t
                                                           (David S. Miller)
  o JFFS2 update - fix double free in garbage-collecting hole nodes.
                                            (dwmw2@dwmw2.baythorne.internal)
  o OXSEMI 16PCI952 patch                                (edv@macrolink.com)
  o mucho trivial update to pci/quirks.c                    (Ghozlane Toumi)
  o USB io_edgeport driver                              (Greg Kroah-Hartman)
  o "noht" disable HyperThreading                             (Hugh Dickins)
  o 2.4.19-pre8  Coda update                                    (Jan Harkes)
  o Update to srm_env.c update (for Alpha arch.)         (Jan-Benedict Glaw)
  o alpha_using_srm (and calback) cleanup                (Jan-Benedict Glaw)
  o tridentfb doc update                                      (Jani Monoses)
  o tridentfb update                                            (jani@iv.ro)
  o Add two new AC97 codec ids to ac97_codec driver.           (Jeff Garzik)
  o Add I845G support to agpgart                      (jhartmann@addoes.com)
  o Here's another aic7xxx driver update.  This corrects the following
                                                           (Justin T. Gibbs)
  o Upgrade to v6.2.8 of the aic7xxx driver                (Justin T. Gibbs)
  o 6.2.8                                                  (Justin T. Gibbs)
  o Last minute changes for the 6.2.8 driver release.      (Justin T. Gibbs)
  o ISDN: Export all hisax symbols from drivers/isdn/hisax/config.o
                                                         (Kai Germaschewski)
  o ISDN: Update md5sums                                 (Kai Germaschewski)
  o 2.4.19-pre8 config bug fixes                               (Keith Owens)
  o 2.4.19-pre8 correct build of m8xx_pcmcia                   (Keith Owens)
  o 2.4.19-pre8 remove duplicate CONFIG_SOUND_EMU10K1          (Keith Owens)
  o ISDN: Add PPP statistics in bytes                  (kkeil@isdn4linux.de)
  o Fix small fsuid consistency issue                       (Linus Torvalds)
  o Fix PPPoATM crash on disconnection                       (Luca Barbieri)
  o linux 2.4.19-pre8: Critical signal handling fixes    (Maciej W. Rozycki)
  o 2.4.19-pre8 Intermezzo Compile Fix             (Marc-Christian Petersen)
  o Apply missing hunk of hpt366 patch                     (Marcelo Tosatti)
  o Add missing i2o patch part                             (Marcelo Tosatti)
  o Added missing "#" to ifdef                             (Marcelo Tosatti)
  o add missing include file                               (Marcelo Tosatti)
  o Changed EXTRAVERSION to pre9                           (Marcelo Tosatti)
  o remove spurious timer interrupts               (martin.bligh@us.ibm.com)
  o Compilation trouble in drivers/video                 (Michal Jaegermann)
  o fix 2.4.19-pre8 UP APIC breakage                     (Mikael Pettersson)
  o 2.4.19-pre7+ I/O-APIC inconsistency                  (Mikael Pettersson)
  o SysKonnect FDDI driver bugfixes                          (Mirko Lindner)
  o Fix umem compile problems                                   (Neil Brown)
  o kNFSd in 2.4.19-pre8 - small nfssvc.c changes               (Neil Brown)
  o md in 2.4.19-pre - Correctly abort recovery if raid         (Neil Brown)
  o 2.4.19-pre8  drivers/scsi/scsi_debug.c                     (Olaf Hering)
  o devfs race fix                             (oliver@oenone.homelinux.org)
  o USB host TASK_RUNNING fix                  (oliver@oenone.homelinux.org)
  o 2.4.19-pre8 get_pid() hang fix again                       (Paul Larson)
  o important PPC bugfix for 2.4.19-pre                     (Paul Mackerras)
  o pegasus driver update                          (petkan@mastika.lnxw.com)
  o Move MAX_BUF_PER_PAGE definition into the header file    (pkot@ziew.org)
  o Fix ips driver breakage on 2.4.19-pre8                      (Randy Hron)
  o 3270-console reboot bug fixed                      (rbh00@utsglobal.com)
  o Minor patch to 2.4 kernel                            (rhw@infradead.org)
  o Added BKL to <devfs_open> because drivers still need it. (Richard Gooch)
  o generic.h                                                (Richard Gooch)
  o types.h                                                  (Richard Gooch)
  o 2.4.19-pre8: drivers/scsi/sim710                         (Richard Hirst)
  o Sparc32 sun4c                                                (Rob Radez)
  o drivers/char/sc1200wdt.c                                     (Rob Radez)
  o drivers/char/advantechwdt.c                                  (Rob Radez)
  o Emu10k1 patch for 2.4.19pre8                                 (Rui Sousa)
  o Trivial declance updates                                 (Rusty Russell)
  o epic100 missing __devinit                                (Rusty Russell)
  o sundance missing __devinit                               (Rusty Russell)
  o TRIVIAL serial unload message                            (Rusty Russell)
  o add Tieman Voyager USB Braille display driver     (s.doyon@videotron.ca)
  o Fix for typo for NeoMagic in drivers/video/Config.in    (Scott Anderson)
  o Directory Notification Fix                            (Stephen Rothwell)
  o ] 2.4.19-pre8 small typo in signal code for cris      (Stephen Rothwell)
  o Sparc: Use proper sys_{read,write} prototypes in SunOS    (Tom Callaway)
  o Sparc64: Export batten_down_hatches                       (Tom Callaway)
  o drivers/video/aty/mach64_gx.c: Include sched.h            (Tom Callaway)
  o Sparc64: Put sys_tkill in correct systable slots.         (Tom Callaway)
  o 2.4.18, add missing MODULE_LICENSE tags in fs/             (Tomas Szepe)
  o adds support for USB Casio EM500                             (V. Ganesh)
  o HID blacklist update                                    (Vojtech Pavlik)
  o drivers/char/stallion.c                           (wayne@stallion.oz.au)
  o pl2303.c: do not reset termios settings in each open()  (Wolfgang Fritz)
