Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271895AbRHUXgQ>; Tue, 21 Aug 2001 19:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271898AbRHUXgG>; Tue, 21 Aug 2001 19:36:06 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:4789 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S271895AbRHUXft>; Tue, 21 Aug 2001 19:35:49 -0400
Date: Tue, 21 Aug 2001 19:36:02 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Rick Hohensee <humbubba@smarty.smart.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [semi-OT] alignment of partitions at a cylinder boundary
In-Reply-To: <200108212350.TAA23900@smarty.smart.net>
Message-ID: <Pine.GSO.4.33.0108211934340.6389-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Rick Hohensee wrote:
>http://www.win.tue.nl/~aeb/linux/Large-Disk-6.html#ss6.2
...

I can get to it just fine:

[cramer:tty3]dragon:~/[7:32pm]:lynx -version

Lynx Version 2.8.3dev.18 (06 Jan 2000)
Built on linux-gnu Feb  7 2000 15:42:47

Copyrights held by the University of Kansas, CERN, and other contributors.
Distributed under the GNU General Public License.
See http://lynx.browser.org/ and the online help for more information.

[cramer:tty3]dragon:~/[7:32pm]:lynx -nocolor 'http://www.win.tue.nl/~aeb/linux/Large-Disk-6.html#ss6.2'

#           Large Disk HOWTO: Disk geometry, partitions and `overlap' (p4 of 6)
6.2 Cylinder boundaries

   A well-known claim says that partitions should start and end at
   cylinder boundaries.

   Since "disk geometry" is something without objective existence,
   different operating systems will invent different geometries for the
   same disk. One often sees a translated geometry like */255/63 used by
   one and an untranslated geometry like */16/63 used by another OS.
   Thus, it may be impossible to align partitions to cylinder boundaries
   according to each of the the various ideas about the size of a
   cylinder that one's systems have. Also different Linux kernels may
   assign different geometries to the same disk. Also, enabling or
   disabling the BIOS of a SCSI card may change the fake geometry of the
   connected SCSI disks.

   Fortunately, for Linux there is no alignment requirement at all.
   (Except that some semi-broken installation software likes to be very
   sure that all is OK; thus, it may be impossible to install RedHat 7.1
   on a disk with unaligned partitions because DiskDruid is unhappy.)

   People report that it is easy to create nonaligned partitions in
   Windows NT, without any noticeable bad effects.
-- press space for more, use arrow keys to move, '?' for help, 'q' to quit.


