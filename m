Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSHAPMK>; Thu, 1 Aug 2002 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSHAPMK>; Thu, 1 Aug 2002 11:12:10 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:12744 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S315406AbSHAPMH>; Thu, 1 Aug 2002 11:12:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
Subject: [ANNOUNCE] EVMS Release 1.1.0
Date: Thu, 1 Aug 2002 09:55:22 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02071211085700.16474@boiler>
Content-Transfer-Encoding: 7BIT
To: evms-devel@lists.sourceforge.net
Cc: evms-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EVMS team is announcing the next stable release of the Enterprise Volume 
Management System, which will eventually become EVMS 2.0. Package 1.1.0 is 
now available for download at the project web site:
http://www.sf.net/projects/evms

EVMS 1.1.0 has full support for the 2.4 kernel, and includes patches for most
kernels up to 2.4.19-rc3. It also has nearly full support for the 2.5 kernel, 
and includes patches for kernels 2.5.25 and 2.5.27.

**** Important Note ****

As of this release, EVMS has been assigned a new, permanent major number: 
117. The previous major number, 63, was reserved for experimental drivers. 
Before using 1.1.0, please read the README_Upgrade_To_1.1.0 file included in 
the source package for details on how you might be affected by the major 
number change. You can also view these instructions on the EVMS web site at 
http://evms.sourceforge.net/new_major.html.

************************

For on-going performance testing and analysis results for EVMS, please visit 
the Linux Scalability Effort site at:
http://lse.sourceforge.net/benchmarks/evms/

Please send any questions, problem reports or bugs to the EVMS mailing list: 
evms-devel@lists.sf.net.


Highlights for version 1.1.0 include:
v1.1.0 - 7/31/02
- Engine Core
  - Volume converting
    - Integrated ability to convert a compatibility volume to an EVMS volume,
      or convert an EVMS volume to compatibility.
  - Add-A-Feature
    - Adding a new feature to an existing EVMS volume.
  - Plug-in-specific tasks
    - Currently used by RAID-1, RAID-5, Snapshotting, and S/390 Seg. Mgr.
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
  - Support for plugin-specific tasks.
  - Added readline support (patch from Matt Zimmerman)
- Filesystem Interface Modules
  - Four new FSIM plug-ins
    - Ext 2/3
    - JFS
    - ReiserFS
    - Swap
- Snapshotting
  - Rollback - can revert all changes saved to the snapshot back to the
    original volume.
  - Asynchronous - Copy-On-Writes are now performed asynchronously to lessen
    the performance impact of using snapshots. Full persistency is
    maintained, just as in the previous synchronous version.
- Software RAID
  - Improved method for handling incomplete RAID objects.
  - Improved I/O path.
- S/390 Segment Manager
  - Added multi-path I/O support in kernel.
  - Improved engine support (create, delete, resize, low-level dasd format)
- GPT Segment Manager
  - New segment manager for IA-64, GUID-Partition-Table partitions.
  - Create and delete support.
- New EVMS major number
  - Assigned 117 as permanent major number (had been using experimental 63).
  - Please see README_Upgrade_To_1.1.0 for additional details.
  - Updated LILO patches.

For the incremental changes during the 1.1.0-preX series, please see: 
http://sourceforge.net/project/shownotes.php?release_id=93528

Enterprise Volume Management System
http://www.sf.net/projects/evms
