Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWGUIKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWGUIKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 04:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWGUIKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 04:10:12 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:8388 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1161012AbWGUIKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 04:10:11 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: zanussi@us.ibm.com
Subject: [PATCH][Doc] change identation of one paragraph in Documentation/filesystems/relayfs.txt
Date: Fri, 21 Jul 2006 10:11:28 +0200
User-Agent: KMail/1.9.3
Cc: karim@opersys.com, linux-kernel@vger.kernel.org, trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607211011.28311.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the identation of one paragraph to match that of the others in this
section.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit a61512454736a148d2add339eb2c682e86645f9f
tree c122c5a9b9cfd645b6696ddd80303256d8382f88
parent 4223d94a33bdb10bad3f2c0adebb7fea40ae185a
author Rolf Eike Beer <eike-kernel@sf-tec.de> Fri, 21 Jul 2006 10:10:12 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Fri, 21 Jul 2006 10:10:12 +0200

 Documentation/filesystems/relayfs.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
index 5832377..8533d42 100644
--- a/Documentation/filesystems/relayfs.txt
+++ b/Documentation/filesystems/relayfs.txt
@@ -106,9 +106,9 @@ read()	 read the contents of a channel b
 poll()	 POLLIN/POLLRDNORM/POLLERR supported.  User applications are
 	 notified when sub-buffer boundaries are crossed.
 
-close() decrements the channel buffer's refcount.  When the refcount
-	reaches 0 i.e. when no process or kernel client has the buffer
-	open, the channel buffer is freed.
+close()	 decrements the channel buffer's refcount.  When the refcount
+	 reaches 0 i.e. when no process or kernel client has the buffer
+	 open, the channel buffer is freed.
 
 
 In order for a user application to make use of relayfs files, the
