Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbVIIWlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbVIIWlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbVIIWln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:41:43 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:8988 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030461AbVIIWkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:40:25 -0400
Cc: Sam Ravnborg <sam@mars (none)>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 11/12] kbuild: frv,m32r,sparc64 introduce fake asm-offsets.h file
In-Reply-To: <11263057062257-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Sat, 10 Sep 2005 00:41:46 +0200
Message-Id: <11263057064197-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needed to get them to build.
And a hint to avoid hardcoding to many constants in assembler.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/frv/kernel/asm-offsets.c     |    1 +
 arch/m32r/kernel/asm-offsets.c    |    1 +
 arch/sparc64/kernel/asm-offsets.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 arch/frv/kernel/asm-offsets.c
 create mode 100644 arch/m32r/kernel/asm-offsets.c
 create mode 100644 arch/sparc64/kernel/asm-offsets.c

0037c78a96bb391635bff103d401c24459c5092d
diff --git a/arch/frv/kernel/asm-offsets.c b/arch/frv/kernel/asm-offsets.c
new file mode 100644
--- /dev/null
+++ b/arch/frv/kernel/asm-offsets.c
@@ -0,0 +1 @@
+/* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
diff --git a/arch/m32r/kernel/asm-offsets.c b/arch/m32r/kernel/asm-offsets.c
new file mode 100644
--- /dev/null
+++ b/arch/m32r/kernel/asm-offsets.c
@@ -0,0 +1 @@
+/* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
diff --git a/arch/sparc64/kernel/asm-offsets.c b/arch/sparc64/kernel/asm-offsets.c
new file mode 100644
--- /dev/null
+++ b/arch/sparc64/kernel/asm-offsets.c
@@ -0,0 +1 @@
+/* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */


