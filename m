Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWJAKxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWJAKxY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWJAKw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:52:57 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:48094 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751545AbWJAKwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:52:49 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 7/13] kconfig/lxdialog: fix make mrproper
Reply-To: sam@ravnborg.org
Date: Sun, 01 Oct 2006 12:52:40 +0200
Message-Id: <11596999673444-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11596999672694-git-send-email-sam@ravnborg.org>
References: <1159699966691-git-send-email-sam@ravnborg.org> <1159699967600-git-send-email-sam@ravnborg.org> <11596999673562-git-send-email-sam@ravnborg.org> <115969996719-git-send-email-sam@ravnborg.org> <11596999673039-git-send-email-sam@ravnborg.org> <11596999672694-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

No Makefile in scripts/kconfig/lxdialog anymore, so do not
go there during make mrproper.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index b2928f0..0b415eb 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -135,7 +135,6 @@ endif
 
 clean-files	:= lkc_defs.h qconf.moc .tmp_qtcheck \
 		   .tmp_gtkcheck zconf.tab.c lex.zconf.c zconf.hash.c
-subdir- += lxdialog
 
 # Needed for systems without gettext
 KBUILD_HAVE_NLS := $(shell \
-- 
1.4.1

