Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVL1Ej2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVL1Ej2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 23:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVL1Ej2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 23:39:28 -0500
Received: from quark.didntduck.org ([69.55.226.66]:11140 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932472AbVL1Ej2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 23:39:28 -0500
Message-ID: <43B21717.5080002@didntduck.org>
Date: Tue, 27 Dec 2005 23:39:51 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] gitignore x86_64 files
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add filters for x86_64 generated files.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit 0e5f0274a2e711e54304c05114d48e4b56e42c21
tree 9625ef0023b16b3faf8ea25882e3c49d15e3d3cb
parent 54d78ad11408855b56d18e45e741c257799ed24f
author Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 23:38:23 -0500
committer Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 23:38:23 -0500

 arch/x86_64/boot/.gitignore       |    3 +++
 arch/x86_64/boot/tools/.gitignore |    1 +
 arch/x86_64/ia32/.gitignore       |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/boot/.gitignore b/arch/x86_64/boot/.gitignore
new file mode 100644
index 0000000..495f20c
--- /dev/null
+++ b/arch/x86_64/boot/.gitignore
@@ -0,0 +1,3 @@
+bootsect
+bzImage
+setup
diff --git a/arch/x86_64/boot/tools/.gitignore b/arch/x86_64/boot/tools/.gitignore
new file mode 100644
index 0000000..378eac2
--- /dev/null
+++ b/arch/x86_64/boot/tools/.gitignore
@@ -0,0 +1 @@
+build
diff --git a/arch/x86_64/ia32/.gitignore b/arch/x86_64/ia32/.gitignore
new file mode 100644
index 0000000..48ab174
--- /dev/null
+++ b/arch/x86_64/ia32/.gitignore
@@ -0,0 +1 @@
+vsyscall*.so


