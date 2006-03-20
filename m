Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWCTQEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWCTQEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966404AbWCTPPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:15:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966401AbWCTPPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:35 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 077/141] V4L/DVB (3300b): .gitignore should also ignore
	StGit generated dirs
Date: Mon, 20 Mar 2006 12:08:49 -0300
Message-id: <20060320150849.PS878367000077@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1141009644 -0300

StGit genreates patches-* when you run stg export command.
It makes no sense to show such directories as changes on git status.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/.gitignore b/.gitignore
diff --git a/.gitignore b/.gitignore
index 3f8fb68..53e53f2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,3 +30,5 @@ include/linux/autoconf.h
 include/linux/compile.h
 include/linux/version.h
 
+# stgit generated dirs
+patches-*

