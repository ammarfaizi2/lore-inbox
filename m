Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264454AbRFQCop>; Sat, 16 Jun 2001 22:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264492AbRFQCog>; Sat, 16 Jun 2001 22:44:36 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:2012 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264454AbRFQCoV>; Sat, 16 Jun 2001 22:44:21 -0400
Message-Id: <5.1.0.14.2.20010617034356.00a6e960@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 17 Jun 2001 03:44:48 +0100
To: linux-ntfs-dev@lists.sourceforge.net
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: ANN: Linux-NTFS 1.0.0 stable released
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-NTFS 1.0.0 stable is now released.

Get it from http://sf.net/projects/linux-ntfs/

NTFS utilities
==============
NtfsFix v1.15 - Attempt to fix an NTFS partition that has been damaged by 
the Linux NTFS driver. Note that you should run it every time after you 
have used the Linux NTFS driver to write to an NTFS partition to prevent 
massive data corruption from happening when Windows mounts the partition. 
IMPORTANT: Run this only *after* unmounting the partition in Linux but 
*before* rebooting into Windows NT/2000 or you *will* suffer! - You have 
been warned!

mkntfs v1.39 - Format a partition with the NTFS filesystem. See man 8 
mkntfs for command line options.

NtfsDump_LogFile v1.0 - Interpret and display information about the journal 
($LogFile) of an NTFS volume.

dumplog v1.0. - As NtfsDump_LogFile but operates on a file rather than a 
partition, so can use it on a live mounted file system.

ldm v1.3 - Interpret and display the Logical Disk Manager database (of a 
Windows 2000/XP dynamic disk/block device).

NTFS library
============
Provides common NTFS access functions to the ntfstools and other foreign 
open source applications. Note, that the library is still under heavy 
development and doesn't include the majority of functionality yet. It only 
is capable of just about supporting the current ntfstools, so I wouldn't 
recommend using it for your own applications at this stage.

Changes:
* mkntfs release and bugfixes to libntfs and the other utilities. Includes 
a man (8) page.
* ldm release which dumps the ldm database on Win2k/XP dynamic disks.
* updated ntfsdump_logfile and new dumplog operating on the logfile itself 
rather than the partition, suitable for live mounted file systems.
* Building of shared libraries is disabled by default as it breaks on some 
systems.
* Probably need at least gcc-2.95 or something like that from now on.

Please report any bugs/problems to:
         linux-ntfs-dev@lists.sf.net

Enjoy,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

