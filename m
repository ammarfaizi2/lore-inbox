Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTFEKml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 06:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTFEKml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 06:42:41 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:30471 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S264592AbTFEKmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 06:42:33 -0400
Message-Id: <200306051047.h55Al5u22990@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: lk maintainers
Date: Thu, 5 Jun 2003 13:52:24 +0300
X-Mailer: KMail [version 1.3.2]
Cc: schmurtz@netcourrier.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This document is mailed to lkml regularly and will be modified
whenever new victim wishes to be listed in it or someone can
no longer devote his time to maintainer work.

If you want your entry added/updated/removed, contact me.

BTW, requests to move your entry to the top of the list
without actually changing the text are fine too: that
will indicate that entry is not outdated, so don't be shy ;-)
--
vda
------- cut here ------ cut here ------ cut here ------ cut here ------

So, you are new to Linux kernel hacking and want to submit a kernel bug
report or a patch but don't know how to do it and _where_ to report it?

Preparing bug report:
=====================
*** Remember: bad/incomplete bug report ONLY wastes bandwidth! ***
How To Ask Questions The Smart Way:
    http://www.catb.org/~esr/faqs/smart-questions.html
	Anybody who has written software for public use will
	probably have received at least one bad bug report.
	Reports that say nothing ("It doesn't work!");
	reports that make no sense; reports that don't give
	enough information; reports that give wrong information.
How to Report Bugs Effectively:
    http://www.chiark.greenend.org.uk/~sgtatham/bugs.html
	Before asking a technical question by email, or in
	a newsgroup, or on a website chat board, do the following:
	* Try to find an answer by searching the Web.
	* Try to find an answer by reading the manual.
	* Try to find an answer by reading a FAQ.
	* Try to find an answer by inspection or experimentation.
	* Try to find an answer by reading the source code.
Compile problems: report GCC output and result of
	"grep '^CONFIG_' .config"
Oops: decode it with ksymoops (or use 2.5 with kksymoops enabled ;).
Unkillable process: Alt-SysRq-T and ksymoops relevant part.
Yes it means you should have ksymoops installed and tested,
which is easy to get wrong. I've done that too often.

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

Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> [21 may 2003]
        IDE SUBSYSTEM

Andre Hedrick <andre@linux-ide.org> [15 apr 2003]
	ATA/ATAPI Storage Architect [2.0,2.2,2.4,2.5]
	HBA interface developer
	Serial ATA Architect [released][backported]

George Anzinger <george@mvista.com> [19 mar 2003]
	I maintain the posix-timers and related code.

Miles Bader <miles@gnu.org> [13 mar 2003]
	I'm maintainer of the v850 port (uClinux).
	There's a more generic mailing address that might be better though:
	<uclinux-v850@lsi.nec.co.jp>

Jesse Barnes <jbarnes@sgi.com> [28 feb 2003]
	I maintain arch/ia64/sn (SGI SN support for IA64) in the 2.5 tree,
	and John Hesterberg <jh@sgi.com> does the same for 2.4

http://bugzilla.kernel.org [13 feb 2003]
	Database of 2.5 bugs.

Martin J. Bligh <mbligh@aracnet.com> [13 feb 2003]
	I am the maintainer for the kernel bugtracker (bugzilla.kernel.org)
	I'm interested in kernel issues with:
	* NUMA / discontigmem
	* VM issues with lots (>4Gb) of RAM
	* Scalability issues with > 2 CPUs
	See also:
	Andrea Arcangeli <andrea@suse.de>

John Bradford <john@grabjohn.com> [13 feb 2003]
	I maintain an unofficial kernel bug database at
	http://grabjohn.com/kernelbugdatabase
	and I'm also happy to help people who are trying
	to get run Linux usefully on old and/or low spec
	machines, (4 MB 486s, etc).

Dave Olien <dmo@osdl.org> [12 feb 2003]
	I maintain DAC960 RAID controller driver
	Visit http://www.osdl.org/archive/dmo/DAC960

Benjamin Herrenschmidt <benh@kernel.crashing.org> [27 jan 2003]
	My duty is to try to make sure Apple's PowerMacs
	happily run the Linux kernel.
	I also do various things related to the PPC port (more
	specifically PPC32), so I'd appreciate beeing CC'ed any
	comment, patch or bug report regarding the PPC architecture

Adam Belay <ambx1@neo.rr.com> [17 dec 2002]
	I am Plug and Play maintainer.

Andrew Morton <akpm@digeo.com> [10 dec 2002]
	- VM
	- The "data" part of the VFS: pagecache, buffer layer, etc.
	- memory management
	- ext2 and ext3
	- 3c59x.c
	- direct-IO

James Simmons <jsimmons@infradead.org> [28 Nov 2002]
	Console and framebuffer subsystems.
	I also play around with the input layer.

Petko Manolov <petkan@users.sourceforge.net> [27 nov 2002]
	pegasus and rtl8150 usb-ethernet drivers maintainer.
	Interested in any bugs or new devices related to those drivers.
	string-486.h code maintainer.

Greg Ungerer <gerg@snapgear.com> [14 nov 2002]
	uClinux (MMU-less support) maintainer. I'll take antyhing
	specifically related to MMU-less support or any of the
	MMU-less architecture branches (m68knommu, v850, etc).
	I would highly recommend sending to uclinux-dev@uclinux.org
	mailing list as well.

Jeff Garzik <jgarzik@mandrakesoft.com> [24 sep 2002]
	I am the network-card-drivers guy (8139 for instance).
	CC me and Andrew Morton <akpm@digeo.com> on network driver patches.

Jan-Benedict Glaw <jbglaw@lug-owl.de> [18 sep 2002]
	I'm responsible for Alpha's srm_env driver, providing access to
	SRM's firmware variables.

Stuart MacDonald <stuartm@connecttech.com> [13 sep 2002]
	Connect Tech's linux kernel guy. Currently includes hacking on
	drivers/char/serial.c (Blue Heat, Xtreme, Dflex) and maintaining
	drivers/usb/serial/whiteheat.c (WhiteHEAT)

Vojtech Pavlik <vojtech@ucw.cz> [13 sep 2002]
	Feel free to send me bug reports and patches to input device drivers
	(drivers/input/*, drivers/char/joystick/*)
	I also want to receive bug reports and patches for following
	USB drivers: printer, acm, catc, hid*, usbmouse, usbkbd, wacom.
	All other (not in the list) USB driver changes should go to USB
	maintainer (hopefully there is one listed here :-).
	Also CC me if you are posting VIA IDE driver related message
	(although I am not IDE subsystem maintainer).

Robert Love <rml@tech9.net> [12 sep 2002]
	Preemptible kernel maintainer.
	I am also interesting in anything related to scheduling or locking
	primitives.

Jan Kara <jack@suse.cz> [22 aug 2002]
	quota subsystem maintainer

Paul Larson <plars@linuxtestproject.org> [20 aug 2002]
	I'm a maintainer for the Linux Test Project and it would be nice
	if people knew to send their test programs, etc. to me.  I see
	a lot of them flying around on lkml and try to catch them when
	I can, but it's a lot to keep up with.  It would be even better
	if people just knew to send them our way so we could clean
	them up and put them in LTP for regression testing.

Dave Engebretsen <engebret@vnet.ibm.com> [15 aug 2002]
	PPC64 architecture maintainer.  Please send PPC64 patches to me
	and our mailing list at <linuxppc64-dev@lists.linuxppc.org>

Ingo Molnar <mingo@elte.hu> [30 jul 2002]
	Ingo wrote the new scheduler for 2.5.

Ralf Baechle <ralf@uni-koblenz.de> [30 jul 2002]
	I am maintainer of the AX.25 code

Victor Yodaiken <yodaiken@fsmlabs.com> [30 jul 2002]
	RTLinux patches, updates, contributions, drivers.
	Please send first to the list: rtl@rtlinux.org

Pavel Machek <pavel@ucw.cz> [27 jul 2002]
	I am network block device maintainer. Visit http://nbd.sf.net.
	(see Steven Whitehouse <steve@gw.chygwyn.com> entry)
	I am working on software suspend.

William Irwin <wli@holomorphy.com> [02 jul 2002]
	Send bug reports and/or feature requests related to many tasks,
	rmap, space consumption, or allocators to me. I'm involved in
	* rmap
	* memory allocators
	* reducing space consumed by data structures (e.g. struct page)
	* issues arising in workloads with many tasks
	* kernel janitoring
	See also:
	Rik van Riel <riel@surriel.com>
	Andrea Arcangeli <andrea@suse.de>
	Martin Bligh <Martin.Bligh@us.ibm.com>
	Andrew Morton <akpm@digeo.com>

Dave Jones <davej@suse.de> [23 apr 2002]
	I collect various bits and pieces for inclusion in 2.5,
	especially small and trivial ones and driver updates.
	I'll feed them to Linus when (and if) they
	are proved to be worthy.

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

Steven Whitehouse <steve@chygwyn.com> [27 mar 2002]
	I am the Linux DECnet network stack maintainer
	Visit http://www.chygwyn.com/decnet/

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

Ed Vance <serial24@macrolink.com> [05 mar 2002]
	Maintainer for the generic serial driver, serial.c,
	for 2.2 and 2.4 kernels.  Please post patches to
	linux-serial@vger.kernel.org for tested bug
	fixes or to add support for a new serial device.
	Limited to time available. If I have not responded
	in a week, yell at serial24@macrolink.com

netfilter/iptables <netfilter-devel@lists.samba.org> [23 feb 2002]
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
	changes).  kernel.org site manager; please contact me
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

Petr Vandrovec <vandrove@vc.cvut.cz> [05 feb 2002]
	ncpfs filesystem, matrox framebuffer driver, problems related
	to VMware - in all of 2.2.x, 2.4.x and 2.5.x.

Reiserfs developers list <reiserfs-dev@namesys.com> [05 feb 2002]
	Send all reiserfs-related stuff here including but not limited to bug
	reports, fixes, suggestions.

Oleg Drokin <green@linuxhacker.ru> [05 feb 2002]
	SA11x0 USB-ethernet and SA11x0 watchdog are mine.

======= These entries are suggested by lkml folks ========

Ralf Baechle <ralf@gnu.org> [27 mar 2002]
	I am mips/mips64 maintainer.

David S. Miller <davem@redhat.com> [07 feb 2002]
	I am Sparc64 and networking core maintainer.

======= These ones I made myself ========
======= I am waiting confirmation/correction from these people ========

Urban Widmark <urban@teststation.com> [13 feb 2002]
	smbfs

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

Gérard Roudier <groudier@free.fr> [5 feb 2002]
	I am SCSI guy.

Jens Axboe <axboe@suse.de> [5 feb 2002]
	I am block device subsystem maintainer.

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

======= Entries which were valid sometime ago. Not valid anymore ========
======= Retained for historic (and hall-of-fame) purposes ===============
Martin Dalecki <martin@dalecki.de> [11 mar 2002]
	IDE subsystem maintainer for 2.5
