Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVH1VLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVH1VLA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVH1VK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:10:59 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:28630 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750811AbVH1VK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:10:59 -0400
Subject: [PATCH 2.6.13-rc6-mm2] v9fs: fix plan9port example in v9fs
	documentation.
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 16:10:50 -0500
Message-Id: <1125263450.17501.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: Fix Plan9port example in v9fs documentation.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit 678b78b5268b253e21aa818fac25ea13291eafff
tree fc3d94d10d23fedee95091e372c51e1156a0360f
parent 06e00e56fdf2c3e230ff60f6fdab6db789f16e73
author Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005 16:09:12
-0500
committer Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005
16:09:12 -0500

 Documentation/filesystems/v9fs.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/filesystems/v9fs.txt
b/Documentation/filesystems/v9fs.txt
--- a/Documentation/filesystems/v9fs.txt
+++ b/Documentation/filesystems/v9fs.txt
@@ -20,7 +20,7 @@ For remote file server:
 
 For Plan 9 From User Space applications (http://swtch.com/plan9)
 
-	mount -t 9P /tmp/ns.root.:0/acme/acme /mnt/9 proto=unix,name=$USER
+	mount -t 9P `namsepace`/acme /mnt/9 -o proto=unix,name=$USER
 
 OPTIONS
 =======


