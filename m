Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWIMSSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWIMSSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWIMSSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:18:48 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:52201 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751019AbWIMSSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:18:48 -0400
Subject: [PATCH] Add preprocessed files (*.i) to .gitignore
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Paul McKenney <paulmck@us.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 11:19:08 -0700
Message-Id: <1158171548.5097.7.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel build system supports making preprocessed files (*.i) from C source
files.  Add these files to .gitignore .

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index b1f5b9d..0ec4533 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,6 +12,7 @@ #
 *.ko
 *.so
 *.mod.c
+*.i
 
 #
 # Top-level generic files
-- 
1.4.1.1


