Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbVJ1GgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbVJ1GgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVJ1Gbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:48106 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965150AbVJ1Gb0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:26 -0400
Cc: gregkh@suse.de
Subject: [PATCH] update required version of udev
In-Reply-To: <113048102735@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:27 -0700
Message-Id: <11304810274123@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] update required version of udev

The 071 release is needed to handle the input changes.  Older versions
will work properly with module-based systems, but not for users that
build input stuff into the kernel.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c2458141eaa1fcfe3c09a9834784a2c2716012b3
tree 7c2b94c780a4253f6f4d796d6c96b4909b9c8f01
parent e9821c685cbf2d72f6d692117e83ff9b71c3315b
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:07 -0700

 Documentation/Changes |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/Changes b/Documentation/Changes
index 27232be..783ddc3 100644
--- a/Documentation/Changes
+++ b/Documentation/Changes
@@ -65,7 +65,7 @@ o  isdn4k-utils           3.1pre1       
 o  nfs-utils              1.0.5                   # showmount --version
 o  procps                 3.2.0                   # ps --version
 o  oprofile               0.9                     # oprofiled --version
-o  udev                   058                     # udevinfo -V
+o  udev                   071                     # udevinfo -V
 
 Kernel compilation
 ==================

