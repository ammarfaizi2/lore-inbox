Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSFXVRc>; Mon, 24 Jun 2002 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSFXVRb>; Mon, 24 Jun 2002 17:17:31 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5388 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315279AbSFXVRa>; Mon, 24 Jun 2002 17:17:30 -0400
Date: Mon, 24 Jun 2002 23:17:26 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.19-rc1 ChangeLog Summary
Message-ID: <20020624211726.GA21764@merlin.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the ChangeLog summary, pulled from BK.

Note: some people are listed by user@h.o.s.t, not by their names. If you
have first-hand information about whom these user@h.o.s.t belong to,
drop me a note (privately, not to the list, please).

v2.4.19-pre10 -> v2.4.19-rc1
============================

  o 3ware driver update for 2.4                               (adam@nmt.edu)
  o fix .text.exit compile error in sstfb.c                    (Adrian Bunk)
  o disable CONFIG_IEEE1394_PCILYNX_PORTS config option        (Adrian Bunk)
  o missing clean                                                 (Alan Cox)
  o rest of SIGURG changes                                        (Alan Cox)
  o barrier didnt go away                                         (Alan Cox)
  o sisfb header I forgot last time                               (Alan Cox)
  o more pci idents we use in kernel now                          (Alan Cox)
  o ; make readv/writev SuS compliant                             (Alan Cox)
  o Configure.help bits                                           (Alan Cox)
  o fix wrong __init in neofb                                     (Alan Cox)
  o switch audio to static inline                                 (Alan Cox)
  o switch s/390 drivers to static inline                         (Alan Cox)
  o switch hamradio drivers to static inline                      (Alan Cox)
  o a few more static inlines                                     (Alan Cox)
  o switch mpt fusion to static inline                            (Alan Cox)
  o fix link error in video4linux                                 (Alan Cox)
  o switch pms to static inline                                   (Alan Cox)
  o switch bw-qcam to static inline                               (Alan Cox)
  o switch isdn to static inline                                  (Alan Cox)
  o switch specialix to static inline                             (Alan Cox)
  o switch isicom to static inline                                (Alan Cox)
  o switch ftape to static inline                                 (Alan Cox)
  o Fix i830 agp error on 8+8Mb split,                            (Alan Cox)
  o ramdisk efault fix                                            (Alan Cox)
  o remove dead probe code                                        (Alan Cox)
  o more url changes                                              (Alan Cox)
  o url changes                                                   (Alan Cox)
  o update urls                                                   (Alan Cox)
  o Make panic blink configurable                               (Andi Kleen)
  o Another fix for the RAID-5 inline assembly                  (Andi Kleen)
  o Fix incorrect inline assembly for RAID-5                    (Andi Kleen)
  o Remove debug code from /proc/stat                        (Andrew Morton)
  o rivafb fix                                                   (Ani Joshi)
  o misc fixes for 2.4.19-pre10                           (Benjamin LaHaise)
  o ns83820 v0.18 update                                  (Benjamin LaHaise)
  o highmem pci dma mapping does not work, missing cast in asm-i386/pci.h
                                                          (Benjamin LaHaise)
  o Bonding driver: Add multicast support                   (Chad N. Tindel)
  o add missing 2.5 compatible kdev_t bits               (Christoph Hellwig)
  o don't export vmalloc_to_page() gplonly               (Christoph Hellwig)
  o don't export walk_gendisk()                          (Christoph Hellwig)
  o Tigon3: More fiber PHY tweaks                          (David S. Miller)
  o ip-sysctl.txt fixes                                    (David S. Miller)
  o Tigon3: Make fibre PHY support work                    (David S. Miller)
  o tg3.c: Fix typo in GA302T board ID                     (David S. Miller)
  o AF_PACKET: Clear out packet-mmap pages                 (David S. Miller)
  o CyberPro 32bit support and other fixes              (Denis Oliver Kropp)
  o Re: [PATCH] printk KERN_* in 3c501 driver        (felipewd@terra.com.br)
  o ipconfig.c: Fix defined but not used warnings              (Frank Davis)
  o fix error handling in video_open()                          (Gerd Knorr)
  o PCI Hotplug ACPI driver minor fix                   (Greg Kroah-Hartman)
  o swap 4/4 redundant SwapCache checks                       (Hugh Dickins)
  o swap 3/4 unsafe Dirty check                               (Hugh Dickins)
  o swap 2/4 unsafe SwapCache check                           (Hugh Dickins)
  o swap 1/4 swapon memleak                                   (Hugh Dickins)
  o tmpfs 4/4 swapoff tweaks                                  (Hugh Dickins)
  o tmpfs 3/4 partial truncate                                (Hugh Dickins)
  o tmpfs 2/4 mknod times                                     (Hugh Dickins)
  o tmpfs 1/4 symlink unwind                                  (Hugh Dickins)
  o tridentfb update                                            (jani@iv.ro)
  o Reserve 2.5.x extended attribute syscall numbers, for alpha port
                                                               (Jeff Garzik)
  o Update 8139 net drivers for the following fixes            (Jeff Garzik)
  o ISDN: Fix oops when unloading drivers in non LIFO order
                                                         (Kai Germaschewski)
  o 2.4.19-pre10 Enforce uts limit, use LANG=C for date/time   (Keith Owens)
  o Convert drivers/net/wan/8253x to kernel build              (Keith Owens)
  o HCDP serial ports                                          (Khalid Aziz)
  o Makefile                                               (Marcelo Tosatti)
  o Add support for HP Diva serial ports                    (Matthew Wilcox)
  o Remove SERIAL_IO_GSC                                    (Matthew Wilcox)
  o Serial driver iomem fixes                               (Matthew Wilcox)
  o fs/ufs/super.c:ufs_read_super() fixes                (Mikael Pettersson)
  o Documentation Update                           (mostrows@watson.ibm.com)
  o Update for arch/i386/defconfig              (Niels Kristian Bech Jensen)
  o icache coherency on cleared pages                       (Paul Mackerras)
  o Fix s390 partition bug in 2.4.19-pre7                     (Pete Zaitcev)
  o Fix cache-attribute conflict bug on newer AMD Athlon   (Richard Brunner)
  o Trivial, IDE geometry fix / defconfig changes           (Robert Cardell)
  o fix for sigio delivery                                   (Rusty Russell)
  o Re: Kernel zombie threads after module removal           (Rusty Russell)
  o Re: TRIVIAL: William Lee Irwin III: buddy system comment (Rusty Russell)
  o APM patch for idle_period handling                       (Rusty Russell)
  o Fix compilation warning in do_mounts.c (Fixed by Rusty)  (Rusty Russell)
  o TAGS should include arch dir                             (Rusty Russell)
  o Finally squish those chrp_start.c warnings               (Rusty Russell)
  o Re: mislabelled label patch                              (Rusty Russell)
  o Remove bogus casts in ide-cd.c                           (Rusty Russell)
  o typo in smt.h                                            (Rusty Russell)
  o typo in jazz_esp.c                                       (Rusty Russell)
  o typo in aic7xxx_core.c                                   (Rusty Russell)
  o Typo in radeonfb.c printk()                              (Rusty Russell)
  o Re: nbd.c warning fix                                    (Rusty Russell)
  o Fix bashisms in scripts_patch-kernel                     (Rusty Russell)
  o II ipchains bugs in 2.2_2.4_2.5 related to netlink calls (Rusty Russell)
  o Fix spinlock goof in w83877f watchdog driver
                                              (snailtalk@linux-mandrake.com)
  o Add includes necessary for Alpha AXP platform, to these drivers
                                              (snailtalk@linux-mandrake.com)
  o Fix booting of some machines when loaded into                 (Tom Rini)
  o Fix compilation of CONFIG_UCODE_PATCH=y                       (Tom Rini)
  o Fix corner cases of building SA1100/M8xx PCMCIA support       (Tom Rini)
  o 2.4.19-pre10 - i8xx series chipsets patches (patch 5) (Wim Van Sebroeck)
  o 2.4.19-pre10 - i8xx series chipsets patches (patch 4) (Wim Van Sebroeck)
  o 2.4.19-pre10 - i8xx series chipsets patches (patch 3) (Wim Van Sebroeck)
  o 2.4.19-pre10 - i8xx series chipsets patches (patch 2) (Wim Van Sebroeck)
  o 2.4.19-pre10 - i8xx series chipsets patches (patch 1) (Wim Van Sebroeck)
