Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVEXURp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVEXURp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 16:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVEXURp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 16:17:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36830 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261992AbVEXURj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 16:17:39 -0400
Date: Tue, 24 May 2005 11:34:30 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.31-rc1
Message-ID: <20050524143430.GA12779@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here goes 2.4.31-rc1.

It contains a small number of simple scattered fixes and a 
tg3 update.

Refer to the changelog for details

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

