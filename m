Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVIJUc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVIJUc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVIJUc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:32:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:47770 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932281AbVIJUc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:32:28 -0400
Date: Sat, 10 Sep 2005 22:34:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/7] kbuild: add kernelrelease to 'make help'
Message-ID: <20050910203403.GA29334@mars.ravnborg.org>
References: <20050910200347.GA3762@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910200347.GA3762@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It sems git-send-emails fooled me again.
So here follows the patches send manually.

>From nobody Mon Sep 17 00:00:00 2001
Subject: [PATCH 1/7] kbuild: add kernelrelease to 'make help'
From: Zach Brown <zach.brown@oracle.com>
Date: 1126120103 -0700

Dunno if there was a conscious decision to leave it out, but if you're
happy with adding some help text for it here's a patch against 2.6.13-mm1..

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

6d12884259ac65f74538b7819f5fadf4ebb0d569
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -1053,6 +1053,7 @@ help:
 	@echo  '  rpm		  - Build a kernel as an RPM package'
 	@echo  '  tags/TAGS	  - Generate tags file for editors'
 	@echo  '  cscope	  - Generate cscope index'
+	@echo  '  kernelrelease	  - Output the release version string'
 	@echo  ''
 	@echo  'Static analysers'
 	@echo  '  buildcheck      - List dangling references to vmlinux discarded sections'

