Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVAHG2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVAHG2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVAHG1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:27:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:33158 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261949AbVAHFs4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:56 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632693705@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:49 -0800
Message-Id: <11051632691487@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2253, 2005/01/07 15:29:10-08:00, rddunlap@osdl.org

[PATCH] add cpufreq info to Documentation/feature-removal-schedule.txt

Add 2.4.x cpufreq /proc and sysctl interface removal
to the feature-removal-schedule.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


 Documentation/feature-removal-schedule.txt |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- a/Documentation/feature-removal-schedule.txt	2005-01-07 15:32:49 -08:00
+++ b/Documentation/feature-removal-schedule.txt	2005-01-07 15:32:49 -08:00
@@ -15,3 +15,12 @@
 	against the LSB, and can be replaced by using udev.
 Who:	Greg Kroah-Hartman <greg@kroah.com>
 
+---------------------------
+
+What:	/proc/sys/cpu and the sysctl interface to cpufreq (2.4.x interfaces)
+When:	January 2005
+Files:	drivers/cpufreq/: cpufreq_userspace.c, proc_intf.c
+	function calls throughout the kernel tree
+Why:	Deprecated, has been replaced/superseded by (what?)....
+Who:	Dominik Brodowski <linux@brodo.de>
+

