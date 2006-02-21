Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932770AbWBUVCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbWBUVCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbWBUVCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:02:31 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:35976 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932770AbWBUVCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:02:30 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: documentation fix
Date: Tue, 21 Feb 2006 22:02:37 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212202.38010.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a sentence in the documentation that's not correct from the technical
point of view.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/swsusp.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc4-mm1/Documentation/power/swsusp.txt
===================================================================
--- linux-2.6.16-rc4-mm1.orig/Documentation/power/swsusp.txt
+++ linux-2.6.16-rc4-mm1/Documentation/power/swsusp.txt
@@ -19,7 +19,7 @@ Some warnings, first.
  * (*) suspend/resume support is needed to make it safe.
  *
  * If you have any filesystems on USB devices mounted before suspend,
- * they won't be mounted after resume and you may lose data, as though
+ * they won't be accessible after resume and you may lose data, as though
  * you have unplugged the USB devices with mounted filesystems on them
  * (see the FAQ below for details).
 
