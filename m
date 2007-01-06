Return-Path: <linux-kernel-owner+w=401wt.eu-S932250AbXAFWF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbXAFWF6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 17:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbXAFWF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 17:05:58 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:25327 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251AbXAFWF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 17:05:57 -0500
Date: Sat, 6 Jan 2007 14:04:52 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Torsten Kaiser <tk13@bardioc.dyndns.org>
Cc: Olaf Hering <olaf@aepfle.de>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: [PATCH 2/2] sysrq: alphabetize command keys doc.
Message-Id: <20070106140452.74941ef8.randy.dunlap@oracle.com>
In-Reply-To: <200701062019.29974.tk13@bardioc.dyndns.org>
References: <20070105110628.5f1e487d.rdunlap@xenotime.net>
	<20070105193605.GA14592@aepfle.de>
	<20070106102531.29ce662c.randy.dunlap@oracle.com>
	<200701062019.29974.tk13@bardioc.dyndns.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Alphabetize the sysrq command keys list.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/sysrq.txt |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--- linux-2620-rc3g4.orig/Documentation/sysrq.txt
+++ linux-2620-rc3g4/Documentation/sysrq.txt
@@ -64,11 +64,6 @@ On all -  write a character to /proc/sys
 
 *  What are the 'command' keys?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-'r'     - Turns off keyboard raw mode and sets it to XLATE.
-
-'k'     - Secure Access Key (SAK) Kills all programs on the current virtual
-          console. NOTE: See important comments below in SAK section.
-
 'b'     - Will immediately reboot the system without syncing or unmounting
           your disks.
 
@@ -76,21 +71,37 @@ On all -  write a character to /proc/sys
 
 'd'	- Shows all locks that are held.
 
-'o'     - Will shut your system off (if configured and supported).
+'e'     - Send a SIGTERM to all processes, except for init.
 
-'s'     - Will attempt to sync all mounted filesystems.
+'f'	- Will call oom_kill to kill a memory hog process.
 
-'u'     - Will attempt to remount all mounted filesystems read-only.
+'g'	- Used by kgdb on ppc platforms.
 
-'p'     - Will dump the current registers and flags to your console.
+'h'     - Will display help (actually any other key than those listed
+          above will display help. but 'h' is easy to remember :-)
 
-'t'     - Will dump a list of current tasks and their information to your
-          console.
+'i'     - Send a SIGKILL to all processes, except for init.
+
+'k'     - Secure Access Key (SAK) Kills all programs on the current virtual
+          console. NOTE: See important comments below in SAK section.
 
 'm'     - Will dump current memory info to your console.
 
 'n'	- Used to make RT tasks nice-able
 
+'o'     - Will shut your system off (if configured and supported).
+
+'p'     - Will dump the current registers and flags to your console.
+
+'r'     - Turns off keyboard raw mode and sets it to XLATE.
+
+'s'     - Will attempt to sync all mounted filesystems.
+
+'t'     - Will dump a list of current tasks and their information to your
+          console.
+
+'u'     - Will attempt to remount all mounted filesystems read-only.
+
 'v'	- Dumps Voyager SMP processor info to your console.
 
 'w'	- Dumps tasks that are in uninterruptable (blocked) state.
@@ -102,17 +113,6 @@ On all -  write a character to /proc/sys
           it so that only emergency messages like PANICs or OOPSes would
           make it to your console.)
 
-'f'	- Will call oom_kill to kill a memory hog process.
-
-'e'     - Send a SIGTERM to all processes, except for init.
-
-'g'	- Used by kgdb on ppc platforms.
-
-'i'     - Send a SIGKILL to all processes, except for init.
-
-'h'     - Will display help (actually any other key than those listed
-          above will display help. but 'h' is easy to remember :-)
-
 *  Okay, so what can I use them for?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Well, un'R'aw is very handy when your X server or a svgalib program crashes.

---
