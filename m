Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263461AbSIQCGn>; Mon, 16 Sep 2002 22:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263476AbSIQCGm>; Mon, 16 Sep 2002 22:06:42 -0400
Received: from mnh-1-04.mv.com ([207.22.10.36]:9734 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S263461AbSIQCGm>;
	Mon, 16 Sep 2002 22:06:42 -0400
Message-Id: <200209170315.WAA04676@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: user-mode port 0.59-2.4.19-5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Sep 2002 22:15:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first major release of the 2.4.19 UML.

The major kernel changes since the last 2.4.18 UML include -

	A number of honeypot and jail mode bugs and crashes were fixed.

	Many build cleanups and fixes.

	Many new exported symbols.

	Added a new filesystem - hppfs (honeypot procfs), which allows UML 
/proc entries to be arbitrarily modified from the host

	Fixed a number of crashes and one data corruption bug.

	Much code cleanup, including starting to define a host OS interface, 
so that UML can become portable between OSes.

	Many configuration cleanups, including splitting the large config.in 
into smaller, more manageable config.ins.

	Added /proc/mconsole, which allows UML processes to send mconsole 
notifications to mconsole clients on the host.

	SCSI is now available.  Currently, the only low-level driver is 
scsi_debug, which runs a SCSI ramdisk in 8M (by default) of kernel memory.

	eth devices inside UML are now guaranteed to get the same names as
were specified on the command line.

	Fixed a number of block driver bugs, and cleaned it up some.

	Helpers are now killed when UML exits, so host ports are released
and telnet sessions ended cleanly.

	The terminal emulator that UML uses is now configurable.

	Fixed a number of gdb support bugs.

The major utilities changes include -

	uml_moo now sparses its output files.  It also has a destructive
merge option and handles large COW files correctly.

	Several tunctl bugs were fixed and some cleanups done.

	There is now a jail kit, which contains everything needed to set up
a chroot and run a UML confined to it.

	There is also the host side of hppfs, including a small demo driver.

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff

