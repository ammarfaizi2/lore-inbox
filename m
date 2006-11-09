Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424072AbWKIQiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424072AbWKIQiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424100AbWKIQiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:38:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:12571 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424072AbWKIQiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:38:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=kgW9FcNs4oR/9f4HPNV9OAluViDzmwT4Bsru7kCRt3QWwRF5diyksDnlnBNru2+TNlhb5ONJEqpVVLcunE5RERCQEBtRtvs8RM4cAI94GyWlKz9HrGVnD7bEUAw8cSd0sHkjHis7rJNMLeMtYKOmgl6XKHt9/DKGWMkFR4GqsaY=
Message-ID: <455359A0.1050500@innova-card.com>
Date: Thu, 09 Nov 2006 17:38:56 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: sam@ravnborg.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] .gitignore: add miscellaneous files
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch avoids git to report this useless status:

	On branch refs/heads/master
	Untracked files:
	  (use "git add" to add to commit)

	      TAGS
	      scripts/kconfig/lkc_defs.h
	      scripts/kconfig/qconf.moc
	nothing to commit

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 .gitignore                 |    1 +
 scripts/kconfig/.gitignore |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index e1d5c17..9eb4b77 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,7 @@
 # Top-level generic files
 #
 tags
+TAGS
 vmlinux*
 System.map
 Module.symvers
diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index e8ad1f6..b49584c 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -6,6 +6,8 @@ lex.*.c
 *.tab.c
 *.tab.h
 zconf.hash.c
+*.moc
+lkc_defs.h
 
 #
 # configuration programs
-- 
1.4.3.4

