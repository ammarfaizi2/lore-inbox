Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271612AbRHPSik>; Thu, 16 Aug 2001 14:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271614AbRHPSia>; Thu, 16 Aug 2001 14:38:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36872 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271611AbRHPSiO>; Thu, 16 Aug 2001 14:38:14 -0400
Date: Thu, 16 Aug 2001 11:37:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Off for a week, linux-2.4.9...
Message-ID: <Pine.LNX.4.33.0108161133150.8270-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm off to Finland for a week+, and will not be reading email or checking
the newsgroups during that time. I've put up a 2.4.9 kernel on
ftp.kernel.org, and would suggest that people try it out and discuss it on
the mailing lists, but NOT email me. I'll be interested to hear about
problems when I return, but I don't have a big hankering to have thousands
of messages waiting for me.

Also, I've been getting a _lot_ of patches, and if yours didn't show up
it's because I got too many. Never fear, there's always tomorrow. Except
in this case it's "in a week or two".

Changelog appended.

		Linus

-----
final:
 - David Miller: sparc updates, FAT fs fixes, btaudio build fix
 - David Gibson: Orinoco driver update
 - Kevin Fleming: more disks the HPT controller doesn't like
 - David Miller: "min()/max()" cleanups. Understands signs and sizes.
 - Jens Axboe: CD updates
 - Trond Myklebust: save away NFS credentials in inode, so that mmap can
   writeout.
 - Mark Hemment: HIGHMEM ops cleanups
 - Jes Sorensen: use "unsigned long" for flags in various drivers

pre4:
 - Tim Hockin: NatSemi ethernet update
 - Kurt Garloff: make PS/2 mouse reconnect adjustable like 2.2.x
 - Daniel Phillips: unlazy use-once
 - David Miller: undo poll() limit braindamage
 - me: make return value from do_try_to_free_pages() meaningful

pre3:
 - Patrick Mochel: fix PCI:PCI bridge 64-bit memory type detection
 - me: more forgotten nfsd off_t -> loff_t
 - Alan Cox: ide driver merge
 - Eric Lammerts, Rik van Riel: when oom, kill all threads.
 - Ben LaHaise: use down_read, not down_write() in map_user_kiobuf.
   We don't change the mappings, we just read them.
 - Kai Germaschewski: ISDN updates
 - Roland Fehrenbacher: sparse lun check
 - Tim Waugh: handle awkward Titan parallel/serial port cards
 - Stephen Rothwell: APM updates
 - Anton Altaparmakov: NTFS updates

pre2:
 - me: fix forgotten nfsd usage of filldir off_t -> loff_t change
 - Alan Cox: more driver merges

pre1:
 - Rui Sousa: emu10k1 module fixes, remove joystick part.
 - Alan Cox: driver merges
 - Andrea Arkangeli: alpha updates
 - David Woodhouse: up_and_exit -> complete_and_exit
 - David Miller: sparc and network update
 - Andrew Morton: update 3c59x driver
 - Neil Brown: NFS export VFAT, knfsd cleanups, raid fixes
 - Ben Collins: ieee1394 updates
 - Paul Mackerras: PPC update
 - me: make sure we don't lose position bits in "filldir()"

