Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSEMKNe>; Mon, 13 May 2002 06:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSEMKNd>; Mon, 13 May 2002 06:13:33 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:45829 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S311180AbSEMKNK>; Mon, 13 May 2002 06:13:10 -0400
Date: Mon, 13 May 2002 12:12:28 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513101228.GA4071@louise.pinerecords.com>
In-Reply-To: <20020512203103.GA9087@gallifrey> <Pine.LNX.4.44.0205121836320.15555-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 15:30)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> [Linus Torvalds <torvalds@transmeta.com>, May-12 2002, Sun, 18:56 -0700]
>
> As an example, if the long version looks like this:
> ...
> The short version could look like
> ...

How's this? (script attached)

$ ./fmtcl.pl /usr/src/ChangeLog-2.5.15

Summary of changes from v2.5.14 to v2.5.15
============================================

-- Terse ChangeLog starts here --

<acme@brinquedo.oo.ps>
	o  - remove spurious spaces and tabs at end of lines

<acme@conectiva.com.br>
	o  net/ipv4/arp.c:

<aia21@cantab.net>
	o  NTFS: Fix compilation on 2.5.14 ({set_,clear_,}buffer_async was renamed

<akpm@zip.com.au>
	o  [PATCH] Fix: writing to the swap space

<anton@samba.org>
	o  [PATCH] acenic driver and 867 MHz G4 sound problems

<axboe@suse.de>
	o  [PATCH] tcq initialization fix

<colin@gibbs.dhs.org>
	o  copy_mm fix:

<dalecki@evision-ventures.com>
	o  [PATCH] 2.5.14 IDE 55
	o  [PATCH] IDE 58
	o  [PATCH] 2.5.14 IDE 57
	o  [PATCH] 2.5.14 IDE 56
	o  [PATCH] 2.5.14 IDE 59

<davej@suse.de>
	o  [PATCH] capabilities for mtrr driver.
	o  [PATCH] region handling cleanup
	o  [PATCH] region handling cleanup
	o  [PATCH] region handling cleanup
	o  [PATCH] region handling cleanup
	o  [PATCH] CREDITS update
	o  [PATCH] check various return codes in advantechwdt.
	o  [PATCH] IA64 ZX1 AGPGart support.
	o  [PATCH] region handling cleanup
	o  [PATCH] typo.
	o  [PATCH] region handling cleanup
	o  [PATCH] documentation for Cyrix IRQ routing
	o  [PATCH] sonypi update
	o  [PATCH] VIA quirk update.
	o  [PATCH] region handling cleanup
	o  [PATCH] prefetching too far in mem copies
	o  [PATCH] update NBD URL
	o  [PATCH] DMI update.
	o  [PATCH] motioneye driver update.
	o  [PATCH] typo in z2ram driver
	o  [PATCH] simplify wdt285 copying.
	o  [PATCH] dmasound update.
	o  [PATCH] PNPBIOS / floppy conflict.
	o  [PATCH] NCR5380 update.
	o  [PATCH] list macro conversion.
	o  [PATCH] swap file missing error check
	o  [PATCH] HP ZX1 AGP/DRM support.
	o  [PATCH] ptrace bug

<davem@nuts.ninka.net>
	o  net/core/neighbour.c: Delete ancient ASSERT_WL debugging.
	o  Sparc64: Implement pfn_pte.
	o  Sparc64 updates:
	o  Sparc64: Fix thinko in page_to_pfn
	o  Sparc64: Update ioctl32 for bluetooth updates.
	o  soft-fp fix:
	o  Sparc64: Fix pfn_foo macros and add descriptive commentary
	o  Sparc64: Make use of USE_STANDARD_AS_RULE.
	o  SLAB: When using get_user on kernel pointers, enter KERNEL_DS.
	o  Soft-fp fix:
	o  Sparc64: Enter KERNEL_DS when invoking do_sigaltstack with
	o  drivers/usb/net/rtl8150.c: Include linux/init.h
	o  Sparc64: Make pcibios_init a subsys_initcall.
	o  Sparc64: Keep totalram_pages equal to num_physpages.
	o  Sparc: Kill references to buffermem_pages.
	o  asm-sparc64/thread_info.h: Include asm/page.h even if __ASSEMBLY__

<david-b@pacbell.net>
	o  [PATCH] PATCH ehci -- interrupt xfer requeue
	o  [PATCH] USB usbnet driver update
	o  [PATCH] PATCH 2.5.14 -- ehci misc fixes

<dougg@torque.net>
	o  [PATCH] osst update
	o  [PATCH] sg update
	o  [PATCH] aha1542 update

<greg@kroah.com>
	o  add back NCR53c810 PCI quirk code from davej that was lost in the merge
	o  hand merge of davej's x86 pci-pc janitor work
	o  PCI hotplug update 
	o  USB pl2303 driver
	o  Move arch/i386/kernel/pci/ to arch/i386/pci/
	o  PCI hotplug drivers
	o  USB Config.in and Makefile minor changes
	o  USB ohci driver update
	o  USB
	o  moved the pci_alloc_consistent() and pci_free_consistent() functions back
	o  PCI Hotplug core
	o  IBM PCI Hotplug driver

<grundler@cup.hp.com>
	o  Tigon3 fix:

<hch@infradead.org>
	o  [PATCH] small filemap.c/pagemap.h cleanups

<hoho@binbash.net>
	o  [PATCH] suser() -> capable() checks

<ink@jurassic.park.msu.ru>
	o  [PATCH] Fix missing #includes
	o  [PATCH] fixes for PCI reorg changes
	o  [PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]
	o  [PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [1/2]

<jmorris@intercode.com.au>
	o  Tigon3: Handle Netgear GA302T correctly.

<kai@tp1.ruhr-uni-bochum.de>
	o  Move the IPv6 symbols into the ipv6 module
	o  Documentation/kbuild/makefiles.txt polish
	o  drivers/net/Makefile cleanup
	o  Link drivers/net/* from drivers/net/Makefile
	o  ISDN: CAPI cleanup: register/release
	o  ISDN: CAPI cleanup
	o  ISDN: CAPI maintain driver MOD_USE_COUNT
	o  ISDN: CAPI: use <linux/list.h> lists
	o  ISDN: export callbacks directly
	o  ISDN: CAPI: alloc struct capi_ctr dynamically
	o  ISDN: CAPI: alloc struct capi_appl dynamically
	o  ISDN: CAPI remove NCCI up/down notification
	o  ISDN: CAPI fix new "ncci up"
	o  Fix compile time warning in serial.c
	o  Fix cut'n'paste error in drivers/message/Makefile
	o  Cleanup drivers/pcmcia/Makefile
	o  Remove PCMCIA backwards compatibility rule.
	o  Link drivers/char/* from drivers/char/Makefile
	o  Cleanup drivers/fusion/* build
	o  Cleanup drivers/pcmcia/Makefile part 2
	o  Fix the Makefile cleanups

<laforge@gnumonks.org>
	o  Netfilter ipt_ULOG fix:

<mochel@segfault.osdl.org>
	o  Move arch/i386/kernel/pci-*.c to arch/i386/kernel/pci/; prepare for further cleanups
	o  Further split/cleanup of x86 PCI code
	o  Split drivers/pci/pci.c into smaller, bite-size chunks
	o  Further break-up-age
	o  don't enable debug in arch/i386/kernel/pci/
	o  Fix NUMA compile after PCI cleanup
	o  Move arch/i386/kernel/pci/ to arch/i386/pci/
	o  PCI Update: Fix oops on boot w/ ACPI enabled
	o  Re-add check for valid acpi routing information, instead of assuming it works

<neilb@cse.unsw.edu.au>
	o  [PATCH] PATCH - kNFSd in 2.5.14 - Tidy up comments in expfs.c
	o  [PATCH] PATCH - kNFSd in 2.5.14 - Two small changes to nfsd/nfssvc.c
	o  [PATCH] PATCH - kNFSd - Remove flowcontrol problems with lockd/tcp
	o  [PATCH] PATCH - kNFSd in 2.5.14 - Add a kernel_lock in d_splice_alias
	o  [PATCH] PATCH - kNFSd/FAT in 2.5.14 - Add export_operations support for FAT
	o  [PATCH] PATCH - kNFSd/ext3 in 2.5.14 - export_operations support for ext3
	o  [PATCH] PATHC - kNFSd/reiserfs in 2.5.14 - Convert reisferfs to use export_operations

<oliver@neukum.name>
	o  [PATCH] USB printer freeing minors in probe error path
	o  [PATCH] usage count handling during disconnect

<paulus@nanango.paulus.ozlabs.org>
	o  PPC32: add SIGURG to the list of signals ignored by default
	o  PPC32: add a subsys_initcall so pcibios_init gets called

<paulus@quango.ozlabs.ibm.com>
	o  PPC32: Rename ppc_defs.h to asm-offsets.h to ease the transition to kbuild-2.5 later.
	o  Update the Config.help for ppc32.  References to 486s and pentiums aren't

<paulus@samba.org>
	o  Define pfn_to_page, page_to_pfn, pte_pfn, pfn_pte for ppc32.
	o  PPC32: This changeset adds preemptible kernel support for ppc32
	o  PPC32: minor cosmetic changes, eliminate compile warnings
	o  PPC32: fix serial clock for embedded EP405 board.
	o  PPC32: remove some compiler warnings, xmon update
	o  PPC32: powermac update from Ben Herrenschmidt.
	o  [PATCH] fix drivers/pci/Makefile for PPC
	o  [PATCH] fix drivers/scsi/sd.c for ppc32

<rob@osinvestor.com>
	o  Sparc32 sun4c:

<robert.olsson@data.slu.se>
	o  IPV4: Add statistics for route cache GC monitoring.

<sfr@canb.auug.org.au>
	o  [PATCH] USE_STANDARD_AS_RULE in i386 arch Makefiles
	o  [PATCH] Directory Notification Fix

<shaggy@austin.ibm.com>
	o  [PATCH] Fix JFS file system corruption

<torvalds@home.transmeta.com>
	o  Re-apply Dave's VIA quirk update from 2.4.x
	o  Update kernel version

<torvalds@penguin.transmeta.com>
	o  Add SIGURG to list of ignore-by-default signals
	o  Fix makefile errors

<trini@bill-the-cat.bloom.county>
	o  PPC32: Update Motorola LoPEC support to match recent changes.
	o  PPC32: Minor cleanups to the i8259 and OpenPIC code.  From myself and
	o  PPC32: Modify the OpenPIC code to allow for all combinations of sense
	o  PPC32: define some important magic constants.
	o  PPC32: Modify openpic_get_irq() to call i8259_irq() for cascaded IRQs.  This
	o  Fix building of CONFIG_XMON && !CONFIG_MAGIC_SYSRQ

<vandrove@vc.cvut.cz>
	o  [PATCH] NLS: Invalid koi8-ru return values
	o  [PATCH] NLS: Allow user to select 1:1 mapping

<vojtech@twilight.ucw.cz>
	o  Fix for the previous fix. hid->name is 128 bytes, not 64 bytes long.
	o  This fixes a possible buffer overflow in hid-core.c in case a

<zippel@linux-m68k.org>
	o  [PATCH] m68k: atari updates [2/20]
	o  [PATCH] m68k: AFFS update [1/20]
	o  [PATCH] m68k: bitops update [3/20]
	o  [PATCH] m68k: add cacheflush.h [4/20]
	o  [PATCH] m68k: config.in update [5/20]
	o  [PATCH] m68k: license updates [7/20]
	o  [PATCH] m68k: hp300 update [8/20]
	o  [PATCH] m68k: idle update [10/20]
	o  [PATCH] m68k: remove hwclk_time/gettod [9/20]
	o  [PATCH] m68k: add missing include [11/20]
	o  [PATCH] m68k: Rename KTHREAD_SIZE [12/20]
	o  [PATCH] m68k: math-emu updates [13/20]
	o  [PATCH] m68k: rename p_pptr [14/20]
	o  [PATCH] m68k: readd lost proc functions [15/20]
	o  [PATCH] m68k: rlimits update [16/20]
	o  [PATCH] m68k: seq_file fixes [17/20]
	o  [PATCH] m68k: add tlbflush.h [18/20]
	o  [PATCH] m68k: add show_trace/show_trace_task [19/20]
	o  [PATCH] m68k: zorro updates [20/20]
	o  [PATCH] m68k: driver updates [6/20]

-- Full ChangeLog starts here --

<acme@brinquedo.oo.ps>
	--------------------------------------------------------------
	- remove spurious spaces and tabs at end of lines
	- make sure if, while, for, switch has a space before the opening '('
	- make sure no line has more than 80 chars
	- move initializations to the declaration line where possible
	- bitwise, logical and arithmetic operators have spaces before and after,
	  improving readability of complex expressions
	- remove uneeded () in returns
	- other minor cleanups


<acme@conectiva.com.br>
	--------------------------------------------------------------
	net/ipv4/arp.c:
	- htons cleanups
	- remove duplicated code
	- apply CodingStyle


<aia21@cantab.net>
	--------------------------------------------------------------
	NTFS: Fix compilation on 2.5.14 ({set_,clear_,}buffer_async was renamed
	to {set_,clear_,}buffer_async_read).


<akpm@zip.com.au>
	--------------------------------------------------------------
	[PATCH] Fix: writing to the swap space
	
	Ah.  That's some left-over code.  Reads will be OK, but writes will be
	unexpectedly asynchronous.  Nothing in the kernel uses that function for
	writes so it didn't show up.


<anton@samba.org>
	--------------------------------------------------------------
	[PATCH] acenic driver and 867 MHz G4 sound problems
	
	Fix acenic driver


<axboe@suse.de>
	--------------------------------------------------------------
	[PATCH] tcq initialization fix
	
	Transposed the last two arguments to memset, causing a slab poisoned
	kernel not to use tagging correctly... Brown paper bag stuff.


<colin@gibbs.dhs.org>
	--------------------------------------------------------------
	copy_mm fix:
	- If dup_mmap fails we will try to destroy_context before
	init_new_context occurs.  Platforms with non-trivial
	init_new_context can explode because of this.  The fix
	is to invoke init_new_context before dup_mmap.


<dalecki@evision-ventures.com>
	--------------------------------------------------------------
	[PATCH] 2.5.14 IDE 55
	
	 - Update HPT374 driver carried over from 2.4.xx series by Andrew Morton.
	   Resync it with the recent host chip driver changes, or better the
	   introduction of an API at all.
	
	 - Consolidate the handling of device ID byte order in one place.
	   This was spotted and patched by Bartomiej onierkiewicz.
	
	 - Eliminate CONFIG_BLK_DEV_IDEPCI - it's duplicating the functionality of the
	   already present and fine CONFIG_PCI flag and if we are a PCI host, we are
	   indeed very likely to need host chip support anyway.
	
	 - Remove some redundant info about the model and channel number from
	   /proc/ide. Remove the binary entries not helpful to the user, and not used
	   by any program and redundant to corresponding ioctls.
	
	 - Properly return udma_read and udma_write values in taskfile.
	
	 - Only initialize XXX_udma to the default handlers if it has not been
	   initialized by the host chip initialization.
	
	I have enabled spin lock debugging and can see that on device
	flush the spin locks get wrong counts... no problems elsewher ethus
	far. I will re check them next time around.

	--------------------------------------------------------------
	[PATCH] IDE 58
	
	 - m68k fixes by Roman Zippel.
	
	 - CDROM PIO mode fix by Osamu Tamita.
	   (You are true "Hawk-eye" hovering over my head! Respect - and many Thanks.)
	
	 - Virtualize the udma_enable method as well to help ARM and PPC people.  Please
	   please if you would like to have some other methods virtualized in a similar
	   way - just tell me or even better do it yourself at the end of ide-dma.c.
	   I *don't mind* patches.
	
	 - Fix the pmac code to adhere to the new API. It's supposed to work again.
	   However this is blind coding... I give myself 80% chances for it to work ;-).

	--------------------------------------------------------------
	[PATCH] 2.5.14 IDE 57
	
	Nuke /proc/ide. For explanations why, please see the frustrated comments in the
	previous change log. If one still don't see why it wasn't a good thing,
	well please just take a look at the following:
	
	Kernel size before:
	
	    text    data     bss     dec     hex filename
	1716049  403968  470252 2590269  27863d vmlinux
	
	Kernel size after:
	
	    text    data     bss     dec     hex filename
	1680993  403488  470124 2554605  26faed vmlinux
	
	2% of overall size! And this is not exactly an minimalistic setup.

	--------------------------------------------------------------
	[PATCH] 2.5.14 IDE 56
	
	 - Push poll_timeout down from the hwgroup to the channel. We are resetting the
	   channel and not a whole hwgroup. This way using multiple pdc202xxx cards
	   should magically start to work with multiple performance and resets will no
	   longer lock the system.
	
	 - Updates for PDC4030 by Peter Denison <peterd@marshadder.uklinux.net>.
	
	 - Make ide_raw_taskfile don't care about request buffers. They where always
	   NULL.
	
	 - Port set multi mode count over from the special setting interface to
	   ide_raw_taskfile. Fix errors in the corresponding interrupt handler in one go
	   as well. It turned out that this is precisely the same code as in
	   task_no_data_intr, so we can nuke it altogether. And finally we have found
	   some problems with the set_pio_mode() command which can fail with -EBUSY -
	   this is in esp. probably *very* common during boot hdparm usage those days!
	   (OK it was masked by reportig too early that it finished...  Crap Crap utter
	   crap it was!!!) Right now hdparm should just be extendid to properly
	   sync and retry on   -EBUSY and everything should be fine.
	
	   And now the 1 Milion EUR question for everybody who loves to put driver
	   settings in to /proc:
	
	   How the hell could echo > /proc/ide/ide0/settings blah blah blah blah handle
	   properly cases like -EIO, -EBUSY and so on??? Having the possibility o do it
	   does not mean that it is a good idea to use it.
	
	   OK. After realizing the simple fact that quite a lot of low level hardware
	   manipulating ioctls may require assistance in usage from proper logic which is
	   *very* unlikely to be implemented in a bash (for me preferable still ksh) I
	   have made my mind up.
	
		/proc/ide will be nuked.
	
	 - Execute the recalibration for error recovery on precisely the same request as
	   the one which failed.
	
	 - Remove set geometry.  It's crap by means of standard specification. Because:
	
	   1. We rely on the existence of the identify command anyway.
	
	   2. This command was obsoleted *before* the identify command existed as far
	   as I can see.
	
	   2. I'm able to have a look at what other ATA/ATAPI drivers in the wild do:
	   They don't do it.
	
	 - Just call tuneproc in set_pio_mode() directly - we are already behind the rq
	   queue there.
	
	 - After we have uncovered the broken logics behind the whole ioctl handling we
	   now just have made ide_spin_wait_hwgroup() waiting for a proper somehow
	   longer timeout before giving up. This was previously just hiding the broken
	   concept of setting ioctl values through /proc/ide/ideX/settings - now it just
	   really helps hdparm to not to give up too early. (It shouldn't probably play
	   wreck havock on the global driver spin lock as well. I will look in to this
	   later.)
	
	 - Scrap the non necessary, to say the least, disabling of interrupts for 3,
	   read it again please, 3 seconds, on the local CPU inside
	   ide_spin_wait_hwgroup().  Spin lock handling needs checking there badly as I
	   see now as well...
	
	Hey apparently any "special" requests are gone. We now have only
	to deal with REQ_DEVICE_ACB and REQ_DEVICE_CMD. One of them is still too
	much and will be killed.

	--------------------------------------------------------------
	[PATCH] 2.5.14 IDE 59
	
	Basically PCI driver handling reorganization. This is one step further
	ahead toward the goal of fully modularized host chip drivers.
	
	 - Adjust ide-scsi to the new error handling. Just don't try any device
	   resets there.
	
	 - Add unmasking of IRQ per default to the PMac PCI code.
	
	 - Split up the crap table from ide-pci. Let the corresponding drivers do
	   registration of the functions they provide. This small change makes
	   this patch rather big.
	
	 - Hard-code the number of ports requested for DMA engines. They are always
	   precisely 8 on PCs. If you hove something different to deal with,
	   well then please just provide your own init_dma method.
	
	 - Remove the HDIO_GETGEO_BIG ioctl. Patch by Andries Brouwer. Applies
	   unmodified.
	
	 - Make ON_BOARD be equal 0, so we can spare ourself some typing in structure
	   initialization.
	
	 - Normalize the terminology in the host chip drivers. It will make spotting
	   the tons of common code found there later easier.


<davej@suse.de>
	--------------------------------------------------------------
	[PATCH] capabilities for mtrr driver.
	

	--------------------------------------------------------------
	[PATCH] region handling cleanup
	
	Done by William Stinson.
	Adds error handling to request_region() calls,
	and converts some old check_region() calls too.

	--------------------------------------------------------------
	[PATCH] region handling cleanup
	
	Done by William Stinson.
	Adds error handling to request_region() calls,
	and converts some old check_region() calls too.

	--------------------------------------------------------------
	[PATCH] region handling cleanup
	
	Done by William Stinson.
	Adds error handling to request_region() calls,
	and converts some old check_region() calls too.

	--------------------------------------------------------------
	[PATCH] region handling cleanup
	
	Done by William Stinson.
	Adds error handling to request_region() calls,
	and converts some old check_region() calls too.

	--------------------------------------------------------------
	[PATCH] CREDITS update
	

	--------------------------------------------------------------
	[PATCH] check various return codes in advantechwdt.
	
	Adds missing checks. Probably another from William Stinson

	--------------------------------------------------------------
	[PATCH] IA64 ZX1 AGPGart support.
	
	From 2.4

	--------------------------------------------------------------
	[PATCH] region handling cleanup
	
	Done by William Stinson.
	Adds error handling to request_region() calls,
	and converts some old check_region() calls too.

	--------------------------------------------------------------
	[PATCH] typo.
	

	--------------------------------------------------------------
	[PATCH] region handling cleanup
	
	Done by William Stinson.
	Adds error handling to request_region() calls,
	and converts some old check_region() calls too.

	--------------------------------------------------------------
	[PATCH] documentation for Cyrix IRQ routing
	

	--------------------------------------------------------------
	[PATCH] sonypi update
	
	Syncs up with latest from Stelian

	--------------------------------------------------------------
	[PATCH] VIA quirk update.
	
	Brings up to date with the quirk in 2.4
	This makes sure we only apply it on the right chipsets,
	and adjusts the bits that get poked depending on which we find.

	--------------------------------------------------------------
	[PATCH] region handling cleanup
	
	Done by William Stinson.
	Adds error handling to request_region() calls,
	and converts some old check_region() calls too.

	--------------------------------------------------------------
	[PATCH] prefetching too far in mem copies
	
	This patch from 2.4 makes sure we don't prefetch past the
	end of a range to be copied (in case its at the end of a memrange)
	i386 case looks safe already, we just weren't optimal for the last
	chunk to be copied.
	
	Andi. same change needed for x86-64.
	
	    Dave.

	--------------------------------------------------------------
	[PATCH] update NBD URL
	

	--------------------------------------------------------------
	[PATCH] DMI update.
	
	Another Sony for the apm blacklist.

	--------------------------------------------------------------
	[PATCH] motioneye driver update.
	
	Syncs up with Stelians latest

	--------------------------------------------------------------
	[PATCH] typo in z2ram driver
	

	--------------------------------------------------------------
	[PATCH] simplify wdt285 copying.
	
	copy_to_user already does the relevant checking.

	--------------------------------------------------------------
	[PATCH] dmasound update.
	
	The largest part of the OSS update from 2.4
	Various changelog entries scattered throughout the patch.

	--------------------------------------------------------------
	[PATCH] PNPBIOS / floppy conflict.
	
	The PNPBIOS driver and the floppy driver both fight over reservation
	of the floppy port. This patch makes things friendly again.
	As the comment suggests, this fix could be done better, but until
	someone steps forward to fix this, this is the best we have.

	--------------------------------------------------------------
	[PATCH] NCR5380 update.
	
	From 2.4
	- Lindented
	- Add Docbook comments
	- Remove duplicate MODULE_LICENSE tag

	--------------------------------------------------------------
	[PATCH] list macro conversion.
	
	Use listwalking macro..

	--------------------------------------------------------------
	[PATCH] swap file missing error check
	
	Found by Andries Brouwer a while back iirc.

	--------------------------------------------------------------
	[PATCH] HP ZX1 AGP/DRM support.
	
	From 2.4

	--------------------------------------------------------------
	[PATCH] ptrace bug
	
	We weren't incrementing the address when walking a processes
	address space.  From 2.4


<davem@nuts.ninka.net>
	--------------------------------------------------------------
	net/core/neighbour.c: Delete ancient ASSERT_WL debugging.

	--------------------------------------------------------------
	Sparc64: Implement pfn_pte.

	--------------------------------------------------------------
	Sparc64 updates:
	- Implement changes for pfn_to_page et al.
	- Update defconfig.

	--------------------------------------------------------------
	Sparc64: Fix thinko in page_to_pfn

	--------------------------------------------------------------
	Sparc64: Update ioctl32 for bluetooth updates.

	--------------------------------------------------------------
	soft-fp fix:
	- When converting from integer to float, rounding is done
	incorrectly due to off-by-one shift in conversion

	--------------------------------------------------------------
	Sparc64: Fix pfn_foo macros and add descriptive commentary
	above explaining the {phys,pfn}_base stuff.

	--------------------------------------------------------------
	Sparc64: Make use of USE_STANDARD_AS_RULE.

	--------------------------------------------------------------
	SLAB: When using get_user on kernel pointers, enter KERNEL_DS.

	--------------------------------------------------------------
	Soft-fp fix:
	- Fix handling of implicit 1 bit of fraction part when converting
	from int to float.  We cannot handle it properly unless we
	defer implicit 1 bit handling till after rounding as
	rounding may move where the implicit 1 bit is in
	the final converted integer.

	--------------------------------------------------------------
	Sparc64: Enter KERNEL_DS when invoking do_sigaltstack with
	kernel pointers.

	--------------------------------------------------------------
	drivers/usb/net/rtl8150.c: Include linux/init.h

	--------------------------------------------------------------
	Sparc64: Make pcibios_init a subsys_initcall.

	--------------------------------------------------------------
	Sparc64: Keep totalram_pages equal to num_physpages.

	--------------------------------------------------------------
	Sparc: Kill references to buffermem_pages.

	--------------------------------------------------------------
	asm-sparc64/thread_info.h: Include asm/page.h even if __ASSEMBLY__


<david-b@pacbell.net>
	--------------------------------------------------------------
	[PATCH] PATCH ehci -- interrupt xfer requeue
	
	The fix basically removes a bit-complement that shouldn't have
	been there.  (Plus related simplification.)  That changed the PID,
	so that (for one example) only the first hub plug/unplug event could
	work.  So it's essential for anyone using high speed hubs.
	
	I'm still not quite sure why this hasn't affected more testing, but
	that's life ... :)

	--------------------------------------------------------------
	[PATCH] USB usbnet driver update
	
	    - generalizes/cleans keventd support to also handle
	        * rx stalls (and usb 2.0 transaction translator unplug)
	        * rx memory shortfalls (latent bug Oliver noticed)
	        * cleanup on device disconnect (quiesce first)
	    - merges Brad's patch to use the IEEE802 "locally assigned" bit
	    - fixes a couple minor bugs on error paths (leak, bogus diagnostic)
	    - updates some comments

	--------------------------------------------------------------
	[PATCH] PATCH 2.5.14 -- ehci misc fixes
	
	    - Report better errors, and in one case the correct one.
	    - Adds strategic wmb() calls
	    - Claims the right (scaled) ISO bandwidth
	    - Uses non-CVS version ID
	
	This will likely resolve that Archos MP3 Jukebox issue, where "-104"
	(-ECONNRESET) was appearing mysteriously.


<dougg@torque.net>
	--------------------------------------------------------------
	[PATCH] osst update
	
	This is the OnStream variant of the st driver that
	has been in Dave's tree for some time.
	
	The change looks like it is from Willem Riede (osst@riede.org)
	and that it has been forwarded ported from lk 2.4 .

	--------------------------------------------------------------
	[PATCH] sg update
	
	Here is one fix and one enhancement to the scsi generic (sg)
	driver in 2.5.14
	Changelog:
	    - off by one fix for last scatter gather element
	    - if possible compact kiobuf_map into scatter gather list

	--------------------------------------------------------------
	[PATCH] aha1542 update
	
	This ISA scsi adapter still seems to be popular
	given the number of people that supply patches
	for it collected in Dave's tree.
	
	The latest patch was from William Stinson (first item):
	  - request_region cleanup
	  - removal of old scsi error handling (leaving newer version)
	  - scatterlist::address replaced
	  - host_lock replacing io_request_lock
	
	
	Doug Gilbert
	
	P.S. This is a transfer from Dave's tree. It runs fine for
	me on a dual Celeron SMP box.


<greg@kroah.com>
	--------------------------------------------------------------
	add back NCR53c810 PCI quirk code from davej that was lost in the merge

	--------------------------------------------------------------
	hand merge of davej's x86 pci-pc janitor work

	--------------------------------------------------------------
	PCI hotplug update 
	
	include file location changed due to pci changes

	--------------------------------------------------------------
	USB pl2303 driver
	
	added support for another pl2303 device thanks to lutz rothhardt

	--------------------------------------------------------------
	Move arch/i386/kernel/pci/ to arch/i386/pci/

	--------------------------------------------------------------
	PCI hotplug drivers
	
	change due to moved location of i386's pci.h

	--------------------------------------------------------------
	USB Config.in and Makefile minor changes
	
	sync up with -dj tree

	--------------------------------------------------------------
	USB ohci driver update
	
	add PMAC changes found in -dj tree

	--------------------------------------------------------------
	USB
	
	minor -dj tree updates.

	--------------------------------------------------------------
	moved the pci_alloc_consistent() and pci_free_consistent() functions back
	into arch/i386/kernel as they are needed even if CONFIG_PCI is not enabled.

	--------------------------------------------------------------
	PCI Hotplug core
	
	removed pcihpfs_statfs(), as it's not used anymore.

	--------------------------------------------------------------
	IBM PCI Hotplug driver
	
	update the ibm pci hotplug driver to the latest version.  Contains lots of
	small bugfixes and added features for new hardware.


<grundler@cup.hp.com>
	--------------------------------------------------------------
	Tigon3 fix:
	- Fix typo in setting MR_LP_ADV duplex flags.


<hch@infradead.org>
	--------------------------------------------------------------
	[PATCH] small filemap.c/pagemap.h cleanups
	
	 - remove page_cache_entry - I think it never ever was actually used.
	 - remmove wake_up_page (as in 2.4) - never used
	 - remove misleading comment ontop of pagemap.h
	 - make wait_on_page* directly call wait_on_page_bit
	 - some reordering and additional comments in pagemap.h


<hoho@binbash.net>
	--------------------------------------------------------------
	[PATCH] suser() -> capable() checks
	
	  Trivial patch to change some instances of suser() and fsuser() to
	proper capable() checks.


<ink@jurassic.park.msu.ru>
	--------------------------------------------------------------
	[PATCH] Fix missing #includes
	
	There are missing #includes which will break compilation on some non-x86
	platforms. With following patch this compiles and works on alpha.
	
	Ivan.

	--------------------------------------------------------------
	[PATCH] fixes for PCI reorg changes
	
	There are missing #includes which will break compilation on some non-x86
	platforms. With following patch this compiles and works on alpha.

	--------------------------------------------------------------
	[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]
	
	Summary of changes:
	- alpha, arm: code related to PCI-PCI bridges from pcibios_fixup_bus()
	  removed - now it's generic;
	- pdev_sort_resource: sort resources all together, no matter IO or memory;
	- pbus_assign_resources_sorted: ditto;
	- pci_bridge_check_ranges, pci_setup_bridge: changed for prefetch support;
	- pbus_size_io, pbus_size_mem: core stuff; tested with randomly generated
	  sets of resources;
	- pbus_size_bridges: pass #2 (pass #1 is PCI probing, common for all archs);
	- pbus_assign_resources: pass #3.
	
	Ivan.

	--------------------------------------------------------------
	[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [1/2]
	
	This changes PCI resource allocation algorithm to 3 passes vs.
	current 2 passes. Extra pass is used for calculation of required
	size and alignment of PCI buses behind PCI-PCI bridges. After
	that, in the pass #3, these buses get allocated like regular
	PCI devices. This gives tighter PCI IO and memory packing -
	for instance, this fixes allocation problems on certain alphas
	with very small (112Mb) PCI memory range. Also, the new code
	- will allow mixed approach to resource allocation:
	  architecture can keep BIOS settings for some devices,
	  and re-allocate resources for others, including improperly
	  initialized bridges;
	- makes prefetchable ranges support much simpler;
	- allows sizing of IO and memory ranges for the host
	  bridges, which might be very useful in some situations.
	
	It was tested on various alphas; I haven't heard any complaints
	from rmk and rth, so probably all of this is ok. :-)
	
	Part 1:
	- for all archs, 4th argument (align) added to
	  pcibios_align_resource (and its callers).
	  It's necessary because this function will be called for
	  bus resources as well, and in this case size != alignment.
	- for several archs, dead/bogus code removed from
	  pcibios_fixup_pbus_ranges().


<jmorris@intercode.com.au>
	--------------------------------------------------------------
	Tigon3: Handle Netgear GA302T correctly.


<kai@tp1.ruhr-uni-bochum.de>
	--------------------------------------------------------------
	Move the IPv6 symbols into the ipv6 module
	
	Currently, we're trying to export the IPv6 modules from netsyms.c,
	which can't work when netsyms is built-in, but IPv6 is modular. Fix is to
	move the IPv6 symbols to the ipv6 module. Actually, netsyms.c could use a
	lot more of this kind of untangling.
	
	Also, move exporting the secure_*v6* symbols to drivers/char/random.c, 
	since that's where they're defined.
	
	The reason why things worked before is that the ipv6 module doesn't have
	a EXPORT_NO_SYMBOLS directive, so _all_ of its symbols where exported by
	modutils.
	

	--------------------------------------------------------------
	Documentation/kbuild/makefiles.txt polish
	
	Some improvements to the wording by Toshiyasu Morita.

	--------------------------------------------------------------
	drivers/net/Makefile cleanup
	
	Group selecting subdirs and linking them together. (Doesn't change
	the link order)

	--------------------------------------------------------------
	Link drivers/net/* from drivers/net/Makefile
	
	Group knowledge about building objects and linking them together
	instead of splitting it between the top-level Makefile and
	the per-directory Makefiles.
	
	This change tries to keep the link order the same as it was, at least
	as far as possible. One critical point is that we now link
	the pcmcia / wireless netdrivers before the pcmcia subsystem.
	However, the pcmcia subsystem is initialized via a late_initcall(),
	so this shouldn't make a difference.
	
	drivers/net/Makefile looks a bit long now, but that can be improved
	a lot, patch yet to come.

	--------------------------------------------------------------
	ISDN: CAPI cleanup: register/release
	
	Introduce register_appl() / release_appl() which are basically equivalent 
	to open()/close() for net_device's.
	
	Remove the registered() / released() callbacks and do the work immediately
	instead.

	--------------------------------------------------------------
	ISDN: CAPI cleanup
	
	Remove unused header file.

	--------------------------------------------------------------
	ISDN: CAPI maintain driver MOD_USE_COUNT
	
	Apart from the indentation changes, add an owner field to the hardware
	driver struct and use that to automatically inc/dec the module use count
	on register_appl()/release_appl()

	--------------------------------------------------------------
	ISDN: CAPI: use <linux/list.h> lists
	
	

	--------------------------------------------------------------
	ISDN: export callbacks directly
	
	Just EXPORT_SYMBOL() the callbacks, instead of passing them to the
	drivers in a struct.

	--------------------------------------------------------------
	ISDN: CAPI: alloc struct capi_ctr dynamically
	
	First step in actually having the hardware drivers alloc this as part
	of their per-controller data.

	--------------------------------------------------------------
	ISDN: CAPI: alloc struct capi_appl dynamically
	
	First step in having the users alloc this as part of the state info
	they have to maintain anyway.

	--------------------------------------------------------------
	ISDN: CAPI remove NCCI up/down notification
	
	Applications really ought to take care of maintaing the state themselves,
	instead of cheating by listening to controller private messages.

	--------------------------------------------------------------
	ISDN: CAPI fix new "ncci up"
	
	There's actually two cases when a new NCCI is created:
	outgoing and incoming connections (had missed the latter)

	--------------------------------------------------------------
	Fix compile time warning in serial.c

	--------------------------------------------------------------
	Fix cut'n'paste error in drivers/message/Makefile

	--------------------------------------------------------------
	Cleanup drivers/pcmcia/Makefile
	
	Use the usual list-based approach. Still not too nice.

	--------------------------------------------------------------
	Remove PCMCIA backwards compatibility rule.
	
	Old pcmcia-cs versions expect the pcmcia modules in 
	/lib/modules/`uname -r`/pcmcia, so we symlinked them for compatibility.
	According to the comment, the generation of these links should have
	been removed in 2.4, so it's definitely time for it to go now.

	--------------------------------------------------------------
	Link drivers/char/* from drivers/char/Makefile
	
	Link the subdirs of drivers/char from drivers/char/Makefile instead the
	top-level Makefile. 
	
	Link order changes slightly, shouldn't case any problems, though.
	
	Fix drivers/char/pcmcia/Config.in.
	
	Cleanup drivers/char/pcmcia/Makefile.
	
	Fix rio build rules in drivers/char/Makefile.

	--------------------------------------------------------------
	Cleanup drivers/fusion/* build
	
	Don't shortcut from drivers/Makefile to 
	drivers/message/{fusion,i2o}/Makefile, but use intermediate
	drivers/message/Makefile.
	
	Cleanup drivers/message/fusion/Config.in and get rid of unnecessary
	CONFIG_FUSION_BOOT.

	--------------------------------------------------------------
	Cleanup drivers/pcmcia/Makefile part 2
	
	Adding some more flexibility to Config.in (Allow for core built-in but
	socket driver modular) cleans up the Makefile as well ;-)

	--------------------------------------------------------------
	Fix the Makefile cleanups
	


<laforge@gnumonks.org>
	--------------------------------------------------------------
	Netfilter ipt_ULOG fix:
	- If timers were pending during module unload, we would OOPS.


<mochel@segfault.osdl.org>
	--------------------------------------------------------------
	Move arch/i386/kernel/pci-*.c to arch/i386/kernel/pci/; prepare for further cleanups

	--------------------------------------------------------------
	Further split/cleanup of x86 PCI code

	--------------------------------------------------------------
	Split drivers/pci/pci.c into smaller, bite-size chunks

	--------------------------------------------------------------
	Further break-up-age
	Make ACPI PCI IRQ routing work a bit better...

	--------------------------------------------------------------
	don't enable debug in arch/i386/kernel/pci/

	--------------------------------------------------------------
	Fix NUMA compile after PCI cleanup

	--------------------------------------------------------------
	Move arch/i386/kernel/pci/ to arch/i386/pci/

	--------------------------------------------------------------
	PCI Update: Fix oops on boot w/ ACPI enabled

	--------------------------------------------------------------
	Re-add check for valid acpi routing information, instead of assuming it works


<neilb@cse.unsw.edu.au>
	--------------------------------------------------------------
	[PATCH] PATCH - kNFSd in 2.5.14 - Tidy up comments in expfs.c
	
	Chris Wright <chris@wirex.com>  suggested these to limit to 80
	columns and such.

	--------------------------------------------------------------
	[PATCH] PATCH - kNFSd in 2.5.14 - Two small changes to nfsd/nfssvc.c
	
	1/ Return correct error code if nfs server creation fails
	2/ Increase limit on number of nfsd threads
	
	   There is no real justification for stopping a sysadmin
	   from running lots and lots of nfsd threads, so we raise the
	   imposed limit from 128 to 8192... maybe it should just go away...

	--------------------------------------------------------------
	[PATCH] PATCH - kNFSd - Remove flowcontrol problems with lockd/tcp
	
	The sunrpc/tcp layer currently allocates some resources linearly with
	number of server threads.  This causes problems when there are very
	small numbers of threads (e.g. lockd with one thread), so this patch
	adds a small constant to the number of threads before calculating
	resoures to allocate.
	
	This patch also provide proper upper-limits for the response sizes for
	lockd requests, so resources are not over-allocated.
	
	Together these resolve problems with heavy lockd load over tcp.

	--------------------------------------------------------------
	[PATCH] PATCH - kNFSd in 2.5.14 - Add a kernel_lock in d_splice_alias
	
	d_move wants the kernel to be locked, so
	d_splice_alias now takes that lock.

	--------------------------------------------------------------
	[PATCH] PATCH - kNFSd/FAT in 2.5.14 - Add export_operations support for FAT
	
	This actually contains a lot of code that is never used,
	as we don't currently attempt to load an inode that isn't
	in cache, so the fat_get_parent is never actually reached.
	However it is there (and should be right) incase some brave
	soul does decide to enhance fat_get_dentry accordingly.

	--------------------------------------------------------------
	[PATCH] PATCH - kNFSd/ext3 in 2.5.14 - export_operations support for ext3
	
	This patch converts ext3 to use the new export_operations for
	exporting a filesystem.
	In particular it
	 - defines "ext3_get_parent" to do a lookup(".."),
	 - calls d_splice_alias when ext3_lookup finds something,
	   so that build a dcache path from the bottom up works, and
	 - sets sb->s_export_op to point to an (almost empty)
	   export_operations structure.  The fact that it is mostly empty
	   means that the default lookup operations are used, which match the
	   previous approach (i.e. use iget, and then check the generation
	   number).

	--------------------------------------------------------------
	[PATCH] PATHC - kNFSd/reiserfs in 2.5.14 - Convert reisferfs to use export_operations
	
	This patch converts reiserfs to use the new export_operations
	interface for exporting a filesystem instead of the old
	fh_to_dentry and dentry_to_fh.
	Essentially it:
	
	  - renamed reiserfs_dentry_to_fh to reiserfs_encode_fh
	  - split reiserfs_fh_to_dentry into reiserfs_get_dentry
	    and reiserfs_decode_fh
	  - calls d_splice_alias from reiserfs_lookup so that building
	    a dcache path from the bottom works well
	  - addes reiserfs_get_parent to do a lookup of ".." without going
	    through the VFS interfaces.
	  - sets sb->s_export_op to be an appropriately initialised
	    struct export_operations
	
	This has been tested and works.


<oliver@neukum.name>
	--------------------------------------------------------------
	[PATCH] USB printer freeing minors in probe error path
	
	fix a failure to free a minor in the error path of probe

	--------------------------------------------------------------
	[PATCH] usage count handling during disconnect
	
	in usb.c during disconnect handling a reference to a driver is passed
	after the module usage count is decremented. In theory this is a race.


<paulus@nanango.paulus.ozlabs.org>
	--------------------------------------------------------------
	PPC32: add SIGURG to the list of signals ignored by default

	--------------------------------------------------------------
	PPC32: add a subsys_initcall so pcibios_init gets called


<paulus@quango.ozlabs.ibm.com>
	--------------------------------------------------------------
	PPC32: Rename ppc_defs.h to asm-offsets.h to ease the transition to kbuild-2.5 later.

	--------------------------------------------------------------
	Update the Config.help for ppc32.  References to 486s and pentiums aren't
	really helpful here. :)


<paulus@samba.org>
	--------------------------------------------------------------
	Define pfn_to_page, page_to_pfn, pte_pfn, pfn_pte for ppc32.

	--------------------------------------------------------------
	PPC32: This changeset adds preemptible kernel support for ppc32
	and also streamlines the exception entry/exit code by not saving
	all the GPRs on the common exceptions (system call, external
	interrupt and decrementer).

	--------------------------------------------------------------
	PPC32: minor cosmetic changes, eliminate compile warnings

	--------------------------------------------------------------
	PPC32: fix serial clock for embedded EP405 board.

	--------------------------------------------------------------
	PPC32: remove some compiler warnings, xmon update

	--------------------------------------------------------------
	PPC32: powermac update from Ben Herrenschmidt.
	This adds support for recent powermac models and fixes a few bugs.

	--------------------------------------------------------------
	[PATCH] fix drivers/pci/Makefile for PPC
	
	On 32-bit PPC we don't need setup-bus.o but we do need setup-irq.o.
	This patch changes drivers/pci/Makefile to reflect that.

	--------------------------------------------------------------
	[PATCH] fix drivers/scsi/sd.c for ppc32
	
	This patch fixes the compile errors in sd_find_target, which is only
	used on 32-bit PPC systems, and changes the ifdef around from
	CONFIG_PPC to CONFIG_PPC32 since ppc64 doesn't need this routine.


<rob@osinvestor.com>
	--------------------------------------------------------------
	Sparc32 sun4c:
	- In sun4c_pmd_set, actually set the thing.
	- In ld_mmu_sun4c, pmd_set no longer BTFIXUPCALL_NOP.


<robert.olsson@data.slu.se>
	--------------------------------------------------------------
	IPV4: Add statistics for route cache GC monitoring.


<sfr@canb.auug.org.au>
	--------------------------------------------------------------
	[PATCH] USE_STANDARD_AS_RULE in i386 arch Makefiles
	
	In Rules.make, a comment says:
	
	# Old makefiles define their own rules for compiling .S files,
	# but these standard rules are available for any Makefile that
	# wants to use them.  Our plan is to incrementally convert all
	# the Makefiles to these standard rules.  -- rmk, mec
	
	This patch does that for the i386 arch Makefiles.

	--------------------------------------------------------------
	[PATCH] Directory Notification Fix
	
	This patch fixes directory notification so that notifications get
	cancelled when a process exits.  This make dnotify MUCH more stable and
	usable :-)


<shaggy@austin.ibm.com>
	--------------------------------------------------------------
	[PATCH] Fix JFS file system corruption
	
	JFS: Flush dirty metadata to disk when remounting from read-write
	to read-only.  Also fix umount ordering to make sure metadata is
	written before journal closed.
	
	With Andrew Morton's recent changes, JFS is no longer writing much
	of its dirty metadata when remounting from read-write to read-only.
	This causes severe file system corruption.  A JFS root file system
	will be corrupted on shutdown.
	
	This patch fixes the problem by explicitly writing the dirty metadata
	before the journal is closed.  It also fixes the ordering so that
	the dirty metadata is completely written before the journal is closed
	for the normal unmount case as well.


<torvalds@home.transmeta.com>
	--------------------------------------------------------------
	Re-apply Dave's VIA quirk update from 2.4.x
	after the manual merge of the PCI re-organization
	removed it.

	--------------------------------------------------------------
	Update kernel version


<torvalds@penguin.transmeta.com>
	--------------------------------------------------------------
	Add SIGURG to list of ignore-by-default signals

	--------------------------------------------------------------
	Fix makefile errors


<trini@bill-the-cat.bloom.county>
	--------------------------------------------------------------
	PPC32: Update Motorola LoPEC support to match recent changes.

	--------------------------------------------------------------
	PPC32: Minor cleanups to the i8259 and OpenPIC code.  From myself and
	Hollis Blanchard.

	--------------------------------------------------------------
	PPC32: Modify the OpenPIC code to allow for all combinations of sense
	and polarity of IRQs.  Update the machines in CONFIG_ALL_PPC for this change.

	--------------------------------------------------------------
	PPC32: define some important magic constants.

	--------------------------------------------------------------
	PPC32: Modify openpic_get_irq() to call i8259_irq() for cascaded IRQs.  This
	requires that i8259_init() be called with the real address where PCI
	interrupt-acknowledge transactions will be generated.

	--------------------------------------------------------------
	Fix building of CONFIG_XMON && !CONFIG_MAGIC_SYSRQ


<vandrove@vc.cvut.cz>
	--------------------------------------------------------------
	[PATCH] NLS: Invalid koi8-ru return values
	
	During my lurking around NLS code I found that KOI8-RU returns character
	code instead of length of character for two characters.
	
						Petr Vandrovec

	--------------------------------------------------------------
	[PATCH] NLS: Allow user to select 1:1 mapping
	
	This allows user to select 'default' encoding, which has defined mapping
	for each of 255 byte values, so one can use it as a fallback when it
	finds filesystem with unknown encoding (EBCDIC for example) just to get
	characters through filesystem.
	
					Petr Vandrovec


<vojtech@twilight.ucw.cz>
	--------------------------------------------------------------
	Fix for the previous fix. hid->name is 128 bytes, not 64 bytes long.

	--------------------------------------------------------------
	This fixes a possible buffer overflow in hid-core.c in case a
	device would have very long string descriptors (vendor and device
	name.)


<zippel@linux-m68k.org>
	--------------------------------------------------------------
	[PATCH] m68k: atari updates [2/20]
	
	Some compile fixes.

	--------------------------------------------------------------
	[PATCH] m68k: AFFS update [1/20]
	
	- sizeof changes from Kernel Janitor Project
	- several bug fixes found with fsx

	--------------------------------------------------------------
	[PATCH] m68k: bitops update [3/20]
	
	Add __clear_bit/__ffs/sched_find_first_bit.

	--------------------------------------------------------------
	[PATCH] m68k: add cacheflush.h [4/20]
	
	This moves several cache flush function into cacheflush.h.

	--------------------------------------------------------------
	[PATCH] m68k: config.in update [5/20]
	
	Update to the latest config.in.

	--------------------------------------------------------------
	[PATCH] m68k: license updates [7/20]
	
	Add missing license tags.

	--------------------------------------------------------------
	[PATCH] m68k: hp300 update [8/20]
	
	compile fix

	--------------------------------------------------------------
	[PATCH] m68k: idle update [10/20]
	
	Fix idle functions.

	--------------------------------------------------------------
	[PATCH] m68k: remove hwclk_time/gettod [9/20]
	
	- replace hwclk_time with rtc_time
	- use hwclk instead of gettod to set initial time

	--------------------------------------------------------------
	[PATCH] m68k: add missing include [11/20]
	
	Add missing include files.

	--------------------------------------------------------------
	[PATCH] m68k: Rename KTHREAD_SIZE [12/20]
	
	This patch renames KTHREAD_SIZE into THREAD_SIZE, similiar to all other archs.

	--------------------------------------------------------------
	[PATCH] m68k: math-emu updates [13/20]
	
	Compile fixes

	--------------------------------------------------------------
	[PATCH] m68k: rename p_pptr [14/20]
	
	Rename p_pptr into parent.

	--------------------------------------------------------------
	[PATCH] m68k: readd lost proc functions [15/20]
	
	These function were removed by a "cleanup", but they are still used.

	--------------------------------------------------------------
	[PATCH] m68k: rlimits update [16/20]
	
	Update INIT_RLIMITS.

	--------------------------------------------------------------
	[PATCH] m68k: seq_file fixes [17/20]
	
	update some proc functions to use the seq_file interface

	--------------------------------------------------------------
	[PATCH] m68k: add tlbflush.h [18/20]
	
	Move several tlb functions into tlbflush.h.

	--------------------------------------------------------------
	[PATCH] m68k: add show_trace/show_trace_task [19/20]
	
	extract show_trace()/show_trace_task() out of dump_stack().

	--------------------------------------------------------------
	[PATCH] m68k: zorro updates [20/20]
	
	- small compile fixes
	- id update
	- add asm-ppc/zorro.h

	--------------------------------------------------------------
	[PATCH] m68k: driver updates [6/20]
	
	- kdev_t fixes
	- bio fixes
	- other cleanups and compile fixes



--7JfCtLOvnd9MIVvH
Content-Type: application/x-perl
Content-Disposition: attachment; filename="fmtcl.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl -w=0A=0Ause strict;=0A=0Amy %people =3D ();=0Amy $addr =3D =
"";=0Amy @cur =3D ();=0Amy @sorted =3D ();=0A=0Asub append_item() {=0A	if (=
!$addr) { return; }=0A	if (!$people{$addr}) { @{$people{$addr}} =3D (); }=
=0A	push @{$people{$addr}}, [@cur];=0A=0A	@cur =3D ();=0A}=0A=0Awhile (<>) =
{=0A	# Match address=0A	if (/^\s*<([^>]+)>/) {=0A		# Add old item (if any) =
before beginning new=0A		append_item();=0A		$addr =3D $1;=0A	} elsif ($addr=
) {=0A		# Add line to patch=0A		# s/^\s*(.*)\s*$/$1/;=0A		s/^(.*)\s*$/$1/;=
=0A		push @cur, "$_\n";=0A	} else {=0A		# Header information=0A		print;=0A	=
}=0A}=0A=0Asub print_terse_items($) {=0A	my @items =3D @{$people{$_[0]}};=
=0A	# Vain attempt to sort patches from one address=0A	@items =3D sort @ite=
ms;=0A	while ($_ =3D shift @items) {=0A		# Insert a bullet=0A		my $line; $l=
ine =3D @$_[0];=0A		$line =3D~ s/^(\s*)(.*)$/$1o  $2/;=0A		print "$line";=
=0A	}=0A}=0A=0Asub print_items($) {=0A	my @items =3D @{$people{$_[0]}};=0A	=
# Vain attempt to sort patches from one address=0A	@items =3D sort @items;=
=0A	while ($_ =3D shift @items) {=0A		# Item separator=0A		print "\t-------=
-------------------------------------------------------\n";=0A		my $line; f=
oreach $line (@$_) { print "$line"; }=0A	}=0A}=0A=0Aappend_item();=0A@sorte=
d =3D sort keys %people;=0Aprint "-- Terse ChangeLog starts here --\n\n";=
=0Aforeach $addr (@sorted) {=0A	print "<$addr>\n";=0A	print_terse_items($ad=
dr);=0A	print "\n";=0A}=0Aprint "-- Full ChangeLog starts here --\n\n";=0Af=
oreach $addr (@sorted) {=0A	print "<$addr>\n";=0A	print_items($addr);=0A	pr=
int "\n";=0A}=0A
--7JfCtLOvnd9MIVvH--
