Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFABBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFABBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 21:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVFABBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 21:01:54 -0400
Received: from hera.kernel.org ([209.128.68.125]:28577 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261197AbVFAA5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 20:57:41 -0400
Date: Tue, 31 May 2005 17:57:38 -0700
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200506010057.j510vckZ001617@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.31 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.31-rc2 was released as 2.4.31 with no changes.


Summary of changes from v2.4.31-rc1 to v2.4.31-rc2
============================================

Marcelo Tosatti:
  o Change VERSION to 2.4.31-rc2

Willy Tarreau:
  o off-by-one in mtrr.c found by Brad Spengler and reported by Julien Tinnes
  o IPVS: Replace several unchecked strcpy() with strncpy() (PaX team)

Summary of changes from v2.4.31-pre2 to v2.4.31-rc1
============================================

<aleksey_gorelov:phoenix.com>:
  o Fix bug in VIA 82C586B PCI IRQ routing

<julien.tinnes:francetelecom.com>:
  o Off-by-one in loop.c

<mkasick:club.cc.cmu.edu>:
  o JFS oops fix

<vvs:sw.ru>:
  o random poolsize sysctl fix

<wtarreau:exosec.fr>:
  o fix compilation error introduced by moxa correction

Christoph Hellwig:
  o XFS: fix compilation error

David S. Miller:
  o Add basic bcm5752 support
  o Add bcm5752 to tg3_pci_tbl
  o Add bcm5752 entry to pci_ids.h
  o use TG3_FLG2_5705_PLUS instead of multi-way if's
  o define TG3_FLG2_5750_PLUS flag
  o use new TG3_FLG2_5750_PLUS flag
  o more use of TG3_FLG2_5705_PLUS flag
  o use TG3_FLG2_57{05,50}_PLUS flags in tg3_get_invariants
  o check TG3_FLG2_5750_PLUS flag to set TG3_FLG2_5705_PLUS flag
  o add support for bcm5752 rev a1
  o Minor 5752 fixes
  o Split tg3_phy_probe into 2
  o Setup proper GPIO settings
  o Fix tg3_set_power_state()
  o Workaround 5752 A0 chip ID
  o Add GPIO3 for 5752
  o Add nvram detection for 5752
  o Add nvram lock-out support for
  o Fix bug in tg3_set_eeprom()
  o Add msi support
  o Add msi test
  o Update driver version and release date
  o Set SA_SAMPLE_RANDOM in request_irq() calls
  o Elide tg3_stop_block messages when such events are normal
  o Ignore tg3_stop_block() errors
  o Add tagged status support
  o Set minimal hw interrupt mitigation
  o Refine DMA boundary setting
  o In tg3_poll(), resample status_tag after doing work
  o Fix stretch ACK performance killer when doing ucopy
  o Fix off-by-one error in rtnetlink.c

Luca Tettamanti:
  o fbmem: previous radeonfb fix limits the amount of mmap()'able VRAM to the same amount reserved for the framebuffer

Marcelo Tosatti:
  o USB: fix oops in io_edgeport.c driver (2.6 backport)
  o Change VERSION to 2.4.31-rc1

Mikael Pettersson:
  o x86_64 linkage error on UP_IOAPIC

Mike Miller:
  o cciss: fix for passthru ioctls

Suresh B. Siddha:
  o x86_64: fix pci config space access race condition
  o x86_64: Try harder to allocate memory in pci_alloc_consistent()

Willy Tarreau:
  o floppy typo fix

Xose Vazquez Perez:
  o Add 5752M device ID


Summary of changes from v2.4.31-pre1 to v2.4.31-pre2
============================================

<carlos.pardo:siliconimage.com>:
  o sata_sil: Fix FIFO PCI Bus Arbitration

<david.monniaux:ens.fr>:
  o fix moxa crash with more than one 1 board

<jason.d.gaston:intel.com>:
  o SATA AHCI correction Intel ICH7R

Brett Russ:
  o AHCI: fix fatal error int handling
  o libata: support descriptor sense in ctrl page

Chris Wright:
  o backport v2.6 elf_core_dump() flaw fix (CAN-2005-1263)

Eugene Surovegin:
  o ppc32: backport Book-E decrementer handling fix from 2.6

Jean Delvare:
  o I2C updates: Fix typo in a comment in i2c.h
  o I2C updates: Fix I2C_FUNC_* defines in i2c.h
  o I2C updates: Fix an iteration bug in the handling of i2c client module parameters

Jeff Garzik:
  o [libata ahci] support ->tf_read hook
  o [libata sata_sil] Don't presume PCI cache-line-size reg is > 0

Marcelo Tosatti:
  o Change EXTRAVERSION to 2.4.31-pre2

Mikael Pettersson:
  o rwsem-spinlock linkage error

Pete Zaitcev:
  o USB: Add HX type pl2303

Rolf Eike Beer:
  o typo fix in drivers/scsi/sata_svw.c comment

Steven HARDY:
  o pcnet32: 79C975 fiber fix

Willy Tarreau:
  o bonding fix


Summary of changes from v2.4.30 to v2.4.31-pre1
============================================

Adrian Bunk:
  o MAINTAINERS: remove obsolete ACP/MWAVE MODEM entry

Andi Kleen:
  o x86_64: Handle MM going away in context switch
  o x86_64: Backport 2.6 MTRR algorithms
  o x86_64: noexec=off never worked correctly for the kernel direct mappings
  o x86_64: Fix idle=poll
  o x86_64: Fix reference counting bug in change_page_attr on i386/x86-64
  o x86_64: Resend lost APIC IRQs on Uniprocessor too
  o x86_64: Avoid a obnoxious warning during build
  o x86_64: Flush correctly when more than one page is getting flushed
  o x86_64: Reload init_mm on leaving lazy mm

Andrew Morton:
  o rwsem: Make rwsems use interrupt disabling spinlocks

Herbert Xu:
  o [NETLINK]: Fix sk_rmem_alloc assertion failure in af_netlink.c

Hugh Dickins:
  o madvise_willneed -EIO beyond EOF

Marcelo Tosatti:
  o Change VERSION to 2.4.31-pre1

Pete Zaitcev:
  o visor: Add Zire 31 device ID

