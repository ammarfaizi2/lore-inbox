Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130806AbQKJC1Z>; Thu, 9 Nov 2000 21:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130819AbQKJC1Q>; Thu, 9 Nov 2000 21:27:16 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:35340 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130806AbQKJC1H>; Thu, 9 Nov 2000 21:27:07 -0500
Message-ID: <3A0B5C0F.D7C23116@timpanogas.org>
Date: Thu, 09 Nov 2000 19:23:11 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre2
In-Reply-To: <Pine.LNX.4.10.10011091748300.2316-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:
> 
> Nothing stands out as affecting most people here. Security fix for /proc,
> and various cleanups. Alpha and sparc fixes. If you use RAID or ramdisk,
> upgrade.
> 
>                 Linus
> 

Only four level I's.  Pretty good.  PCMCIA problems fixed too.....

Jeff

> -----
> 
>  - pre2:
>     - Stephen Rothwell: directory notify could return with the lock held
Level I
>     - Richard Henderson: CLOCKS_PER_SEC on alpha.
>     - Jeff Garzik: ramfs and highmem: kmap() the page to clear it
>     - Asit Mallick: enable the APIC in the official order
Level I

>     - Neil Brown: avoid rd deadlock on io_request_lock by using a
>       private rd-request function. This also avoids unnecessary
>       request merging at this level.
Level I

>     - Ben LaHaise: vmalloc threadign and overflow fix
Level I

>     - Randy Dunlap: USB updates (plusb driver). PCI cacheline size.
>     - Neil Brown: fix a raid1 on top of lvm bug that crept in in pre1
>     - Alan Cox: various (Athlon mmx copy, NULL ptr checks for
>       scsi_register etc).
>     - Al Viro: fix /proc permission check security hole.
>     - Can-Ru Yeou: SiS301 fbcon driver
>     - Andrew Morton: NMI oopser and kernel page fault punch through
>       both console_lock and timerlist_lock to make sure it prints out..
>     - Jeff Garzik: clean up "kmap()" return type (it returns a kernel
>       virtual address, ie a "void *").
>     - Jeff Garzik: network driver docs, various one-liners.
>     - David Miller: add generic "special" flag to page flags, to be
>       used by architectures as they see fit. Like keeping track of
>       cache coherency issues.
>     - David Miller: sparc64 updates, make sparc32 boot again
>     - Davdi Millner: spel "synchronous" correctly
Spell "David Miller" correctly.  8).

>     - David Miller: networking - fix some bridge issues, and correct
>       IPv6 sysctl entries.
>     - Dan Aloni: make fork.c use proper macro rather than doing
>       get_exec_domain() by hand.
> 
>  - pre1:
>     - me: make PCMCIA work even in the absense of PCI irq's
>     - me: add irq mapping capabilities for Cyrix southbridges
>     - me: make IBMMCA compile right as a module
>     - me: uhhuh. Major atomic-PTE SMP race boo-boo. Fixed.
>     - Andrea Arkangeli: don't allow people to set security-conscious
>       bits in mxcsr through ptrace SETFPXREGS.
>     - Jürgen Fischer: aha152x update
>     - Andrew Morton, Trond Myklebust: file locking fixes
>     - me: TLB invalidate race with highmem
>     - Paul Fulghum: synclink/n_hdlc driver updates
>     - David Miller: export sysctl_jiffies, and have the proper no-sysctl
>       version handy
>     - Neil Brown: RAID driver deadlock and nsfd read access to
>       execute-only files fix
>     - Keith Owens: clean up module information passing, remove
>       "get_module_symbol()".
>     - Jeff Garzik: network (and other) driver fixes and cleanups
>     - Andrea Arkangeli: scheduler cleanup.
>     - Ching-Ling Li: fix ALi sound driver memory leak
>     - Anton Altaparmakov: upcase fix for NTFS
>     - Thomas Woller: CS4281 audio update
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
