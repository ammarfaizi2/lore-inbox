Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318816AbSHWO0Z>; Fri, 23 Aug 2002 10:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318818AbSHWO0Z>; Fri, 23 Aug 2002 10:26:25 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:24729 "EHLO nick")
	by vger.kernel.org with ESMTP id <S318816AbSHWO0Y>;
	Fri, 23 Aug 2002 10:26:24 -0400
Date: Fri, 23 Aug 2002 15:30:22 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre4-ac1 modular IDE symbol problems
Message-ID: <Pine.LNX.4.44.0208231528560.2524-100000@localhost.localdomain>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (17iFSM-0002OJ-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hope the below is useful (I know not too many people build IDE as modules)
(built using Red Hat (null))

depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide-disk.o
depmod:         proc_ide_read_geometry
depmod:         ide_remove_proc_entries
depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide-floppy.o
depmod:         proc_ide_read_geometry
depmod:         ide_remove_proc_entries
depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         create_proc_ide_interfaces
depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide-tape.o
depmod:         ide_remove_proc_entries
depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         ide_add_proc_entries
depmod:         ide_scan_pcibus
depmod:         proc_ide_read_capacity
depmod:         proc_ide_create
depmod:         ide_remove_proc_entries
depmod:         destroy_proc_ide_drives
depmod:         proc_ide_destroy
depmod:         create_proc_ide_interfaces

