Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319504AbSIMDAk>; Thu, 12 Sep 2002 23:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319508AbSIMDAk>; Thu, 12 Sep 2002 23:00:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52750 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S319504AbSIMDAi>; Thu, 12 Sep 2002 23:00:38 -0400
Date: Thu, 12 Sep 2002 23:18:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre7
Message-ID: <Pine.LNX.4.44.0209122313470.30211-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes -pre7. Big MIPS and IA64 merge.

The on boot crashes with i845 should be fixed now.


Summary of changes from v2.4.20-pre6 to v2.4.20-pre7
============================================

<akpm@digeo.com>:
  o Sync up syscall table with 2.5

<alan@redhat.com>:
  o fix ramdisk cache flush

<fzago@austin.rr.com>:
  o [PATCH] (repost) fix for big endian machines in scanner.c

<hch@lst.de>:
  o inline grab_cache_page
  o cleanup try_to_free_pages naming
  o fix syscall prototypes in init/do_mounts.c

<mlang@delysid.org>:
  o HandyTech HandyLink patch

<paulus@au1.ibm.com>:
  o PPC32: Add extended attributes syscalls

<proski@gnu.org>:
  o 2.4.20-pre6: befs still not in fs/Makefile

<ralf@dea.linux-mips.net>:
  o mips
  o mips64
  o mips64-ip27
  o mips-sgi-ip22
  o mips-ip32
  o mips-mips
  o mips-sibyte
  o maintainers
  o drivers-net-mace
  o drivers-net
  o drivers-net
  o drivers-net
  o drivers-net
  o drivers-sgi
  o mips-cobalt
  o pci-ids
  o drivers-scsi
  o drivers-scsi
  o drivers-tc
  o drivers-ide
  o drivers-ide
  o mips-arc
  o mips-dec
  o mips-alchemy
  o mips-galileo-boards
  o drivers-video
  o drivers-video
  o mips-vr41xx
  o mips-momentum
  o mips-ddb
  o drivers-mtd
  o drivers-mtd

<thockin@freakshow.cobalt.com>:
  o NVRAM driver

<zwane@mwaikambo.name>:
  o trivial ohci fixes

Adrian Bunk <bunk@fs.tum.de>:
  o Configure.help entry for the ForteMedia FM801 driver
  o add Configure.help entries for CONFIG_USB_SERIAL_KEYSPAN_USA19Q{W,I}

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o IA64 sync

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: add permission checks before getting or setting xattrs

David Brownell <david-b@pacbell.net>:
  o usbcore updates

Geert Uytterhoeven <geert@linux-m68k.org>:
  o M68k extended attributes
  o Fixup fbcon build

Greg Kroah-Hartman <greg@kroah.com>:
  o USB serial: added device path to the proc file now that usb_make_path() is available

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o transparent pci-pci bridges fix
  o alpha rwsem update

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o Fix stupid compile error in wavelan_cs

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Add kernel-related BitKeeper docs/scripts, as found in the 2.5.x kernel Documentation/BK-usage sub-directory.

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o 2.4.20-pre6 Bluetooth core fixes

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Fix tg3 compile problems
  o Remove reiserfs not very well tested code
  o tg3.c
  o Fix bogus printk which was resulting in bootup oops
  o Add asm-ia64/include/efi.h needed by generic efi code

Oliver Neukum <oliver@neukum.name>:
  o new ids for hpusbscsi

Paul Mackerras <paulus@samba.org>:
  o PPC32: Add declaration of gg2_pci_config_base variable
  o don't use outl as label in ppp_generic.c
  o PPC fix in drivers/pci/Makefile
  o kd_mksound inclusion on PPC

Steven Cole <elenstev@mesatop.com>:
  o Configure.help fix for CONFIG_IP_NF_MATCH_DSCP


