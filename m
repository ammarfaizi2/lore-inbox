Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWGQDha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWGQDha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 23:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWGQDha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 23:37:30 -0400
Received: from fc-cn.com ([218.25.172.144]:34833 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932282AbWGQDha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 23:37:30 -0400
Date: Mon, 17 Jul 2006 11:38:50 +0800
From: Qi Yong <qiyong@fc-cn.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] gitignore quilt's files
Message-ID: <20060717033850.GA18438@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gitignore: ignore quilt's files.
 
Signed-off-by: Qi Yong <qiyong@fc-cn.com>
---

diff --git a/.gitignore b/.gitignore
index 27fd376..21e346a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -33,3 +33,7 @@ include/linux/version.h
 
 # stgit generated dirs
 patches-*
+
+# quilt's files
+patches
+series

-- 
Qi Yong
