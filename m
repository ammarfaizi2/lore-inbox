Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279473AbRJXFxz>; Wed, 24 Oct 2001 01:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279474AbRJXFxq>; Wed, 24 Oct 2001 01:53:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279473AbRJXFxd>; Wed, 24 Oct 2001 01:53:33 -0400
Date: Tue, 23 Oct 2001 22:52:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-2.4.13..
Message-ID: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Things seem to be calming down a bit, which is nice.

Of course, it might possibly also be that everybody is off flaming about
the DMCA and getting no work done ;)

Whatever the cause, here's a 2.4.13. See if you can break it,

		Linus

----
final:
 - page write-out throttling
 - Pete Zaitcev: ymfpci sound driver update (make Civ:CTP happy with it)
 - Alan Cox: i2o sync-up
 - Andrea Arcangeli: revert broken x86 smp_call_function patch
 - me: handle VM write load more gracefully. Merge parts of -aa VM

pre6:
 - Stephen Rothwell: APM idle time handling fixes, docbook update, cleanup
 - Jeff Garzik: network driver updates
 - Greg KH: USB updates
 - Al Viro: UFS update, binfmt_misc rewrite.
 - Andreas Dilger: /dev/random fixes
 - David Miller: network/sparc updates

pre5:
 - Greg KH: usbnet fix
 - Johannes Erdfelt: uhci.c bulk queueing fixes

pre4:
 - Al Viro: mnt_list init
 - Jeff Garzik: network driver update (license tags, tulip driver)
 - David Miller: sparc, net updates
 - Ben Collins: firewire update
 - Gerd Knorr: btaudio/bttv update
 - Tim Hockin: MD cleanups
 - Greg KH, Petko Manolov: USB updates
 - Leonard Zubkoff: DAC960 driver update

pre3:
 - Jens Axboe: clean up duplicate unused request list
 - Jeff Mahoney: reiserfs endianness finishing touches
 - Hugh Dickins: some further swapoff fixes and cleanups
 - prepare-for-Alan: move drivers/i2o into drivers/message/i2o
 - Leonard Zubkoff: 2TB disk device fixes
 - Paul Schroeder: mwave config enable
 - Urban Widmark: fix via-rhine double free..
 - Tom Rini: PPC fixes
 - NIIBE Yutaka: SuperH update

pre2:
 - Alan Cox: more merging
 - Ben Fennema: UDF module license
 - Jeff Mahoney: reiserfs endian safeness
 - Chris Mason: reiserfs O_SYNC/fsync performance improvements
 - Jean Tourrilhes: wireless extension update
 - Joerg Reuter: AX.25 updates
 - David Miller: 64-bit DMA interfaces

pre1:
 - Trond Myklebust: deadlock checking in lockd server
 - Tim Waugh: fix up parport wrong #define
 - Christoph Hellwig: i2c update, ext2 cleanup
 - Al Viro: fix partition handling sanity check.
 - Trond Myklebust: make NFS use SLAB_NOFS, and not play games with PF_MEMALLOC
 - Ben Fennema: UDF update
 - Alan Cox: continued merging
 - Chris Mason: get /proc buffer memory sizes right after buf-in-page-cache

