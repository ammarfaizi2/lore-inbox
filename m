Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSBOR1l>; Fri, 15 Feb 2002 12:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290306AbSBOR10>; Fri, 15 Feb 2002 12:27:26 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:55749 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S290293AbSBOR01>; Fri, 15 Feb 2002 12:26:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
Subject: [ANNOUNCE] EVMS Release 0.9.1 (Beta)
Date: Fri, 15 Feb 2002 11:22:27 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: evms-devel@lists.sourceforge.net
Cc: evms-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-Id: <02021511222701.19048@boiler>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EVMS team is announcing its second beta series release. Package 0.9.1 
of the Enterprise Volume Management System is now available for download at 
the project web site:
http://www.sf.net/projects/evms

Highlights for version 0.9.1:

v0.9.1 - 2/15/02
- GUI
  - New dialog help windows.
  - Support for mkfs, unmkfs, fsck, and defrag operations as provided
    by FSIMs.
  - Better descriptions of selection lists.
  - Display mount points in the Volumes view.
  - Display a startup/splash window during engine discovery.
  - Lots of UI cleanup and bug fixes.
- Text-mode UI
  - Fixed support for adding/removing objects to/from containers.
  - Now supports same command line options as the GUI.
- Segment Manager
  - Recognizes BSD, Solaris-x86, and Unixware partitions in the engine.
- MD Plugin
  - RAID 4/5 kernel support.
    - Supports failover to spare disk or running in degraded mode.
    - Limited testing so far - be gentle.
  - RAID 4/5 creation and deletion.
  - Hot add/remove support for RAID-1.
- AIX Plugin
  - Complete region discovery in the engine.
- LVM Plugin
  - Fixed some potential memory overwrite bugs in the engine.
- LVM Utilities
  - Removed evms_pvcreate and evms_pvremove. No longer necessary to
    explicitly create PVs before creating or expanding VGs, or to
    explicitly remove PVs after removing or shrinking VGs.
- Kernel
  - Improved support for removable and hot-pluggable media.
  - Improved support for building EVMS as kernel modules.


Kevin Corry
corryk@us.ibm.com
Enterprise Volume Management System
http://www.sf.net/projects/evms
