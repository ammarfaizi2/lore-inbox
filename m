Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292815AbSCIQrm>; Sat, 9 Mar 2002 11:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292811AbSCIQrf>; Sat, 9 Mar 2002 11:47:35 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:36814 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S292815AbSCIQr2>; Sat, 9 Mar 2002 11:47:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: evms-devel@lists.sourceforge.net
Subject: [ANNOUNCE] EVMS Release 0.9.2 (Beta)
Date: Sat, 9 Mar 2002 10:38:56 -0600
X-Mailer: KMail [version 1.2]
Cc: evms-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02030910385600.17120@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EVMS team is announcing its third beta series release. Package 0.9.2 
of the Enterprise Volume Management System is now available for download at 
the project web site:
http://www.sf.net/projects/evms

Highlights for version 0.9.2:


v0.9.2 - 3/09/02
 - Core Engine/Kernel
   - Fixed commit ordering bug.
   - Added kernel config support for ia64 and s390.
   - Export empty disks as compatibility volumes.
   - Engine configuration change.
     - Now requires --with-debug=basic to build with debugging symbols.
 - GUI
   - Added Feature Objects panel back to the main window.
   - Context pop-up menu items to jump to an object's parent,
     consuming container, and/or producing container.
   - Display detailed commit-time messages in GUI status bar.
   - Option panels now only show active options (with a button
     to optionally show all available options).
   - Added EVMS FAQ to Help menu.
 - Text-mode UI
   - Support for expand-container.
   - Support for modify-object-properties.
   - Support for FSIM operations (mkfs,unmkfs,fsck,defrag).
 - Command Line
   - Multi-command mode is now the default. The "-m" option has been removed,
     and a new "-s" option has been created to start in single command mode. 
   - C style comments /* ... */ are now allowed in command files.
   - Updated online help.
   - New man page for command line.
 - BBR Plugin
   - Now uses two kernel threads for performing I/O on replacement
     sectors and updating the BBR mapping table.
 - Snapshot Plugin
   - Changes to work with new commit-time ordering.
   - Fixed kernel bug that was limiting the size of a snapshot object.
 - MD Plugin
   - New ioctls supported in kernel.
     - Add, Remove, Activate, Deactivate, Get_Array_Info.
   - Added support for these ioctls to RAID-1 and RAID-4/5 personalities.
 - LVM Plugin
   - Changes to snapshotting code to work with new commit-time ordering.
   - Bug fixes in expand and shrink option handling.
 - AIX Plugin
   - Kernel discovery and I/O path bug-fixes.
 - Utilities
   - evms_devnode_fixup can now run in daemon mode.


Kevin Corry
corryk@us.ibm.com
Enterprise Volume Management System
http://www.sf.net/projects/evms
