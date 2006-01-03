Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWACN1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWACN1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWACNZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:53 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:42501 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932366AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 22/26] gitignore: asm-offsets.h
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947263768@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <bgerst@didntduck.org>
Date: 1135743544 -0500

Ignore asm-offsets.h for all arches.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 .gitignore                  |    1 +
 include/asm-mips/.gitignore |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)
 delete mode 100644 include/asm-mips/.gitignore

42f122c8f7e7134c824907358a5df94cfa38946d
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
-- 
1.0.6

