Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSI3W2k>; Mon, 30 Sep 2002 18:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSI3W2k>; Mon, 30 Sep 2002 18:28:40 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:35829 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261368AbSI3W2j>; Mon, 30 Sep 2002 18:28:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: evms-devel@lists.sourceforge.net
Subject: [ANNOUNCE] EVMS Release 1.2.0
Date: Mon, 30 Sep 2002 17:01:47 -0500
X-Mailer: KMail [version 1.2]
Cc: evms-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <0209301701470A.15956@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EVMS team is announcing the next stable release of the Enterprise Volume 
Management System, which will eventually become EVMS 2.0. Package 1.2.0 is 
now available for download at the project web site:
http://www.sf.net/projects/evms

EVMS 1.2.0 has full support for the 2.4 kernel, and includes patches for most
kernels up to 2.4.19. It also has nearly full support for the 2.5 kernel 
(only the OS/2 and S/390 plugins have not been ported yet), and includes a 
patch for kernels 2.5.38 and 2.5.39.

Please send any questions, problem reports or bugs to the EVMS mailing list: 
evms-devel@lists.sf.net.


v1.2.0 - 9/30/02
Engine Core
 - Enable limited rediscovery
   - Only issue rediscover commands on disks affected by current changes,
     instead of every disk in the system.
 - Clean up stop-data that is no longer needed.
 - Improve plug-in validation.
 - No longer include kernel header files. Copy appropriate definitions,
   structures, code, etc. to user-space header files.
GUI
 - More keyboard accelerator keys for most windows.
 - Allow selecting multiple objects to remove or destroy.
 - Allow expanding containers through context popup menu.
 - Allow creating regions and segments from freespace objects through
   context popup menu.
 - Useability enhancements and terminology sync-up with other UIs.
Text-Mode UI (ncurses)
 - Support for commit status and progress indicators.
 - Add convert-to-compatibility-volume action to Volumes view.
 - Display an error on the status line if setting an option value failed.
 - Bug fixes
   - Segfault when attempting to select an item from an empty selection list.
   - Pressing "Enter" in an option panel when required options have no values.
   - Scrolling in available objects list.
   - Having to press spacebar twice when editing a string field.
Command Line
 - Parameter substitution
   - Commands can access parameters passed into the CLI when it was started.
XFS Filesystem Interface Module
 - New FSIM with mkfs, fsck, external log, and online expand support.
JFS FSIM
 - Online expand support. Requires JFS 1.0.21.
AIX Plugin
 - Create, delete and expand AIX containers.
 - Create, delete and expand AIX regions.
Snapshot
 - Correctly write COW table sectors on S/390.
MD Plugin
 - 2.5 kernel plugin has been rewritten based on Neil Brown's 2.5 MD code.

- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
