Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030610AbWJJWiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610AbWJJWiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030612AbWJJWhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:37:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52866 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030610AbWJJWh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:37:26 -0400
To: torvalds@osdl.org
Subject: [PATCH 4/16] befs: remove bogus typedef
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQE1-0008Uo-PZ@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:37:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Fri, 23 Dec 2005 20:56:46 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/befs/befs_fs_types.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/fs/befs/befs_fs_types.h b/fs/befs/befs_fs_types.h
index 63ef1e1..d124b4c 100644
--- a/fs/befs/befs_fs_types.h
+++ b/fs/befs/befs_fs_types.h
@@ -81,7 +81,6 @@ enum inode_flags {
 
 typedef u64 befs_off_t;
 typedef u64 befs_time_t;
-typedef void befs_binode_etc;
 
 /* Block runs */
 typedef struct {
-- 
1.4.2.GIT


