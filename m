Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131354AbQLVCA6>; Thu, 21 Dec 2000 21:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131503AbQLVCAt>; Thu, 21 Dec 2000 21:00:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9482 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131354AbQLVCAd>; Thu, 21 Dec 2000 21:00:33 -0500
Date: Thu, 21 Dec 2000 17:29:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test13-pre4
Message-ID: <Pine.LNX.4.10.10012211726060.968-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



More Makefile cleanups, otherwise mainly noticeable are the netfilter fix
and the LVM update.

		Linus

-----
 - pre4:
   - Christoph Rohland: shmfs cleanup
   - Nicolas Pitre: don't forget loop.c flags
   - Geert Uytterhoeven: new-style m68k Makefiles
   - Neil Brown: knfsd cleanups, raid5 re-org
   - Andrea Arkangeli: update to LVM-0.9
   - LC Chang: sis900 driver doc update
   - David Miller: netfilter oops fix
   - Andrew Grover: acpi update

 - pre3:
   - Christian Jullien: smc9194: proper dev_kfree_skb_irq
   - Cort Dougan: new-style PowerPC Makefiles
   - Andrew Morton, Petr Vandrovec: fix run_task_queue
   - Christoph Rohland: shmfs for shared memory handling

 - pre2:
   - Kai Germaschewski: ISDN update (including Makefiles)
   - Jens Axboe: cdrom updates
   - Petr Vandrovec; Matrox G450 support
   - Bill Nottingham: fix FAT32 filesystems on 64-bit platforms
   - David Miller: sparc (and other) Makefile fixup
   - Andrea Arkangeli: alpha SMP TLB context fix (and cleanups)
   - Niels Kristian Bech Jensen: checkconfig, USB warnings
   - Andrew Grover: large ACPI update

 - pre1:
   - me: drop support for old-style Makefiles entirely. Big.
   - me: check b_end_io at the IO submission path
   - me: fix "ptep_mkdirty()" (so that swapoff() works correctly)
   - fix fault case in copy_from_user() with a constant size, where
     ((size & 3) == 3)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
