Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWACNar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWACNar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWACN37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:29:59 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:42501 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932356AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 12/26] kbuild: document INSTALL_MOD_PATH in 'make help'
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947253589@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Eggert <7eggert@gmx.de>
Date: 1132773094 +0100

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

9cc5d74c847dd3a9ea121b5bbca07bd5791c54ee
diff --git a/Makefile b/Makefile
index b7856d3..5f685b9 100644
--- a/Makefile
+++ b/Makefile
@@ -1062,7 +1062,7 @@ help:
 	@echo  '  all		  - Build all targets marked with [*]'
 	@echo  '* vmlinux	  - Build the bare kernel'
 	@echo  '* modules	  - Build all modules'
-	@echo  '  modules_install - Install all modules'
+	@echo  '  modules_install - Install all modules to INSTALL_MOD_PATH (default: /)'
 	@echo  '  dir/            - Build all files in dir and below'
 	@echo  '  dir/file.[ois]  - Build specified target only'
 	@echo  '  dir/file.ko     - Build module including final link'
-- 
1.0.6

