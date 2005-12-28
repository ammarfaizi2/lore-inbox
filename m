Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVL1ESa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVL1ESa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 23:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVL1ESa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 23:18:30 -0500
Received: from quark.didntduck.org ([69.55.226.66]:43752 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932462AbVL1ESa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 23:18:30 -0500
Message-ID: <43B21238.2070409@didntduck.org>
Date: Tue, 27 Dec 2005 23:19:04 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] gitignore asm-offsets.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore asm-offsets.h for all arches.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit 54d78ad11408855b56d18e45e741c257799ed24f
tree 795529c632476c6730f252c1d10b98fefd4a2fac
parent 58c5813206aec0df47a061ad31c457cd6e176d12
author Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 23:16:47 -0500
committer Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 23:16:47 -0500

 .gitignore                  |    1 +
 include/asm-mips/.gitignore |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5014bfa..a4b576e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,6 +23,7 @@ Module.symvers
 # Generated include files
 #
 include/asm
+include/asm-*/asm-offsets.h
 include/config
 include/linux/autoconf.h
 include/linux/compile.h
diff --git a/include/asm-mips/.gitignore b/include/asm-mips/.gitignore
deleted file mode 100644
index 4ec57ad..0000000
--- a/include/asm-mips/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-asm_offsets.h


