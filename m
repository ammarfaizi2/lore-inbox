Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTJGEfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 00:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTJGEfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 00:35:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55730 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261784AbTJGEfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 00:35:08 -0400
Date: Mon, 6 Oct 2003 13:03:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Cathal A. Ferris" <pio@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp 2.6.0-test3 resuming issues
Message-ID: <20031006110311.GK205@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0310011057500.7555@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310011057500.7555@skynet>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

use just one swap partition for now.

On Wed 01-10-03 11:40:45, Cathal A. Ferris wrote:
> I am having trouble with the suspend/resume area in -test3.
> I suspend with 'echo 4 > /proc/acpi/sleep' after unloading as many of the
> modules as possible (though usbcore won't unload) and it appears to
> suspend correctly.
> On resume I get 'Incorrect kernel version', and failure to resume from the
> saved image.
> 
> Machine is a dell inspiron 4100 laptop running gentoo linux.
> 128mb ram
> swaps:
> minipio root # swapon -s
> Filename                                Type         Size    Used    Priority
> /dev/ide/host0/bus0/target0/lun0/part2   partition   530136  76400   -1
> /dev/ide/host0/bus0/target0/lun0/part1   partition   441748  0       -2
> 
> 
> What information do you want to assist with the resolution of this
> problem?
> 
> (under -test6 I get no effect from either /proc/acpi/sleep or
> /sys/power/state - i.e. I do the echo and absolutely nothing happens, and
> nothing in the kernel logs)
> 
> Thanks,
> 
> Cathal.
> -- 
> Cathal Ferris.		+353 87 6438725
> pio@csn.ul.ie		http://www.swibble.com
> serio: i8042 KBD port at 0x60,0x64 irq 1
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 8192 bind 16384)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> ACPI: (supports S0 S1 S3 S4 S4bios S5)
> Resume Machine: resuming from /dev/hda1
> Resuming from device hda1
> Resume Machine: Signature found, resuming
> Resume Machine: Incorrect kernel version
> Resume Machine: Error -1 resuming 
> EXT3-fs: INFO: recovery required on readonly filesystem.
> EXT3-fs: write access will be enabled during recovery.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 144k freed
> Adding 530136k swap on /dev/hda2.  Priority:-1 extents:1
> Unable to find swap-space signature
> 


-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

