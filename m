Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVDBAIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVDBAIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbVDBAHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:07:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:38108 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262813AbVDAXsQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:16 -0500
Cc: gregkh@suse.de
Subject: Remove item from feature-removal-schedule.txt that was already removed from the kernel.
In-Reply-To: <11123992681543@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:49 -0800
Message-Id: <11123992691680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.2, 2005/03/16 23:56:17-08:00, gregkh@suse.de

Remove item from feature-removal-schedule.txt that was already removed from the kernel.

my mistake...

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 Documentation/feature-removal-schedule.txt |   15 ---------------
 1 files changed, 15 deletions(-)


diff -Nru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- a/Documentation/feature-removal-schedule.txt	2005-04-01 15:38:36 -08:00
+++ b/Documentation/feature-removal-schedule.txt	2005-04-01 15:38:36 -08:00
@@ -17,21 +17,6 @@
 
 ---------------------------
 
-What:	/proc/sys/cpu/*, sysctl and /proc/cpufreq interfaces to cpufreq (2.4.x interfaces)
-When:	January 2005
-Files:	drivers/cpufreq/: cpufreq_userspace.c, proc_intf.c
-Why:	/proc/sys/cpu/* has been deprecated since inclusion of cpufreq into
-	the main kernel tree. It bloats /proc/ unnecessarily and doesn't work
-	well with the "governor"-based design of cpufreq.
-	/proc/cpufreq/* has also been deprecated for a long time and was only
-	meant for usage during 2.5. until the new sysfs-based interface became
-	ready. It has an inconsistent interface which doesn't work well with
-	userspace setting the frequency. The output from /proc/cpufreq/* can
-	be emulated using "cpufreq-info --proc" (cpufrequtils).
-	Both interfaces are superseded by the cpufreq interface in
-	/sys/devices/system/cpu/cpu%n/cpufreq/.
-Who:	Dominik Brodowski <linux@brodo.de>
-
 What:	ACPI S4bios support
 When:	May 2005
 Why:	Noone uses it, and it probably does not work, anyway. swsusp is

