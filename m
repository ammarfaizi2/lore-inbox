Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264135AbRFMBna>; Tue, 12 Jun 2001 21:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264138AbRFMBnU>; Tue, 12 Jun 2001 21:43:20 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:61713 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264135AbRFMBnM>; Tue, 12 Jun 2001 21:43:12 -0400
Date: Tue, 12 Jun 2001 18:42:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.6-pre3
Message-ID: <Pine.LNX.4.31.0106121836030.1253-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


User-noticeable things: if you are tired of not being able to NFS-export
your reiserfs tree, this should make you happy.

VM tuning has also happened, with Rik van Riel, Mike Galbraith, Marcelo
Tosatti and Andrew Morton all doing various tweaks. Give it a whirl.

		Linus

-----

-pre3:
 - remember to increment the version number
 - Chris Mason: reiserfs mark_journal_new and bh leak fix
 - Richard Gooch: devfs update
 - Alexander Viro: further FS cleanup (superblock list)
 - David Woodhouse: MTD update
 - Kai Germaschewski: ISDN update (stanford checker fixes etc)
 - Rich Baum: gcc-3.0 warning fixes
 - Jeff Garzik: network driver updates
 - Geert Uytterhoeven: m68k fbdev logo merge glitch fix
 - Andrea Arcangeli: fix signal return path
 - David Miller: Sparc updates
 - Johannes Erdfelt: USB update
 - Carsten Otte, Andries Brouwer: don't clear blk_size unconditionally
   on partition check
 - Martin Frey: alpha Sable irq fix
 - Paul Mackerras: PPC softirq update
 - Patrick Mochel: PCI power management infrastructure
 - Robert Siemer: miroSOUND driver update
 - Neil Brown: knfsd updates, including ability to export ReiserFS filesystems
 - Trond Myklebust: NFS readdir fixup, don't update atime on client
 - Andrew Morton: truncate_inode_pages speedup
 - Paul Menage: make inode quota count all inodes..

-pre2:
 - Takanori Kawano: brlock indexing bugfix
 - Ingo Molnar, Jeff Garzik: softirq updates and fixes
 - Al Viro: rampage of superblock cleanups.
 - Jean Tourrilhes: Orinoco driver update v6, IrNET update
 - Trond Myklebust: NFS brown-paper-bag thing
 - Tim Waugh: parport update
 - David Miller: networking and sparc updates
 - Jes Sorensen: m68k update.
 - Ben Fennema: UDF update
 - Geert Uytterhoeven: fbdev logo updates
 - Willem Riede: osst driver updates
 - Paul Mackerras: PPC update
 - Marcelo Tosatti: unlazy swap cache
 - Mikulas Patocka: hpfs update

-pre1:
 - Andreas Dilger: make ext2fs react more gracefully to inode disk
   errors
 - Andrea Arkangeli: fix up alpha compile issues
 - Ingo Molnar: io-apic MP table parsing update and softirq latency
   update
 - Johannes Erdfelt: USB updates
 - Richard Henderson: alpha rawhide irq handling fixes
 - Marcelo, Andrea, Rik: more VM issues
 - Al Viro: fix various ext2 directory handling checks by biting the
   bullet and using the page cache.


