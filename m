Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbRLMPLh>; Thu, 13 Dec 2001 10:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284139AbRLMPL2>; Thu, 13 Dec 2001 10:11:28 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:31104 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S284138AbRLMPLM>; Thu, 13 Dec 2001 10:11:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] EVMS Release 0.2.4
Date: Thu, 13 Dec 2001 09:02:14 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01121309021400.06777@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 0.2.4 of the Enterprise Volume Management System (EVMS) is now 
available for download at the project web site:
http://www.sf.net/projects/evms

Highlights for version 0.2.4

v0.2.4 - 12/11/01
- Core Engine
   - New feature header metadata layout
   - Added expand and shrink for volumes and storage objects
   - New plugin loading method
      - Allows multiple plugins per library file (suggested by Andrew Clausen)
   - Cleanup of unused device nodes in /dev (evms_devnode_fixup command)
- GUI
   - Expand and shrink support
   - User message and alert support
   - New window for displaying resulting objects after creates
   - Lots of task code bug-fixes
   - Better handling of changes to the various tree-views
- EVMS Command Line
   - Expand and shrink support
   - Added lots of on-line help
- MD/Software RAID Plugin
   - STILL VERY NEW AND NOT WELL TESTED! USE WITH CAUTION!
   - Support for Linear personality in the kernel
   - Ported MD superblock manipulation and I/O to EVMS plugin
   - Support for Linear and RAID 1 in the engine
- LVM Plugin
   - Added support for expanding and shrinking LVM regions
      - Does not support shrinking striped LVs yet.
   - Added lvextend and lvreduce to LVM Command Line Utilities
   - Safer handling of importing VGs/LVs from other machines.
- OS/2 Plugin
   - Complete discovery of OS/2 LVM volumes
- Bad Block Relocation
   - STILL EXPERIENCING BUGS. USE WITH CAUTION!
   - Support for one or two copies of BBR metadata
   - Switched to binary tree for in-memory remapping
- New ncurses-based user-interface
   - Currently displays all discovered objects in format similar to the GUI.
- Added cluster-enablement API stubs to kernel code
- Endian-neutrality for EVMS feature headers, all EVMS feature plugins, LVM
   region manager, OS/2 region manager, and default segment manager.
- New method for accessing the gendisk list during discovery. Uses the
   walk_gendisk() patch from Christoph Hellwig.
- Initial support for 2.5 kernels.
   - Core services and local device manager converted to new bio structures
   - Segment manager, LVM, Snapshot, and Drive-Linking plugins work as-is.
   - No testing yet on remaining plugins on 2.5.


Kevin Corry
corryk@us.ibm.com
Enterprise Volume Management System
http://www.sf.net/projects/evms
