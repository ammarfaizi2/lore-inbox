Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422682AbWG2HT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbWG2HT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWG2HTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:19:55 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:52147 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422682AbWG2HTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:19:54 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kbuild: version.h and new headers_* targets does not require a kernel config
Reply-To: sam@ravnborg.org
Date: Sat, 29 Jul 2006 09:19:34 +0200
Message-Id: <11541575813716-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1.rc2.gfc04
In-Reply-To: <11541575812597-git-send-email-sam@ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 7c010f3..60e09f2 100644
--- a/Makefile
+++ b/Makefile
@@ -368,6 +368,7 @@ # of make so .config is not included in 
 
 no-dot-config-targets := clean mrproper distclean \
 			 cscope TAGS tags help %docs check% \
+			 include/linux/version.h headers_% \
 			 kernelrelease kernelversion
 
 config-targets := 0
-- 
1.4.1.rc2.gfc04

