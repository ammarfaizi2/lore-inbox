Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314329AbSEBKZm>; Thu, 2 May 2002 06:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSEBKZl>; Thu, 2 May 2002 06:25:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:21508 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314329AbSEBKZc>; Thu, 2 May 2002 06:25:32 -0400
Message-Id: <200205021022.g42AMaX06485@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: lk maintainers
Date: Thu, 2 May 2002 13:25:42 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This document is mailed to lkml regularly and will be modified
whenever new victim wishes to be listed in it or someone can
no longer devote his time to maintainer work.

If you want your entry added/updated/removed, contact me.
--
vda
------- cut here ------ cut here ------ cut here ------ cut here ------

So, you are new to Linux kernel hacking and want to submit a kernel bug
report or a patch but don't know how to do it and _where_ to report it?
Then save this file for future reference.

Preparing bug report:
=====================
Compile problems: report GCC output and result of "grep '^CONFIG_' .config"
Oops: decode it with ksymoops
Unkillable process: Alt-SysRq-T and ksymoops relevant part
Yes it means you should have ksymoops installed and tested,
which is easy to get wrong. I've done that too often.

More info in the FAQ at http://www.tux.org/lkml/

Sending bug report/patch:
=========================
* Some device drivers have active developers, try to contact them first.
* Otherwise find a subsystem maintainer to which your report pertains
  and send report to his address.
* Small fixes and device driver updates are best directed to subsystem
  maintainers and "small bits" integrators.
* It never hurts to CC: Linux kernel mailing list, but without specific
  maintainer address in To: field there is high probability that your
  patch won't be noticed. You have been warned.
* Do not send it to all addresses at once! This will annoy lots of people
  and isn't useful at all. It's a spam.
* Do NOT send small fixes to Linus, he just can't handle _everything_.
  He will eventually receive it from maintainers/integrators, send it
  their way.
* If your patch is something big and new, announce it on lkml and try
  to attract testers. After it has been tested and discussed, you can
  expect Linus to consider inclusion in mainline.


		Current Linux kernel people

Note that this list is sorted in reversed date order, most recent
entries first. This means than entries at bottom can be outdated :-(


Linux kernel mailing list <linux-kernel@vger.kernel.org>
	Post anything related to Linux kernel here, but nothing else :-)

Dave Jones <davej@suse.de> [23 apr 2002]
	I collect various bits and pieces for inclusion in 2.5,
	especially small and trivial ones and driver updates.
	I'll feed them to Linus when (and if) they
	are proved to be worthy.

Andre Hedrick <andre@linux-ide.org> [09 apr 2002]
	ATA/ATAPI Storage Architect [2.0,2.2,2.4]
	HBA interface developer
	Serial ATA Architect [future release]
	Voting NCITS member AT-Attachment Committee

Andrea Arcangeli <andrea@suse.de> [28 mar 2002]
	Send VM related bug reports and patches to me.
	I'm especially interested in VM issues with:
	* lots of RAM and CPUs
	* NUMA
	* heavy swap scenarios
	* performance of I/O intensive workloads (in particular
	  with lots of async buffer flushing involved)
	See also Martin J. Bligh <Martin.Bligh@us.ibm.com> entry
	Mail also:
	Arjan van de Ven <arjanv@redhat.com>

Martin J. Bligh <Martin.Bligh@us.ibm.com> [28 mar 2002]
	I'm interested in VM issues with lots (>4G for i386)
	of RAM, lots of CPUs, NUMA

Steven Whitehouse <steve@chygwyn.com> [27 mar 2002]
	I am the Linux DECnet network stack maintainer
	Visit http://www.chygwyn.com/decnet/

Pavel Machek <pavel@ucw.cz> [27 mar 2002]
	I am network block device maintainer.
	http://nbd.sf.net

Arnaldo Carvalho de Melo <acme@conectiva.com.br> [26 mar 2002]
	IPX, 802.2 LLC, NetBEUI, http://kerneljanitors.org,
	cyclom2x sync card driver

John Cagle <jcagle@kernel.org> [19 mar 2002]
	The current maintainer of devices.txt, the list of
	assigned device numbers for LANANA.  Consult the web
	site (www.lanana.org) for instructions on submitting
	requests for new device numbers.  Send all device
	related email to <device@lanana.org>.

Tigran Aivazian <tigran@veritas.com>
	I am author and maintainer of BFS filesystem and IA32
	microcode update driver.

Rogier Wolff <R.E.Wolff@BitWizard.nl> [12 mar 2002]
	I do "specialix serial ports":
	drivers/char/specialix.c (IO8+)
	drivers/char/sx.c        (SX, SI, SIO)
	drivers/char/rio/*.c     (RIO)

Martin Dalecki <martin@dalecki.de> [11 mar 2002]
	IDE subsystem maintainer for 2.5
	(mail Vojtech Pavlik <vojtech@suse.cz> too)

Ed Vance <serial24@macrolink.com> [05 mar 2002]
	Maintainer for the generic serial driver, serial.c,
	for 2.2 and 2.4 kernels.  Please post patches to
	linux-serial@vger.kernel.org for tested bug
	fixes or to add support for a new serial device.
	Limited to time available. If I have not responded
	in a week, yell at serial24@macrolink.com

netfilter/iptables development <netfilter-devel@lists.samba.org> [23 feb 2002]
	Please report all netfilter/iptables related problems
	to this mailinglist, where all netfilter developers are present.
	See also http://www.netfilter.org/contact.html

Hans Reiser <reiser@namesys.com> [16 feb 2002]
	Send me all reiserfs related patches with a cc to
	reiserfs-dev@namesys.com, send bug reports to
	reiserfs-dev@namesys.com, send paid support requests to
	support@namesys.com after going to www.namesys.com/support.html
	to pay, send discussions (not bug reports unless they are
	interesting to most persons) to reiserfs-list@namesys.com.
	If we sit on your patch for a week without responding,
	yell at us, we deserve it.  Look at our web page
	at www.namesys.com for more about sending us code,
	working with us, and our patch submission and tracking system.

Paul Bristow <paul@paulbristow.net> [16 feb 2002]
	I am an ide-floppy driver maintainer
	(ATAPI ZIP, LS-120/240 Superdisk, Clik! drives).

Mike Phillips <phillim2@comcast.net> [15 feb 2002]
	Token ring subsystem and drivers.

Anton Altaparmakov <aia21@cam.ac.uk> [15 feb 2002]
	I am the NTFS guy.

https://bugzilla.redhat.com/bugzilla [14 feb 2002]
	Reports of problems with the Red Hat shipped kernels.

Alan Cox <alan@lxorguk.ukuu.org.uk> [14 feb 2002]
	Linux 2.2 maintainer (maintenance fixes only).
	Collator of patches for unmaintained things in 2.2/2.4.
	Maintainer of the 2.4-ac (2.4 plus stuff being tested) tree.
	I2O, sound, 3c501 maintainer for 2.2/2.4.

Robert Love <rml@tech9.net> [14 feb 2002]
	Preemptible kernel is mine.

ALSA development <alsa-devel@alsa-project.org> [12 feb 2002]
Jaroslav Kysela <perex@perex.cz> [12 feb 2002]
	Advanced Linux Sound Architecture
	ALSA patches are available at
	ftp://ftp.alsa-project.org/pub/kernel-patches/*

Neil Brown <neilb@cse.unsw.edu.au> [08 feb 2002]
	I am interested in any issues with the code in:
	NFS server    (fs/nfsd/*)
	software RAID (drivers/md/{md,raid,linear}*)
	or related include files.

Maksim Krasnyanskiy <maxk@qualcomm.com> [08 feb 2002]
	I'm author and maintainer of the Bluetooth subsystem
	and Universal TUN/TAP device driver.
	These days mostly working on Bluetooth stuff.

Rik van Riel <riel@conectiva.com.br> [07 feb 2002]
	Send me VM related stuff, please CC to linux-mm@kvack.org

Geert Uytterhoeven <geert@linux-m68k.org> [07 feb 2002]
	I work on the frame buffer subsystem, the m68k port (Amiga part),
	and the PPC port (CHRP LongTrail part).
	Unfortunately I barely have spare time to really work on these
	things. My job is not Linux-related (so far :-). I can not
	promise anything about my maintainership performance.

H. Peter Anvin <hpa@zytor.com> [07 feb 2002]
	i386 boot and feature code, i386 boot protocol, autofs3,
	compressed iso9660 (but I'll accept all iso9660-related
	changes.)  kernel.org site manager; please contact me
	for sponsorship-related issues.

kernel.org admins <ftpadmin@kernel.org> [07 feb 2002]
	Kernel.org sysadmins.  Contact us if you notice something breaks,
	or if you want a change make sure you give us at least 1-2 weeks.
	Please note that we got a lot of feature requests, a lot of
	which conflict or simply aren't practical; we don't have time to
	respond to all requests.

Greg KH <greg@kroah.com> [07 feb 2002]
	I am USB and PCI Hotplug maintainer.

Trond Myklebust <trond.myklebust@fys.uio.no> [07 feb 2002]
	I am NFS client maintainer.

James Simmons <jsimmons@transvirtual.com> [07 feb 2002]
	Console and framebuffer sybsustems.
	I also play around with the input layer.

Richard Gooch <rgooch@atnf.csiro.au> [07 feb 2002]
	I maintain devfs. I want people to Cc: me when reporting devfs
	problems, since I don't read all messages on linux-kernel.
	Send devfs related patches to me directly, rather than
	bypassing me and sending to Linus/Marcelo/Alan/Dave etc.

Russell King <rmk@arm.linux.org.uk> [06 feb 2002]
	ARM architecture maintainer.  Please send all ARM patches through
	the patch system at http://www.arm.linux.org.uk/developer/patches/
	New serial drivers maintainer for 2.5.  Submit patches to
	rmk+serial@arm.linux.org.uk

Andrew Morton <akpm@zip.com.au> [05 feb 2002]
	I'm receptive to any reproducible bug anywhere in the 2.4 kernel.
	Specialising in ext2, ext3 and network drivers.
	Not thinking about 2.5.x at this time.

Petr Vandrovec <vandrove@vc.cvut.cz> [05 feb 2002]
	ncpfs filesystem, matrox framebuffer driver, problems related
	to VMware - in all of 2.2.x, 2.4.x and 2.5.x.

Reiserfs developers list <reiserfs-dev@namesys.com> [05 feb 2002]
	Send all reiserfs-related stuff here including but not limited to bug
	reports, fixes, suggestions.

Oleg Drokin <green@linuxhacker.ru> [05 feb 2002]
	SA11x0 USB-ethernet and SA11x0 watchdog are mine.

Vojtech Pavlik <vojtech@ucw.cz> [05 feb 2002]
	Feel free to send me bug reports and patches to input device drivers
	(drivers/input/*, drivers/char/joystick/*)
	I also want to receive bug reports and patches for following
	USB drivers: printer, acm, catc, hid*, usbmouse, usbkbd, wacom.
	All other (not in the list) USB driver changes should go to USB
	maintainer (hopefully there is one listed here :-).
	Also CC me if you are posting VIA IDE driver related message
	(although I am not IDE subsystem maintainer).

======= These entries are suggested by lkml folks ========

Ralf Baechle <ralf@gnu.org> [27 mar 2002]
	I am mips/mips64 maintainer.

David S. Miller <davem@redhat.com> [07 feb 2002]
	I am Sparc64 and networking core maintainer.

======= These ones I made myself ========
======= I am waiting confirmation/correction from these people ========

Urban Widmark <urban@teststation.com> [13 feb 2002]
	smbfs

Jeff Garzik <jgarzik@mandrakesoft.com> [12 feb 2002]
	I am the network-card-drivers guy (8139 for instance).
	CC me and Andrew Morton <akpm@zip.com.au> on network driver patches.

video4linux list <video4linux-list@redhat.com> [12 feb 2002]
Gerd Knorr <kraxel@bytesex.org> [12 feb 2002]
	video4linux

Tim Waugh <twaugh@redhat.com> [08 feb 2002]
	> Who is maintaining the linux iomega stuff?
	For 2.4.x, me (in theory). I don't have time for 2.5.x at the moment.

Alexander Viro <viro@math.psu.edu> [5 feb 2002]
	I am NOT a fs subsystem maintainer. But I won't kill
	you if you send me some generic fs bug reports and (hopefully) patches.

Eric S. Raymond <esr@thyrsus.com> [5 feb 2002]
	Send kernel configuration bug reports and suggestions to me.
	Also I'll be more than happy to accept help enties for kernel config
	options (Configure.help).

G?rard Roudier <groudier@free.fr> [5 feb 2002]
	I am SCSI guy.

Ingo Molnar <mingo@elte.hu> [5 feb 2002]
	New scheduler in 2.5 and Tux are mine.

Jens Axboe <axboe@suse.de> [5 feb 2002]
	I am block device subsystem maintainer.

Keith Owens <kaos@ocs.com.au> [5 feb 2002]
	ksymoops, kbuild, .. .. .. .. .  are mine.

Linus Torvalds <torvalds@transmeta.com> [5 feb 2002]
	Do not send anything to me unless it is for 2.5, well tested,
	discussed on lkml and is used by significant number of people.
	In general it is a bad idea to send me small fixes and driver
	updates, send them to subsystem maintainers and/or
	"small stuff" integrator (currently Dave Jones <davej@suse.de>,
	see his entry). Sorry, I can't do everything.

Marcelo Tosatti <marcelo@conectiva.com.br> [5 feb 2002]
	Do not send anything to me unless it is for 2.4 and well tested.
	If you are sending me small fixes and driver updates, send
	a copy to subsystem maintainers and/or "small stuff" integrators:
	- Alan Cox <alan@lxorguk.ukuu.org.uk>,
	- Rusty Russell <trivial@rustcorp.com.au>.

Rusty Russell <rusty@rustcorp.com.au> [5 feb 2002]
	> Here are some cleanups of whitespace in .....
	Want me to add this to the trivial patch collection for tracking?
	If so just send (or cc:) it to trivial@rustcorp.com.au.
