Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWIXVT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWIXVT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWIXVRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:17:48 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:8338 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932143AbWIXVNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:11 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 17/28] kbuild: remove debug left-over from Makefile.host
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:13 +0200
Message-Id: <11591327061320-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327063034-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/Makefile.host |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index d74dd0f..575afbe 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -85,7 +85,6 @@ host-cshlib	:= $(addprefix $(obj)/,$(hos
 host-cshobjs	:= $(addprefix $(obj)/,$(host-cshobjs))
 host-objdirs    := $(addprefix $(obj)/,$(host-objdirs))
 
-$(warning host-objdirs=$(host-objdirs))
 obj-dirs += $(host-objdirs)
 
 #####
-- 
1.4.1

