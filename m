Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWG2HV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWG2HV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422680AbWG2HT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:19:58 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:52659 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422685AbWG2HTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:19:54 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@redhat.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kbuild: fix typo in modpost
Reply-To: sam@ravnborg.org
Date: Sat, 29 Jul 2006 09:19:37 +0200
Message-Id: <11541575813138-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1.rc2.gfc04
In-Reply-To: <1154157581409-git-send-email-sam@ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <11541575813716-git-send-email-sam@ravnborg.org> <11541575811267-git-send-email-sam@ravnborg.org> <1154157581409-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>

Reported by a Fedora user when they tried to build some out of tree module..

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/Makefile.modpost |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index a495502..0a64688 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -40,7 +40,7 @@ include scripts/Kbuild.include
 include scripts/Makefile.lib
 
 kernelsymfile := $(objtree)/Module.symvers
-modulesymfile := $(KBUILD_EXTMOD)/Modules.symvers
+modulesymfile := $(KBUILD_EXTMOD)/Module.symvers
 
 # Step 1), find all modules listed in $(MODVERDIR)/
 __modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
-- 
1.4.1.rc2.gfc04

