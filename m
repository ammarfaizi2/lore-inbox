Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbQLULGZ>; Thu, 21 Dec 2000 06:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130767AbQLULGQ>; Thu, 21 Dec 2000 06:06:16 -0500
Received: from access.mbnet.mb.ca ([204.112.54.11]:24266 "EHLO
	access.mbnet.mb.ca") by vger.kernel.org with ESMTP
	id <S129905AbQLULGC>; Thu, 21 Dec 2000 06:06:02 -0500
Date: Thu, 21 Dec 2000 04:35:32 -0600 (CST)
From: xOr <xor@x-o-r.net>
To: linux-kernel maillist <linux-kernel@vger.kernel.org>
Subject: lockups from heavy IDE/CD-ROM usage
Message-ID: <Pine.LNX.4.31.0012210421450.284-100000@bitch.x-o-r.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been experiencing this problem for a long time now (it occured even
in 2.2, and now in 2.4), but its Areally starting to bother me so i
thought i'd better post it here and see what you people have to say.

Problem: When i am using my harddrive and cdrom, my computer will freeze.
It freezes in two different ways.. sometimes just the harddrive access
will freeze (can still do things in X as long as they dont require the
harddrive), and then everything freezes within a few seconds. or else
everything just locks instntly. the problem is reproducable, all i need to
do is be using the harddrive extensively for a couple separate functions
(like compiling the kernel, and copying a large file) and ripping cd audio
(cd paranoia) and i can lock the system in as little as seconds, or a few
minutes sometimes.  This will happen more reliably, and much quicker and
easier when i have dma enabled, but still occurs when it is not enabled. I
have used hdparm to turn off any features on the drives, but to no avail.
And i do not receive any log messages before the computer locks. Im sure
the problem is not solely hardware, because in m$ windows, i have no
problems with dma or lockups like this.

My Hardware:
CPU: Athlon K7 750
Motherboard: Abit KA7
Chipset: VIA VT8371(KX133) /VIA 686A
Harddrive: FUJITSU MPE3273AT
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3322/255/63, sectors = 53377152, start = 0
CDROM: TDK CDRW8432
/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Input/output error
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 HDIO_GET_NOWERR failed: Input/output error
 readonly     =  0 (off)
 BLKRAGET failed: Input/output error
 HDIO_GETGEO failed: Invalid argument

I am NOT overclocking my computer either :-) im not sure what other info i
can give you about this problem.. any pointers would be greatly
appreciated.

O, one thing, i do remember hearing somewhere that the VIA KX133 chipset
had flaw(s) in it, which were fixed in the KT133 chipset. Maybe we could
get a workaround for those flaws (if they exist). Does anyone have a KX133
or KT133 chipset and have dma working?

Hope we can get this ironed out :)

thanks in advance
xOr

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
