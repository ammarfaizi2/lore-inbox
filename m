Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287254AbSBGK4v>; Thu, 7 Feb 2002 05:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287276AbSBGK4m>; Thu, 7 Feb 2002 05:56:42 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56590 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S287254AbSBGK4a>; Thu, 7 Feb 2002 05:56:30 -0500
Message-Id: <200202071054.g17Asst06608@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: [RFC] List of maintainers (draft #3)
Date: Thu, 7 Feb 2002 12:54:56 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After recent discussion on Linux development practices I think it may be
worthy to have list of lk maintainers. Unlike one included into kernel
source, this document is meant to be monthly (weekly?) mailed to lkml
and to be modified whenever new victim wishes to be listed in it
or someone can no longer devote his time to maintainer work.

This is a third draft. I picked some names and addresses and made entried for 
them. If you want to be in this list, mail me your corrected entry.

Please indicate what kind of reports you wish to receive and what kind of 
reports you DON'T want to see.

I want these entries to sound like "Hey, I am working on these parts of the
kernel, if you have something, send it to me not to Linus". With precise
indication of those parts and your level of involvement:

If you don't want to be in this list, mail me too - I'll remove your entry.

Note that English isn't my native language, feel free to correct any mistakes.
--
vda

* * * * DRAFT * * * *

So, you are new to Linux kernel hacking and want to submit a kernel bug
report or a patch but don't know how to do it and _where_ to report it?

Preparing bug report:
=====================
Oops: decode it with ksymoops
Unkillable process: Alt-SysRq-T and ksymoops relevant part
* Yes it means you should have ksymoops installed and tested!
* More info in the FAQ at http://www.tux.org/lkml/

Sending bug report/patch:
=========================
* It never hurts to send to Linux kernel mailing list.
* Some device drivers have active developers, try to contact them first.
* Otherwise find a subsystem maintainer to which your report pertains
  and send report to his address.
* Small fixes and device driver updates are best directed to subsystem
  maintainers and "small bits" integrators.
* Do not send it to all addresses at once! This will annoy lots of people
  and isn't useful at all.
* Do NOT send it to Linus.
* If your patch is something big and new, announce it on lkml and try
  to attract testers. After it has been tested and discussed, you can
  expect Linus to consider inclusion in mainline.

Note that this list is sorted in reversed date order, most recent
entries first. This means than entries at bottom can be outdated :-(


		Current Linux kernel people

Linux kernel mailing list <linux-kernel@vger.kernel.org>
	Post anything related to Linux kernel here, but nothing else :-)

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
	I maintain devfs.  I want people to Cc: me when reporting devfs
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

David S. Miller <davem@redhat.com> [07 feb 2002]
	I am Sparc64 and networking core maintainer.

======= These ones I made myself ========
======= I am waiting confirmation from these people ========

Alan Cox <alan@lxorguk.ukuu.org.uk> [5 feb 2002]
	I am 2.2 maintainer.
	I collect various bits and pieces for inclusion in 2.4.
	You may send unmaintained driver fixes/updates to me.

Alexander Viro <viro@math.psu.edu> [5 feb 2002]
	I am NOT a fs subsystem maintainer. But I won't kill
	you if you send me some generic fs bug reports and (hopefully) patches.

Andre Hedrick <andre@linux-ide.org> [5 feb 2002]
	I am IDE guy.

Andrea Arcangeli <andrea@suse.de> [5 feb 2002]
	Send VM related bug reports and patches to me.

Arnaldo Carvalho de Melo <acme@conectiva.com.br> [5 feb 2002]
	?

Dave Jones <davej@suse.de> [5 feb 2002]
	I collect various bits and pieces for inclusion in 2.5,
	espesially small and trivial ones and driver updates. Do not bother
	Linus with them. I'll feed them to Linus when (and if) they
	are proved to be worthy.

Eric S. Raymond <esr@thyrsus.com> [5 feb 2002]
	Send kernel configuration bug reports and suggestions to me.
	Also I'll be more than happy to accept help enties for kernel config
	options for Configure.help.

Gérard Roudier <groudier@free.fr> [5 feb 2002]
	I am SCSI guy.

Hans Reiser <reiser@namesys.com> [5 feb 2002]
	ReiserFS is my favorite toy.

Ingo Molnar <mingo@elte.hu> [5 feb 2002]
	New scheduler in 2.5 and Tux are mine.

Jeff Garzik <jgarzik@mandrakesoft.com> [5 feb 2002]
	?

Jens Axboe <axboe@suse.de> [5 feb 2002]
	I am block device subsystem maintainer.

Keith Owens <kaos@ocs.com.au> [5 feb 2002]
	ksymoops, kbuild, .. .. .. .. .  are mine.

Linus Torvalds <torvalds@transmeta.com> [5 feb 2002]
	Do not send anything to me unless it is for 2.5, well tested,
	discussed on lkml and is used by significant number of people.
	In general it is a bad idea to send me small fixes and driver
	updates, send them to subsystem maintainers and/or
	"small stuff" integrator (currently Dave Jones, see his entry)
	Sorry, I can't do everything.

Marcelo Tosatti <marcelo@conectiva.com.br> [5 feb 2002]
	Do not send anything to me unless it is for 2.4 and well tested.
	If you are sending me small fixes and driver updates, send
	a copy to subsystem maintainers and/or "small stuff" integrator
	(currently Alan Cox, see his entry).

Rik van Riel <riel@conectiva.com.br> [5 feb 2002]
	Send me VM related stuff.

Robert Love <rml@tech9.net> [5 feb 2002]
	Preemptible kernel is mine.

Rusty Russell <rusty@rustcorp.com.au> [5 feb 2002]
	?
