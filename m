Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289375AbSAOCrk>; Mon, 14 Jan 2002 21:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSAOCrb>; Mon, 14 Jan 2002 21:47:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20486 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289367AbSAOCrU>; Mon, 14 Jan 2002 21:47:20 -0500
Date: Mon, 14 Jan 2002 18:45:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.2
Message-ID: <Pine.LNX.4.33.0201141840070.2544-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, lots of various changes between 2.5.1->2, mainly in bio, kdev_t and
scheduler (and several USB updates).

		Linus

----

final:
 - Matt Domsch: combine common crc32 library
 - Pete Zaitcev: ymfpci update
 - Davide Libenzi: scheduler improvements
 - Al Viro: almost there: "struct block_device *" everywhere
 - Richard Gooch: devfs cpqarray update, race fix
 - Rusty Russell: PATH_MAX should include the final '\0' count
 - David Miller: various random updates (mainly net and sparc)

pre11:
 - Davide Libenzi, Ingo Molnar: scheduler updates
 - Greg KH: USB update
 - Jean Tourrilhes: IrDA and wireless updates
 - Jens Axboe: bio/block updates

pre10:
 - Kai Germaschewski: ISDN updates
 - Al Viro: start moving buffer cache indexing to "struct block_device *"
 - Greg KH: USB update
 - Russell King: fix up some ARM merge issues
 - Ingo Molnar: scalable scheduler

pre9:
 - Russell King: large ARM update
 - Adam Richter et al: more kdev_t updates

pre8:
 - Greg KH: USB updates
 - various: kdev_t updates
 - Al Viro: more bread()/filesystem cleanups

pre7:
 - Jeff Garzik: fix up loop and md for struct kdev_t typechecking
 - Jeff Garzik: improved old-tulip network driver
 - Arnaldo: more scsi driver bio updates
 - Kai Germaschewski: ISDN updates
 - various: kdev_t updates

pre6:
 - Davide Libenzi: nicer timeslices for scheduler
 - Arnaldo: wd7000 scsi driver cleanups and bio update
 - Greg KH: USB update (including initial 2.0 support)
 - me: strict typechecking on "kdev_t"

pre5:
 - Dave Jones: more merging, fix up last merge..
 - release to sync with Dave

pre4:
 - Jens Axboe: more bio updates, fix some request list bogosity under load
 - Al Viro: export seq_xxx functions
 - Manfred Spraul: include file cleanups, pc110pad compile fix
 - David Woodhouse: fix JFFS2 write error handling
 - Dave Jones: start merging up with 2.4.x patches
 - Manfred Spraul: coredump fixes, FS event counter cleanups
 - me: fix SCSI CD-ROM sectorsize BIO breakage

pre3:
 - Christoph Hellwig: scsi_register_module cleanup
 - Mikael Pettersson: apic.c LVTERR fixes
 - Russell King: ARM update (including bio update for icside)
 - Jens Axboe: more bio updates
 - Al Viro: make ready to switch bread away from kdev_t..
 - Davide Libenzi: scheduler cleanups
 - Anders Gustafsson: LVM fixes for bio
 - Richard Gooch: devfs update

pre2:
 - Al Viro: task-private namespaces, more cleanups

pre1:
 - me: revert the "kill(-1..)" change.  POSIX isn't that clear on the
   issue anyway, and the new behaviour breaks things.
 - Jens Axboe: more bio updates
 - Al Viro: rd_load cleanups. hpfs mount fix, mount cleanups
 - Ingo Molnar: more raid updates
 - Jakub Jelinek: fix Linux/x86 confusion about arg passing of "save_v86_state" and "do_signal"
 - Trond Myklebust: fix NFS client race conditions

