Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVCCKpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVCCKpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCCKpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:45:03 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:17588 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261560AbVCCKng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:43:36 -0500
Date: Thu, 3 Mar 2005 11:43:25 +0100
Message-Id: <200503031043.j23AhPCt020795@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 16/16] [DocBook] escape declaration_purpose
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DocBook] escape declaration_purpose
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2040  -> 1.2041 
#	  scripts/kernel-doc	1.27    -> 1.28   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/03/03	tali@admingilde.org	1.2041
# [DocBook] escape declaration_purpose
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	Thu Mar  3 11:43:30 2005
+++ b/scripts/kernel-doc	Thu Mar  3 11:43:30 2005
@@ -1673,7 +1673,7 @@
 
 		$state = 2;
 		if (/-(.*)/) {
-		    $declaration_purpose = $1;
+		    $declaration_purpose = xml_escape($1);
 		} else {
 		    $declaration_purpose = "";
 		}
