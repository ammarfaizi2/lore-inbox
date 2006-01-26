Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWAZDwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWAZDwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAZDwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:52:20 -0500
Received: from [202.53.187.9] ([202.53.187.9]:25323 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932233AbWAZDtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:42 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 21/23] [Suspend2] Remove unused DEBUG undef.
Date: Thu, 26 Jan 2006 13:46:09 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034608.3178.42220.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove a now-unneeded #undef DEBUG.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index aad2aa5..9aa2fa0 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -25,9 +25,6 @@
  * to complete their work more quickly.
  */
 
-
-#undef DEBUG
-
 #include <linux/suspend.h>
 #include <linux/freezer.h>
 #include <linux/module.h>

--
Nigel Cunningham		nigel at suspend2 dot net
