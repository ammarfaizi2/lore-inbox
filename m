Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbSAGTQj>; Mon, 7 Jan 2002 14:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285327AbSAGTQa>; Mon, 7 Jan 2002 14:16:30 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:6951 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S285273AbSAGTQR> convert rfc822-to-8bit; Mon, 7 Jan 2002 14:16:17 -0500
Date: Mon, 7 Jan 2002 20:15:52 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-dj13
In-Reply-To: <20020107015046.A9687@suse.de>
Message-ID: <20020107200925.C1704-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jan 2002, Dave Jones wrote:

> Assorted fixes, updates & Merges.
> Note, a few people sent me patches to 'merge pre8/pre9'.
> Whilst I appreciate the effort, I'd rather do this myself, to get
> a better idea of what I'm merging/need to drop. Thanks all the same.
> (I've put out this 'resync' patch, just to stop people sending me
>  these, when I'd already done it 8-)
>
> Patch against 2.5.1 vanilla is available from:
> ftp://ftp.xx.kernel.org/pub/linux/kernel/people/davej/patches/2.5/
>
> Enjoy,

Enjoy what ?
May-be you mean enjoy having to check every tree of a deep forest.

For your 2.5.1 series, the enjoyers did so 13 times, for now.
How many times did they for all other trees?

This looks too much enjoying too me... :-)

  Gérard.

>   -- Davej.
>
>
> 2.5.1-dj13
> o   Merge 2.5.2pre9
>     | Take akpm fix for ext3 over Linus'	(Andrew Morton)
> o   More kdev_t fixes.				(Various)
> o   Remerge acmes bio cleanups from -dj11	(Arnaldo Carvalho de Melo)
> o   Add __copy_to_user_prefetch()		(Me)
> o   Clean up preload_cache() a little.		(Me)
>
>
> 2.5.1-dj12
> o   Merge 2.5.2pre7
> o   Enable alternative PTE routines.			(Andrea Arcangeli)
> o   Reschedule during inode flushes under mem pressure.	(Andrea Arcangeli)
> o   More kdev_t compile fixes.				(Andries Brouwer,
> 					 		 Jonathan Corbet,
> 							 Luc Van Oostenryck, Me)
> o   Further include file cleanups.			(Me)
> o   aic7xxx nseg bugfix.				(Jens Axboe, Others)
> o   Fix panic on corrupted reiserfs.			(Oleg Drokin)
> o   Fix reiserfs taildata corruption on mempressure.	(Oleg Drokin)
> o   Fix kreiserfsd sleep timeout thinko.		(Oleg Drokin)
> o   apic.c LVTERR fixes.				(Mikael Pettersson)
> o   Merge correct & updated sg driver.			(Doug Gilbert)
> o   Add NetGear EA201 to ne2k ISAPNP clones.		(Chris Rankin)
> o   Various 53c700 fixes.				(James Bottomley)
>
>
> 2.5.1-dj11
> o   Merge up to 2.5.2pre6
>     | Plus various compile fixes.		(Me, Jeff Garzik,
> 		    				 Frank Davis, Martin Dalecki)
> o   Don't enable APIC on newer Dell laptops.	(Mikael Pettersson)
> o   Add more missing MODULE_LICENSE tags.	(Me)
> o   Report out-of-spec SMP Athlons.		(Me)
>     | Flames to /dev/null
> o   More fbdev/console clean up.		(James Simmons)
> o   Sync up with latest bootproto.		(H. Peter Anvin)
> o   Reiserfs Sparc alignment fix.		(Alexander Zarochentcev)
> o   Remove some bogus headers left around.	(Christoph Hellwig)
> o   Fix wanrouter build.			(Me)
> o   Various bio surgery on SCSI drivers.	(Arnaldo Carvalho de Melo)
> o   Reiserfs getblk cleanups.			(Christoph Hellwig)
> o   make DASD use generic BLKGETSIZE{64} again	(Christoph Hellwig)
> o   Fix devfs & tty breakage.			(James Simmons)
>
>
> 2.5.1-dj10
> o   Remove one of the NFS changes. Better fix in mainline.	(Me)
> o   Add switch to enable 486 string copies.			(Me)
>     | 486 users please try this out, and give feedback
>     | so we can see how broken this actually is.
>     | It's in the 'kernel hacking' menu.
> o   JFFS2 corruption fix.			(David Woodhouse)
> o   Bridging CONFIG_INET cleanup.		(Lennert Buytenhek)
> o   Bridging recursion bugfix.			(Lennert Buytenhek)
> o   Fix up port state handling.			(Lennert Buytenhek)
> o   Improved fbdev init.			(James Simmons)
> o   PNPOS simple bootflag fix.			(Thomas Hood)
> o   Drop most of the USB changes on Greg's request.
>     | Newer versions should appear in -linus soon.
>     | Some bits still remain, but if I've broke it, blame
>     | me and not Greg.
> o   Experimental preload_cache() function.	(Me)
> o   Ugly hack to file_read_actor() to use the above	(Me)
>     | Just playing, this needs more work.
>
>
> 2.5.1-dj9
> o   Merge up to 2.5.2pre4.
>     | Also fix up a bunch of build errors.
> o   Add support for Sony DSC-P5 to USB unusual devs.	(Gregor Jasny)
> o   First part of new console locking infrastructure.	(James Simmons)
> o   Cleaner/Lighter fbdev api.				(James Simmons,
> 							 Geert Uytterhoeven)
> o   Don't coredump framebuffer contents.		(Andrew Morton)
> o   Fix hang on close of serial tty.			(Russell King)
> o   Remove the set_current_state() patch, needs work.	(Me)
> o   Drop ICH2 addition to ioapic Whitelist. 		(Me)
> o   Do the asm/segment.h crapectomy properly.		(David Woodhouse)
> o   Reactivate the PNPBIOS Configure.help entry.
>
>
> 2.5.1-dj8
> o   Remove leftover EISA cruft in x86 ksyms.		(Me)
> o   Add a missing part of the split visws support.	(Me)
> o   Make reiserfs partitions mountable again.		(Al Viro,
> 							 Andrew Morton, Me)
> o   Make x86 math emulation work with dynamic LDT.	(Manfred Spraul)
> o   Fix problems with tdfxfb & high pixelclocks.	(Jurriaan)
>     | Only tested on PCI 4500, feedback to thunder7@xs4all.nl
> o   Replace text.lock with .subsection			(Keith Owens)
> o   Remove Cyrix SLOP workaround.			(Me)
>     | Can be done in userspace/initramfs.
> o   Merge pnpbios support.				(Thomas Hood)
>     | Should work, but may be nice to bend into shape
>     | to fit the new driverfs model at some point.
>
>
> 2.5.1-dj7
> o   Merge 2.5.2pre3
>     | Drop some of the reiserfs changes. Looks like -dj has
>     | a more complete set of fixes from 2.4. This is getting
>     | a little hairy, so handle with care.
> o   Make rootfs compile.				(Me)
> o   Dynamically grow LDT.				(Manfred Spraul)
> o   Randomness for ext2 generation numbers.		(Manfred Spraul)
> o   Give Manfreds threaded coredump a retry.		(Manfred Spraul)
> o   Add missing ad1848 formats.				(Alan Cox)
> o   Make ide-floppy compile without PROC_FS.		(Robert Love)
> o   generic_serial, rio_linux, serial_tx3912,		(Rasmus Andersen)
>     sh-sci and sx drivers janitor work.
> o   opl3sa2 Power management support & update.		(Zwane Mwaikambo)
>     | Add Zwane to MAINTAINERS for this too.
> o   Fix buggy MODINC i2o_config macro.			(Andreas Dilger)
> o   Cyclades driver /proc/ioports oops fix.		(Andrew Morton)
>     | Untested afaik, but looks sane.
>     | rmmod cyclades.o ; cat /proc/ioports to see if this works.
> o   SX driver, DCD-HylaFAX problem solved.		(Heinz-Ado Arnolds)
> o   Only look in 1KB of EBDA for MP table.		(Zwane Mwaikambo)
>     | Follows the MP1.4 Spec closer, let me know of any
>     | SMP problems if any with this change.
> o   Better fix for the sunrpc 'missing include'.	(David Woodhouse)
> o   Remove bogus <asm/segment.h> includes.		(David Woodhouse)
> o   ps2esdi spinlock typo.				(Me)
>
>
> 2.5.1-dj6
> o   Merge 2.5.2pre2
>     | Includes updated for 2.5 SCSI debug driver.	(Douglas Gilbert)
> o   Merge 2.4.18pre1
> o   Missing include in sunrpc sched.c			(David S. Miller)
> o   Remove incorrect devinit's from bttv & USB.		(Andrew Morton)
> o   Remove redundant EISA_bus__is_a_macro macro.	(Me)
> o   Split visws support to setup-visws.c		(Me)
>     | Can someone with one of these beasts test this, and maybe
>     | even *gulp* maintain it ?
> o   pc110pad spinlock thinko				(Peter T. Breuer)
> o   Fix reiserfs + highmem possible oops.		(Oleg Drokin)
> o   Fix reiserfs fsx breakage.				(Oleg Drokin)
> o   Make IPV6 accept timestamps in response to SYNs.	(Alexey Kuznetsov)
> o   NCR5380_timer_fn needs to be static.		(Rasmus Andersen)
> o   CONFIG_SERIAL_ACPI is IA64 only.			(Me)
>
>
> 2.5.1-dj5
> o   Sync up to 2.5.2pre1
> o   Merge 2.4.17final.
> o   Gravis ultrasound PnP update		(Andrey Panin)
>
>
> 2.5.1-dj4
> o   Merge with 2.4.17-rc2
>     | Most was already here, more or less just fixes for
>     | reiserfs & netfilter, and some VM changes.
>
>
> 2.5.1-dj3
> o   Drop Manfreds multithread coredump changes		(Me)
>     | They caused ltp waitpid05 regression on 2.5
>     | (Same patch is fine for 2.4)
> o   Intermezzo compile fix.				(Chris Wright)
> o   Fix ymfpci & hisax merge errors.			(Me)
> o   Drop ad1848 sound driver changes in favour of 2.5	(Me)
> o   Make hpfs work again.				(Al Viro)
> o   Alpha Jensen compile fixes.				(Ronald Lembcke)
> o   Make NCR5380 compile non modularly.			(Erik Andersen)
>
>
> 2.5.1-dj2
> o   bio fixes for qlogicfas.			(brett@bad-sports.com)
> o   Correct x86 CPU helptext.			(Me)
> o   Fix serial.c __ISAPNP__ usage.		(Andrey Panin)
> o   Use better ide-floppy fixes.		(Jens Axboe)
> o   Make NFS 'fsx' proof.			(Trond Mykelbust)
>     | 2 races & 4 bugs, hopefully this is all.
> o   devfs update				(Richard Gooch)
> o   Backout early CPU init, needs more work.	(Me)
>     | This should fix several strange reports.
> o   drop new POSIX kill semantics for now	(Me)
>
>
> 2.5.1-dj1
> o   Resync with 2.5.1
>     | drop reiserfs changes. 2.4's look to be more complete.
> o   Fix potential sysvfs oops.				(Christoph Hellwig)
> o   Loopback driver deadlock fix.			(Andrea Arcangeli)
> o   __devexit cleanups in drivers/net/			(Daniel Chen,
>     synclink, wdt_pci & via82cxxx_audio 		 John Tapsell)
> o   Configure.help updates				(Eric S. Raymond)
> o   Make reiserfs compile again.				(Me)
> o   bio changes for ide floppy					(Me)
>     | handle with care, compiles, but is unfinished.
> o   Make x86 identify_cpu() happen earlier			(Me)
>     | PPro errata workaround & APIC setup got a little
>     | cleaner as a result.
> o   Blink keyboard LEDs on panic				(From 2.4.13-ac)
> o   Change current->state frobbing to set_current_state()	(From 2.4.13-ac)
> o   Add MODULE_LICENSE tags for acpi,md.c,fmvj18x,		(From 2.4.13-ac)
>     atyfb & fbmem.
>
>
> --
> Dave Jones.                    http://www.codemonkey.org.uk
> SuSE Labs.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

