Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbTDDTsM (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbTDDTsL (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:48:11 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32851 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261246AbTDDTsE (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 14:48:04 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200304041959.h34JxXE25668@devserv.devel.redhat.com>
Subject: Linux 2.5.66-ac2
To: linux-kernel@vger.kernel.org
Date: Fri, 4 Apr 2003 14:59:33 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly a resync and check patch rather than something
exciting to run. It should work but it is not at all tested.
The SMP crash on boot should be fixed too

Linux 2.5.66-ac2
o	Resync with Linus -bk8
o	Fix modules build				(me)
o	Fix arch syscalls to return long		(Randy Dunlap)
o	USBfs kerneldoc					(David Brownell)
o	More i2c updates				(Greg Kroah Hartmann)
	| FIxes several driver compiles
o	Fix IDE locking/phase handling on timeout	(Manfred Spraul)
o	C99 initialisers for DMAsound			(Maciej Soltysiak)
o	C99 initialisers for OSS audio			(Maciej Soltysiak)
o	C99 intialisers for emu10k1			(Maciej Soltysiak)
o	Move dead MOD_ calls from floppy driver		(Bob Miller)
o	Fix macmace abuse of GFP_DMA			(Matthew Wilcox)
o	Improve hpt kconfig entry			(Adrian Bunk)
o	Generic HDLC updates				(Krzysztof Halasa)
o	Fix es968 kmalloc parameters			(Pablo Meinchini)
o	Fix als100 kmalloc parameters			(Pablo Meinchini)
o	PC98xx updates to existing merge		(Osamu Tomita)
	| Keyboard, ALSA, floppy
o	Fix misc_register fail path for upd4990a	(Stephan Maciej)
o	Fix pegasus endian bug				(Paul Mackerras)
o	Wireless needs __init				(Paul Mackerras)
o	Fix gus compilation when built in (lock		(Peter Waechtler)
	clash)
o	Sony PI driver update				(Stelian Pop)
o	Spelling fixes for Alpha			(Steven Cole)
o	Spelling fixes for x86-64			(Steven Cole)
o	Add a "blank now" key mapping			(Pavel Machek)
o	Remove 23 bogus includes of version.h		(Burton Windle)
o	Fix cs4232 build				(Daniel Ritz)
o	Update v850 architecture			(Miles Bader)
o	Fix taint mishandling for AMD CPU		(Manfred Spraul)
o	Fix compile of dt019x audio			(John Kim)
o	Kill "compatmac"				(Adrian Bunk)
o	Fix via82cxxx_audio build			(me)
o	Fix acpi build					(me)
o	Resync with bk9
o	Fix oprofile build				(John Levon)
o	PnP updates					(Adam Belay)
o	Fix visws framebuffer compile			(Andrey Panin)
o	Avoid LBA48 modes on disks that don't need	(Jens Axboe)
	them (saves a 2nd command cycle on each I/O
	as suggested by Mark Lord)
o	Clean up ide list handling for drives		(Alexander Atanasov)
o	Remove present check from drivers (now		(Alexander Atanasov)
	handled by the list stuff)
o	Fix SMP boot timer oops				(me)
	| Thanks to Steven Cole for pinning this down to
	| 5 lines of change
o	Port ltpc driver to spinlocks			(me)
o	Fix cadet driver missing symbol			(me)
o	Fix cops driver locking				(me)
o	Fix arcnet.c locking				(me)

Linux 2.5.66-ac1
o	Fix up ESI handling in esp.c			(me)
	| Lots more needs fixing in this driver yet
o	Merge Linus 2.5.66
o	Fix cramfs compile problems			(Jeremy Brown, me)
o	Fix mad16 breakage				(Adrian Bunk)
o	Iphase fixes port to 2.5			(Chas Williams,
							 Eric Leblond)
o	Fix ipc/msg race				(Manfred Spraul)
o	Let hdparm know about speed change fails	(Jens Axboe)
o	Don't issue WIN_SET_MAX on older drivers	(Jens Axboe)
	(Breaks some Samsung)
o	Resync with Linus bk3 snapshot

