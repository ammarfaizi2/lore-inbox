Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVCJBeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVCJBeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVCJBUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:20:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:45215 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262609AbVCJAmY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:24 -0500
Cc: rddunlap@osdl.org
Subject: [PATCH] Add 2.4.x cpufreq /proc and sysctl interface removal feature-removal-schedule
In-Reply-To: <11104148771738@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:38 -0800
Message-Id: <1110414878721@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2036, 2005/03/09 09:31:40-08:00, rddunlap@osdl.org

[PATCH] Add 2.4.x cpufreq /proc and sysctl interface removal feature-removal-schedule

Add 2.4.x cpufreq /proc and sysctl interface removal
to the feature-removal-schedule.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/feature-removal-schedule.txt |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- a/Documentation/feature-removal-schedule.txt	2005-03-09 16:30:16 -08:00
+++ b/Documentation/feature-removal-schedule.txt	2005-03-09 16:30:16 -08:00
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

