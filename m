Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276594AbRJGSud>; Sun, 7 Oct 2001 14:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276600AbRJGSuY>; Sun, 7 Oct 2001 14:50:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45065 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276594AbRJGSuR> convert rfc822-to-8bit; Sun, 7 Oct 2001 14:50:17 -0400
Date: Sun, 7 Oct 2001 11:49:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.11-pre5
Message-ID: <Pine.LNX.4.33.0110071148380.7382-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id LAA09967
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


USB and quota update.

And the fix for VM breakage in pre4.

		Linus

-----

pre5:
 - Keith Owens: module exporting error checking
 - Greg KH: USB update
 - Paul Mackerras: clean up wait_init_idle(), ppc prefetch macros
 - Jan Kara: quota fixes
 - Abraham vd Merwe: agpgart support for Intel 830M
 - Jakub Jelinek: ELF loader cleanups
 - Al Viro: more cleanups
 - David Miller: sparc64 fix, netfilter fixes
 - me: tweak resurrected oom handling

pre4:
 - Al Viro: separate out superblocks and FS namespaces: fs/super.c fathers
   fs/namespace.c
 - David Woodhouse: large MTD and JFFS[2] update
 - Marcelo Tosatti: resurrect oom handling
 - Hugh Dickins: add_to_swap_cache racefix cleanup
 - Jean Tourrilhes: IrDA update
 - Martin Bligh: support clustered logical APIC for >8 CPU x86 boxes
 - Richard Henderson: alpha update

pre3:
 - Al Viro: superblock cleanups, partition handling fixes and cleanups
 - Ben Collins: firewire update
 - Jeff Garzik: network driver updates
 - Urban Widmark: smbfs updates
 - Kai Mäkisara: SCSI tape driver update
 - various: embarrassing lack of error checking in ELF loader
 - Neil Brown: md formatting cleanup.

pre2:
 - me/Al Viro: fix bdget() oops with block device modules that don't
   clean up after they exit
 - Alan Cox: continued merging (drivers, license tags)
 - David Miller: sparc update, network fixes
 - Christoph Hellwig: work around broken drivers that add a gendisk more
   than once
 - Jakub Jelinek: handle more ELF loading special cases
 - Trond Myklebust: NFS client and lockd reclaimer cleanups/fixes
 - Greg KH: USB updates
 - Mikael Pettersson: sparate out local APIC / IO-APIC config options

pre1:
 - Chris Mason: fix ppp race conditions
 - me: buffers-in-pagecache coherency, buffer.c cleanups
 - Al Viro: block device cleanups/fixes
 - Anton Altaparmakov: NTFS 1.1.20 update
 - Andrea Arcangeli: VM tweaks

