Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWHAOcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWHAOcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWHAOcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:32:21 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:16058 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751633AbWHAOcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:32:21 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH][Doc] Fix copy&waste bug in comment in scripts/kernel-doc
Date: Tue, 1 Aug 2006 16:34:40 +0200
User-Agent: KMail/1.9.3
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org,
       Martin Waitz <tali@admingilde.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608011634.40857.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is obviously copied from some lines before without proper fixing.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 3ac898b16fb75cd996ec98fa578ea06b6ffb2760
tree 7548345e101fc45dfac0faa63f27f3689d4e87ac
parent 4f52325acb61992f368a341938f8838caeacbec2
author Rolf Eike Beer <eike-kernel@sf-tec.de> Tue, 01 Aug 2006 16:27:03 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Tue, 01 Aug 2006 16:27:03 +0200

 scripts/kernel-doc |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c9ca0c2..00d1ad1 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -57,8 +57,8 @@ #	If set, then only generate documentati
 #	other functions are ignored.
 #
 #  -nofunction funcname
-#	If set, then only generate documentation for the other function(s).  All
-#	other functions are ignored. Cannot be used with -function together
+#	If set, then only generate documentation for the other function(s).
+#	Cannot be used together with -function
 #	(yes, that's a bug -- perl hackers can fix it 8))
 #
 #  c files - list of 'c' files to process
