Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265331AbSKEXNT>; Tue, 5 Nov 2002 18:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSKEXNS>; Tue, 5 Nov 2002 18:13:18 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:4337 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265331AbSKEXNR>; Tue, 5 Nov 2002 18:13:17 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15816.21014.537318.147147@wombat.chubb.wattle.id.au>
Date: Wed, 6 Nov 2002 10:19:50 +1100
To: linux-kernel@vger.kernel.org
Subject: 2.5.46 -- can't build ide as modules
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are unresolved symbols on when building the IDE subsystem as
modules:



CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDE_MODES=y




depmod -ae output:

depmod: *** Unresolved symbols in
/lib/modules/2.5.45/kernel/drivers/ide/ide-disk.o
depmod:         proc_ide_read_geometry
depmod: *** Unresolved symbols in
/lib/modules/2.5.45/kernel/drivers/ide/ide-floppy.o
depmod:         proc_ide_read_geometry
depmod: *** Unresolved symbols in
/lib/modules/2.5.45/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         ide_bus_type
depmod:         create_proc_ide_interfaces
depmod: *** Unresolved symbols in
/lib/modules/2.5.45/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         ide_add_proc_entries
depmod:         ide_scan_pcibus
depmod:         proc_ide_read_capacity
depmod:         proc_ide_create
depmod:         ide_remove_proc_entries
depmod:         destroy_proc_ide_drives
depmod:         proc_ide_destroy
depmod:         create_proc_ide_interfaces
depmod: *** Unresolved symbols in
/lib/modules/2.5.45/kernel/fs/binfmt_aout.o
depmod:         ptrace_notify
