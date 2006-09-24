Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWIXVTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWIXVTH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWIXVRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:17:52 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:7826 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932138AbWIXVNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:11 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 15/28] kbuild: add missing return statement in modpost.c:secref_whitelist()
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:11 +0200
Message-Id: <1159132705363-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327053365-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Noticed by: Magnus Damm <magnus@valinux.co.jp>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/mod/modpost.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5028d46..16a1935 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -627,6 +627,7 @@ static int secref_whitelist(const char *
 		    (strcmp(tosec, ".init.text") == 0))
 		return 1;
 	}
+	return 0;
 }
 
 /**
-- 
1.4.1

