Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317435AbSGXR46>; Wed, 24 Jul 2002 13:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSGXR46>; Wed, 24 Jul 2002 13:56:58 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:41423 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317435AbSGXR45>; Wed, 24 Jul 2002 13:56:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: evms-devel@lists.sourceforge.net
Subject: [ANNOUNCE] EVMS Release 1.1.0-pre5
Date: Wed, 24 Jul 2002 12:41:20 -0500
X-Mailer: KMail [version 1.2]
Cc: evms-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02072412412000.04623@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EVMS team is announcing the next development release of the Enterprise 
Volume Management System, which will eventually become EVMS 2.0. Package 
1.1.0-pre5 is now available for download at the project web site:
http://www.sf.net/projects/evms

EVMS 1.1.0-pre5 has full support for the 2.4 kernel, and includes patches for 
kernels up to 2.4.19-rc3. It also has almost-full support for the 2.5 kernel, 
and includes patches for 2.5.25 and 2.5.27.

As with the previous pre-releases, only the source tarball is available for 
download. Pre-compiled binary packages will be available when 1.1.0 is 
released. 

Also, please use the appropriate level of caution when using this version! 
There are several very new features which have not yet undergone extensive 
testing!

*** Important Note ***

As of release 1.1.0-pre4, EVMS has been assigned a new, permanent major 
number: 117. The previous major number, 63, was reserved for experimental 
drivers. Before using -pre5, please read the README_Upgrade_To_1.1.0 file 
included in the source package for details on how you might be affected by 
the major number change. You can also view these instructions on the EVMS web 
site at http://evms.sf.net/new_major.html.


Please report any problems or bugs to the EVMS mailing list: 
evms-devel@lists.sf.net.


Highlights for version 1.1.0-pre5 include:
v1.1.0-pre5 - 7/24/02
- 2.5 Kernel
  - Updated kernel code with patches against 2.5.25 and 2.5.27.
  - All plugins updated for 2.5 except OS/2, BBR, and snapshot.
- Snapshotting
  - All snapshots are now async, and are fully persistent (even across a
    system crash).
- ReiserFS FSIM
  - Allow online expands.


Highlights for version 1.1.0-pre4 include:
v1.1.0-pre4 - 7/5/02
- New EVMS major number
  - Assigned 117 as permanent major number (had been using experimental 63).
  - Please see README_Upgrade_To_1.1.0 or http://evms.sf.net/new_major.html
    for additional details.
  - Updated LILO patches.
- Snapshotting
  - Bug fixes in async, sync, and rollback I/O code.
- Kernel
  - Bug fixes in a few older common-files patches.


v1.1.0-pre3 - 6/21/02
- Command Line
  - Support for plugin-specific tasks.
  - Improvements to the query system.
- Text-Mode UI (ncurses)
  - Display improvements.
- Filesystem Interface Modules (FSIMs)
  - More endian-neutrality fixes for ReiserFS and Ext2/3.
- S390 Plugin
  - Updated ioctl handling in kernel plugin.
- LVM Plugin
  - Fixed a bug in kernel discovery that was causing strange interactions
    with the MD plugin when using RAID-5 on top of LVM LVs.


v1.1.0-pre2 - 6/20/02
- Command Line
  - Added readline support (patch from Matt Zimmerman)
- Snapshotting
  - Improved performance in asynchronous mode.
  - Bug fixes in writeable snapshots.
- Filesystem Interface Modules (FSIMs)
  - Support for external logs in JFS.
  - Endian-neutrality fixes for JFS and ReiserFS.


v1.1.0-pre1 - 6/7/02
- Engine Core
  - Volume converting
    - Automatically changing a compatibility volume to an EVMS volume, and
      converting an EVMS volume to compatibility.
  - Add-A-Feature
    - Adding a new feature to an existing EVMS volume.
  - Plug-in-specific tasks
    - Currently used by RAID-1, RAID-5, and Snapshotting for certain actions.
  - Progress Indicators
    - Plug-ins can use this to indicate progress of long-running operations.
- GUI
  - Support for plug-in-specific tasks.
  - Support for converting compatibility volumes to EVMS volumes.
  - Support for adding a new feature to an existing EVMS volume.
  - Support for progress indicators (used by plug-ins).
- Command Line
  - Improved query system with new filters.
  - Support for converting compatibility volumes to EVMS volumes.
  - Support for adding a new feature to an existing EVMS volume.
- Filesystem Interface Modules (FSIMs)
  - Four new FSIM plug-ins
    - Ext2/Ext3
    - JFS
    - ReiserFS
    - Swap
- Snapshotting
  - Rollback - can revert all changes saved to the snapshot back to the
    original volume.
  - Asynchronous - choice of using asynchronous Copy-On-Writes for better
    performance, or synchronous COWs for better reliability.
- Software RAID
  - Improved method for handling incomplete RAID objects.
  - Improved I/O path.
- S/390 Segment Manager
  - Added multi-path I/O support in kernel.
  - Improved engine support.
- GPT Segment Manager
  - New segment manager for IA-64, GUID-Partition-Table partitions.


Enterprise Volume Management System
http://evms.sourceforge.net/
