Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbVDBANJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVDBANJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbVDBALd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:11:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:41692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262952AbVDAXsS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:18 -0500
Cc: gregkh@suse.de
Subject: PCI: add CONFIG_PCI_NAMES to the feature-removal-schedule.txt file
In-Reply-To: <11123992691680@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:49 -0800
Message-Id: <1112399269989@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.3, 2005/03/16 23:56:39-08:00, gregkh@suse.de

PCI: add CONFIG_PCI_NAMES to the feature-removal-schedule.txt file

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 Documentation/feature-removal-schedule.txt |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- a/Documentation/feature-removal-schedule.txt	2005-04-01 15:38:29 -08:00
+++ b/Documentation/feature-removal-schedule.txt	2005-04-01 15:38:29 -08:00
@@ -22,3 +22,12 @@
 Why:	Noone uses it, and it probably does not work, anyway. swsusp is
 	faster, more reliable, and people are actually using it.
 Who:	Pavel Machek <pavel@suse.cz>
+
+---------------------------
+
+What:	PCI Name Database (CONFIG_PCI_NAMES)
+When:	July 2005
+Why:	It bloats the kernel unnecessarily, and is handled by userspace better
+	(pciutils supports it.)  Will eliminate the need to try to keep the
+	pci.ids file in sync with the sf.net database all of the time.
+Who:	Greg Kroah-Hartman <gregkh@suse.de>

