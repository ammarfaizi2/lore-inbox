Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWCUQdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWCUQdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWCUQaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:23 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30988 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030310AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 38/46] kbuild: in makefile.txt note that Makefile is preferred name for kbuild files
In-Reply-To: <1142958057287-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <11429580572017-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Roland Dreier <rdreier@cisco.com> makefiles.txt told
one to use the name 'Kbuild' as preferred name for kbuild files.
This is not yet true so let makefiles.txt reflect reality.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Documentation/kbuild/makefiles.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

172c3ae3e686f548a0eba950405e5cc321460005
diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 99d51a5..a9c00fa 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -106,9 +106,9 @@ This document is aimed towards normal de
 Most Makefiles within the kernel are kbuild Makefiles that use the
 kbuild infrastructure. This chapter introduce the syntax used in the
 kbuild makefiles.
-The preferred name for the kbuild files is 'Kbuild' but 'Makefile' will
-continue to be supported. All new developmen is expected to use the
-Kbuild filename.
+The preferred name for the kbuild files are 'Makefile' but 'Kbuild' can
+be used and if both a 'Makefile' and a 'Kbuild' file exists then the 'Kbuild'
+file will be used.
 
 Section 3.1 "Goal definitions" is a quick intro, further chapters provide
 more details, with real examples.
-- 
1.0.GIT


