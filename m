Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWCUQWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWCUQWy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWCUQVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:41 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29964 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030368AbWCUQVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:14 -0500
Cc: Adrian Bunk <bunk@stusta.de>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 14/46] kbuild: remove a tab from an empty line
In-Reply-To: <11429580553691-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <11429580551613-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emacs warns if an otherwise empty line starts with a tab.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e63046630c8a73825896cef140fbf49af233fd2a
diff --git a/Makefile b/Makefile
index 05b451a..a55a1e4 100644
--- a/Makefile
+++ b/Makefile
@@ -1116,7 +1116,7 @@ modules: $(module-dirs)
 
 .PHONY: modules_install
 modules_install: _emodinst_ _emodinst_post
-	
+
 install-dir := $(if $(INSTALL_MOD_DIR),$(INSTALL_MOD_DIR),extra)	
 .PHONY: _emodinst_
 _emodinst_:
-- 
1.0.GIT


