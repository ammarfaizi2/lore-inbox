Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290537AbSAQXsR>; Thu, 17 Jan 2002 18:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290538AbSAQXsG>; Thu, 17 Jan 2002 18:48:06 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:63138 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S290537AbSAQXr4>; Thu, 17 Jan 2002 18:47:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: evms-devel@lists.sourceforge.net
Subject: [ANNOUNCE] EVMS Release 0.9.0 (Beta)
Date: Thu, 17 Jan 2002 17:44:05 -0600
X-Mailer: KMail [version 1.2]
Cc: evms-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02011717440501.29109@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EVMS team is officially announcing its first Beta release. Package 0.9.0 
of the Enterprise Volume Management System is now available for download at 
the project web site:
http://www.sf.net/projects/evms

Highlights for version 0.9.0:

v0.9.0 - 1/17/02
- Core Engine
   - New APIs for Filesystem Interface Modules.
   - Support for setting properties of volumes, objects, and containers.
   - New user-interface tasks.
      - Expand containers, mkfs, fsck, defrag.
   - Improved user-space discovery algorithm.
- GUI
   - Support for expanding containers and removing objects from containers.
   - Support for setting object properties.
- Command Line
   - Support for expanding, shrinking containers.
- LVM Plugin
   - Supports adding/removing objects (PVs) from containers in the GUI or the
      EVMS command line.
- MD Plugin
   - Runtime support for Linear, RAID-0, and RAID-1.
      - Sync and spare-failover available for RAID-1.
      - Hot-add for RAID-1 still under development.
  - Engine support for Linear, RAID-0, and RAID-1.
      - Discovery, creation, deletion.
  - Engine discovery support for RAID-5. No creation yet.
  - Recommended to NOT use the EVMS MD plugin and the original MD driver in
     the same kernel.
- EVMS Drivelinking Plugin
   - Support for missing elements in a drive-link. Exports the drive-link in
      read-only mode to allow recovery of data on the remaining elements.
- AIX Plugin
   - Minimal discovery in user-space. Constructs all containers without
      exporting any regions.
- Text-Mode Interface
   - All code and features added. Needs additional testing.
- Kernel
   - Supports specifying an EVMS volume as a "root=" kernel boot-parameter.
- Lots of testing and bug-fixes.


Kevin Corry
corryk@us.ibm.com
Enterprise Volume Management System
http://www.sf.net/projects/evms
