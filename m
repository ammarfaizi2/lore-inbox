Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313321AbSC2A3A>; Thu, 28 Mar 2002 19:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313320AbSC2A2v>; Thu, 28 Mar 2002 19:28:51 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:57293 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S313317AbSC2A2g>; Thu, 28 Mar 2002 19:28:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: evms-devel@lists.sourceforge.net
Subject: [ANNOUNCE] EVMS Release 1.0.0
Date: Thu, 28 Mar 2002 18:16:24 -0600
X-Mailer: KMail [version 1.2]
Cc: evms-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02032818104600.29828@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EVMS team is announcing the first full release of the Enterprise Volume 
Management System. Package 1.0.0 is now available for download at the project 
web site:
http://www.sf.net/projects/evms

Highlights for version 1.0.0:

v1.0.0 - 3/28/02
 - Core Kernel
   - Support for /proc.
     - New directory /proc/evms/.
     - File entries: volumes, info, plugins
     - Sysctl entry: /proc/sys/dev/evms/evms_info_level can be used to
       query and set the EVMS kernel messaging level.
 - GUI
   - Option panel fixes.
   - New columns in most panels: Read-only and Corrupt.
   - Default engine logging level changed from "everything" to "default".
   - Check for minimum required engine API version.
 - Text-Mode UI
   - Added "F5=Commit" to menu to allow saving changes without exiting.
   - Screen refresh fixes.
   - Default engine logging level changed from "everything" to "default".
   - Check for minimum required engine API version.
 - Command Line
   - On-line help cleanup.
 - New Plugin: s390 Segment Manager
   - Recognizes existing CDL, LDL, and CMS partitions.
   - Can build on top of these partitions in the engine, but
     cannot yet create new s390 partitions.
 - MD Plugin
   - Added proc entry: /proc/evms/mdstat
   - Added sysctl entries: /proc/sys/dev/evms/md/speed_limit_[min|max] for
     controlling the speed of RAID-1 and RAID-5 sync'ing.
 - BBR Plugin
   - Bug fixes to the I/O error remap handling.
 - AIX Plugin
   - Bug fixes in the discovery path and mirroring I/O path.
 - LVM Plugin
   - Added proc entry: /proc/evms/lvm/global


Kevin Corry
corryk@us.ibm.com
Enterprise Volume Management System
http://www.sf.net/projects/evms
