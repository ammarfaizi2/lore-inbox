Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWIMSUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWIMSUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWIMSUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:20:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:54145 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750793AbWIMSUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:20:05 -0400
Subject: [PATCH] Add symbol type files (*.symtypes) to .gitignore
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Paul McKenney <paulmck@us.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 11:20:26 -0700
Message-Id: <1158171626.5097.11.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel build system supports making symbol type files (*.symtypes) from C
source files.  Add these files to .gitignore .

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2a5a6ec..e1d5c17 100644
--- a/.gitignore
+++ b/.gitignore
@@ -14,6 +14,7 @@ #
 *.mod.c
 *.i
 *.lst
+*.symtypes
 
 #
 # Top-level generic files
-- 
1.4.1.1


