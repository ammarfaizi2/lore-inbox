Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281861AbRKWIPa>; Fri, 23 Nov 2001 03:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282083AbRKWIPU>; Fri, 23 Nov 2001 03:15:20 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:27148 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S281861AbRKWIPK> convert rfc822-to-8bit;
	Fri, 23 Nov 2001 03:15:10 -0500
Date: Fri, 23 Nov 2001 03:14:47 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.15-final
Message-ID: <Pine.LNX.4.33.0111230312480.10570-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't see Linus post the final ChangeLog, so here it is:

final:
 - Jan Kara: fix quota SMP races with BKL

pre9:
 - David Brownell: usbnet update
 - Greg KH: USB and PCI hotplug update
 - Ingo/me: fix SCHED_FIFO for UP/SMP for good (flw).
 - Add back direct_IO now that it works again.

pre8:
 - Richard Henderson: alpha update
 - Andrew Morton: fix ext3/minix/sysv fsync behaviour.

pre7:
 - Jeff Garzik: network driver updates
 - Christoph Hellwig: UFS filesystem byteorder cleanups
 - me: modified Andrea VM page allocator tuning

pre6:
 - Russell King: /proc/cpuinfo for ARM
 - Paul Mackerras: PPC update (cpuinfo etc)
 - Nicolas Aspert: fix Intel 8xx agptlb flush
 - Marko Myllynen: "Lindent" doesn't really need bash ;)
 - Alexander Viro: /proc/cpuinfo for s390/s390x/sh, /proc/pci cleanup
 - Alexander Viro: make lseek work on seqfiles

pre5:
 - Greg KH: enable hotplug driver support
 - Andrea Arcangeli: remove bogus sanity check
 - David Mosberger: /proc/cpuinfo and scsi scatter-gather for ia64
 - David Hinds: 16-bit pcmcia network driver updates/cleanups
 - Hugh Dickins: remove some stale code from VM
 - David Miller: /proc/cpuinfo for sparc, sparc fork bug fix, network
   fixes, warning fixes
 - Peter Braam: intermezzo update
 - Greg KH: USB updates
 - Ivan Kokshaysky: /proc/cpuinfo for alpha
 - David Woodhouse: jffs2 - remove dead code, remove gcc3 warning
 - Hugh Dickins: fix kiobuf page allocation/deallocation

pre4:
 - Mikael Pettersson: make proc_misc happy without modules
 - Arjan van de Ven: clean up acpitable implementation ("micro-acpi")
 - Anton Altaparmakov: LDM partition code update
 - Alan Cox: final (yeah, sure) small missing pieces
 - Andrey Savochkin/Andrew Morton: eepro100 config space save/restore over suspend
 - Arjan van de Ven: remove power from pcmcia socket on card remove
 - Greg KH: USB updates
 - Neil Brown: multipath updates
 - Martin Dalecki: fix up some "asmlinkage" routine markings

pre3:
 - Alan Cox: more driver merging
 - Al Viro: make ext2 group allocation more readable

pre2:
 - Ivan Kokshaysky: fix alpha dec_and_lock with modules, for alpha config entry
 - Kai Germaschewski: ISDN updates
 - Jeff Garzik: network driver updates, sysv fs update
 - Kai M�kisara: SCSI tape update
 - Alan Cox: large drivers merge
 - Nikita Danilov: reiserfs procfs information
 - Andrew Morton: ext3 merge
 - Christoph Hellwig: vxfs livelock fix
 - Trond Myklebust: NFS updates
 - Jens Axboe: cpqarray + cciss dequeue fix
 - Tim Waugh: parport_serial base_baud setting
 - Matthew Dharm: usb-storage Freecom driver fixes
 - Dave McCracken: wait4() thread group race fix

pre1:
 - me: fix page flags race condition Andrea found
 - David Miller: sparc and network updates
 - various: fix loop driver that thought it was part of the VM system
 - me: teach DRM about VM_RESERVED
 - Alan Cox: more merging

