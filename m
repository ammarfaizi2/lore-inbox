Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVAHGWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVAHGWD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVAHGVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:21:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:31366 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261947AbVAHFsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:53 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632693187@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:49 -0800
Message-Id: <11051632693705@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2252, 2005/01/07 15:24:29-08:00, greg@kroah.com

[PATCH] add feature-removal-schedule.txt documentation

Add Documentation/feature-removal-schedule.txt as a way to notify
everyone when and what is going to be removed.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/feature-removal-schedule.txt |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)


diff -Nru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/feature-removal-schedule.txt	2005-01-07 15:33:15 -08:00
@@ -0,0 +1,17 @@
+The following is a list of files and features that are going to be
+removed in the kernel source tree.  Every entry should contain what
+exactly is going away, why it is happening, and who is going to be doing
+the work.  When the feature is removed from the kernel, it should also
+be removed from this file.
+
+---------------------------
+
+What:	devfs
+When:	July 2005
+Files:	fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
+	function calls throughout the kernel tree
+Why:	It has been unmaintained for a number of years, has unfixable
+	races, contains a naming policy within the kernel that is
+	against the LSB, and can be replaced by using udev.
+Who:	Greg Kroah-Hartman <greg@kroah.com>
+

