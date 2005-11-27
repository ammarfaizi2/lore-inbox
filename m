Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVK0MrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVK0MrR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 07:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVK0MrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 07:47:17 -0500
Received: from admingilde.org ([213.95.32.146]:49063 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751000AbVK0MrQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 07:47:16 -0500
Date: Sun, 27 Nov 2005 13:47:13 +0100
From: Martin Waitz <tali@admingilde.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DocBook: add .gitignore file
Message-ID: <20051127124713.GA15536@admingilde.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when ignoring all DocBook output files git-status output becomes meaningful
again.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 Documentation/DocBook/.gitignore |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/DocBook/.gitignore

applies-to: e0ad781a5c7718bb40f0b0f4cd47ada937f21d7b
ca0e12ae5dd452d8c8e2282844bc6e65bc5cbc1d
diff --git a/Documentation/DocBook/.gitignore b/Documentation/DocBook/.gitignore
new file mode 100644
index 0000000..c102c02
--- /dev/null
+++ b/Documentation/DocBook/.gitignore
@@ -0,0 +1,6 @@
+*.xml
+*.ps
+*.pdf
+*.html
+*.9.gz
+*.9
---
0.99.9.GIT

-- 
Martin Waitz
