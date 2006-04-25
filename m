Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWDYIlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWDYIlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWDYIlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:41:01 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:11156 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751446AbWDYIlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:41:00 -0400
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 25 Apr 2006 10:35:13 +0200)
Subject: [PATCH 4/4] [doc] add paragraph about 'fs' subsystem to sysfs.txt
References: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FYJ6B-0006Va-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Apr 2006 10:40:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---

 Documentation/filesystems/sysfs.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

0a2864e3522f3cd5f4447a6e0dd360fb9f9b2a7d
diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
index c8bce82..1b3a952 100644
--- a/Documentation/filesystems/sysfs.txt
+++ b/Documentation/filesystems/sysfs.txt
@@ -246,6 +246,7 @@ class/
 devices/
 firmware/
 net/
+fs/
 
 devices/ contains a filesystem representation of the device tree. It maps
 directly to the internal kernel device tree, which is a hierarchy of
@@ -264,6 +265,10 @@ drivers/ contains a directory for each d
 for devices on that particular bus (this assumes that drivers do not
 span multiple bus types).
 
+fs/ contains a directory for some filesystems.  Currently each
+filesystem wanting to export attributes must create it's own hierarchy
+below fs/ (see ./fuse.txt for an example).
+
 
 More information can driver-model specific features can be found in
 Documentation/driver-model/. 
-- 
1.2.4

