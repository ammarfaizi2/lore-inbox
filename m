Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWACNZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWACNZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWACNZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:44549 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932364AbWACNZj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:39 -0500
Subject: [PATCH 23/26] gitignore: x86_64 files
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947263966@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <bgerst@didntduck.org>
Date: 1135744791 -0500

Add filters for x86_64 generated files.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/x86_64/boot/.gitignore       |    3 +++
 arch/x86_64/boot/tools/.gitignore |    1 +
 arch/x86_64/ia32/.gitignore       |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86_64/boot/.gitignore
 create mode 100644 arch/x86_64/boot/tools/.gitignore
 create mode 100644 arch/x86_64/ia32/.gitignore

02959a875caec8cabd36111046ad537251ef405f
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
-- 
1.0.6

