Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbUKGQQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUKGQQp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUKGQQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:16:44 -0500
Received: from mout2.freenet.de ([194.97.50.155]:10137 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261644AbUKGQQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:16:40 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] fix typo in fs/proc/base.c
Date: Sun, 7 Nov 2004 14:19:23 +0100
User-Agent: KMail/1.7.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200411071419.23785.mbuesch@freenet.de>
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bDijBRmvPROTMau"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_bDijBRmvPROTMau
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

This fixes a typo which got introduced in latest 2.4 bk.
Sorry for the attachment. My mailer is currently broken and
corrupts diffs.

--Boundary-00=_bDijBRmvPROTMau
Content-Type: text/x-diff;
  charset="us-ascii";
  name="proc.typo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="proc.typo.diff"

--- linux-2.4.28-rc1-bk4/fs/proc/base.c.orig	Sun Nov  7 14:37:12 2004
+++ linux-2.4.28-rc1-bk4/fs/proc/base.c	Sun Nov  7 14:40:12 2004
@@ -780,7 +780,7 @@
 	return inode;
 
 out_unlock:
-	node->u.generic_ip = NULL;
+	inode->u.generic_ip = NULL;
 	iput(inode);
 	return NULL;
 }

--Boundary-00=_bDijBRmvPROTMau--

