Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSINQnN>; Sat, 14 Sep 2002 12:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSINQnN>; Sat, 14 Sep 2002 12:43:13 -0400
Received: from pD9E2308E.dip.t-dialin.net ([217.226.48.142]:34951 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317359AbSINQnL>; Sat, 14 Sep 2002 12:43:11 -0400
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Martin Brulisauer <martin@uceb.org>,
       Oliver Pitzeier <o.pitzeier@uptime.at>
Subject: [ANNOUNCE] Linux 2.5.34-ct1
X-Mailer: Lightweight Patch Manager
Message-ID: <20020914164819.9A9717@hawkeye.luckynet.adm>
MIME-Version: 1.0
User-Agent: Lightweight Patch Manager/1.04
Date: Sat, 14 Sep 2002 16:48:19 +0000
X-Priority: I really don't care.
Content-Type: text/plain; charset=US-ASCII
Organization: Lightweight Networking
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's all  about the new  IDE code, some  User Mode Linux,  and keeping
things clean.  I've had to punch  out my Tekram fix,  since the driver
seems to have messed up further in the meanwhile.

I'm especially interested  in Alpha testers these days,  so please try
it if you have your Alpha around.

You can get the diff against Linux 2.5.34 at
<URL:http://lightweight.ods.org/~thunder/patches/ct/patch-2.5.34-ct1.bz2>
<URL:http://lightweight.ods.org/~thunder/patches/ct/patch-2.5.34-ct1.gz>

For  the sake  of security  our  staff decided  to put  aside the  ftp
server, so don't wonder why I'm releasing it via HTTP.

			Thunder

Changes for Linux 2.5.34-ct1
============================

<diegocg@teleline.es>:
  o ALSA bug, isa cmi8330

<jblack@linuxguru.net>:
  o IRQ patch

<johann.deneux@it.uu.se>:
  o A small documentation update and a unused constant removal

<nmiell@attbi.com>:
  o OSS compile fix
  o SCTP typo fix

<rudmer@legolas.dynup.net>:
  o fix __FUNCTION__ use in ip_nat_helper.c

<rz@linux-m68k.org>:
  o q40kbd fixes

<zubarev@us.ibm.com>:
  o fix polling logic/add writeability

Adam J. Richter <adam@yggdrasil.com>:
  o shave a six bytes from the loaded size of pcspkr.o and another 90 elsewhere in the .o file
  o fix building list of drives in reverse order

Alexander Viro <viro@math.psu.edu>:
  o Missing IDE partition 3 of 3

Andi Kleen <ak@muc.de>:
  o Fix RELOC_HIDE miscompilation

Andi Kleen <ak@suse.de>:
  o we must not call request_region() in i8042-io.h

Andre Hedrick <andre@linux-ide.org>:
  o SCSI ST driver patches
  o IDE taskfile patches
  o IDE patches, extending Al Viro's IDE

Andrew Morton <akpm@digeo.com>:
  o radix_tree_gang_lookup
  o Janet Morgan's readv/writev rework

Bob Miller <rem@osdl.org>:
  o No more FIXMEs in the sysctl

Brad Hards <bhards@bigpond.net.au>:
  o Change "D: Drivers=" to "H: Handlers=" in /proc/bus/input/devices

Chris Wright <chris@wirex.com>:
  o kernel-api DocBook fix

Christoph Hellwig <hch@lst.de>:
  o list.h update

David S. Miller <davem@redhat.com>:
  o remove hang on unregistration of 802.1Q

Dipankar Sarma <dipankar@in.ibm.com>:
  o Read-Copy update

franz.sirl-kernel@lauterbach.com <Franz.Sirl-kernel@lauterbach.com>:
  o Exporting kbd_pt_regs in keyboard.c

Greg Kroah-Hartman <greg@kroah.com>:
  o PCI hotplug: remove pci_*_nodev() prototypes as the functions are gone
  o PCI hotplug: core cleanup to get hotplugging working again
  o PCI hotplug: export pci_scan_bus() as the IBM PCI Hotplug driver needs it
  o PCI hotplug: changed calls to pci_*_nodev() to pci_bus_*()
  o PCI hotplug: fixed __FUNCTION__ usages

Ingo Molnar <mingo@elte.hu>:
  o catch invalid father-child constellation
  o do_syslog/__down_trylock lockup
  o sys_exit_group(), threading
  o fix NMI watchdog

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o nautilus update on alpha
  o replace __down_read_trylock for rw_semaphores on alpha

Jeff Dike <jdike@karaya.com>:
  o User Mode Linux v2.5.34

Linus Torvalds <torvalds@home.transmeta.com>:
  o fix major floppy corruption, and possibly some more broken block devices
  o De-queue the floppy request late, so that the higher levels know the floppy driver is busy

Martin Schwenke <martin@meltin.net>:
  o Pull NFS server address off root_server_path

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390 fixes (10/10): iucv driver
  o s390 fixes (9/10): ctc driver
  o s390 fixes (8/10): signal quiesce
  o s390 fixes (7/10): 3215 driver
  o s390 fixes (6/10): xpram driver
  o s390 fixes (5/10): dasd driver
  o s390 fixes (4/10): ptrace cleanup
  o s390 fixes (3/10): fpu cleanup
  o s390 fixes (2/10): common code changes
  o s390 fixes (1/10): base patch

Mikael Pettersson <mikpe@csd.uu.se>:
  o Floppy hack

Nikita Danilov <nikita@namesys.com>:
  o UML 2.5.34 compile patch

Pavel Machek <pavel@ucw.cz>:
  o Fix 2.5.34+swsusp data corruption on IDE

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o recalc_sigpending missing for modules

Robert Love <rml@tech9.net>:
  o Preemption problem on shutdown

Russell King <rmk@arm.linux.org.uk>:
  o USB updates for Linux 2.5.32

Rusty Russell <rusty@rustcorp.com.au>:
  o This adds the generic infrastructure to allow removing of CPUs in a running kernel
  o Simply moves the "is this mask valid?" check inside set_cpus_allowed, since it might be racy otherwise in the context of adding/removing CPUs. This also introduces the CPU brlock
  o change cpu masks to a generic bitmap, and introduce migrate_to_cpu() as a convenience function
  o rename bitmap_member to DECLARE_BITMAP, and move it to bitops.h
  o get_cpu_var(var) should be an lvalue. Spotted by Dipankar Sarma
  o Generated files destruction
  o per-cpu only for possible CPUs
  o More designated initializer works
  o is_smp() and can_be_smp()

Sam Ravnborg <sam@ravnborg.org>:
  o zftape: Cleanup zftape_syms.c
  o update ftape symbol exports

Skip Ford <skip.ford@verizon.net>:
  o ufs/super.c

Stephen Rothwell <sfr@canb.auug.org.au>:
  o fcntl.h consolidation

Thunder from the hill <patch@lightweight.ods.org>:
  o remove unused variables

Thunder from the hill <thunder@lightweight.ods.org>:
  o alignment fix (off by one)
  o toshiba needs interrupts
  o correct exported symbols
  o Updated to Linux 2.5.34
  o list_t removal
  o do_fork requires some more arguments on Alpha
  o Correct incomplete lock declarations
  o More designated initializer work
  o Further __FUNCTION__ madness all over
  o Further macro corrections. If you use my patches, please apply them completely
  o Updated to Linux 2.5.33
  o Correct __FUNCTION__ macro madness on old compilers
  o Don't concatenate with __FUNCTION__
  o Export symbols patches, v5
  o Import Linux 2.5.32

Vojtech Pavlik <vojtech@suse.cz>:
  o fix problems in serport.c found by Russell King
  o Change beginning tags

Zwane Mwaikambo <zwane@mwaikambo.name>:
  o set pci dma mask for ohci-hcd
  o pci_free_consistent on ohci initialisation failure

-- 
Lightweight Patch Manager, without pine.
If you have any objections (apart from who I am), tell me

