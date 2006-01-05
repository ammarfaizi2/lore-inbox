Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWAERJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWAERJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWAERJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:09:32 -0500
Received: from quark.didntduck.org ([69.55.226.66]:25731 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751844AbWAERJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:09:31 -0500
Message-ID: <43BD531C.3060801@didntduck.org>
Date: Thu, 05 Jan 2006 12:10:52 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] gitignore shared objects
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many arches make shared objects for VDSOs.  Generally exclude them.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit 78a3333da041f4ec40d2fda241b7a491a69c44b7
tree 648d14cc3e86dc286b8fc9f9ffa99f213fc4e23d
parent d5b9ab9d83c4beda74115d03b9bb9bad843f9d55
author Brian Gerst <bgerst@didntduck.org> Thu, 05 Jan 2006 11:08:25 -0500
committer Brian Gerst <bgerst@didntduck.org> Thu, 05 Jan 2006 11:08:25 -0500

 .gitignore                  |    1 +
 arch/x86_64/ia32/.gitignore |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index a4b576e..3f8fb68 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@
 *.a
 *.s
 *.ko
+*.so
 *.mod.c
 
 #
diff --git a/arch/x86_64/ia32/.gitignore b/arch/x86_64/ia32/.gitignore
deleted file mode 100644
index 48ab174..0000000
--- a/arch/x86_64/ia32/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-vsyscall*.so


