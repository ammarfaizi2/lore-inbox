Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWGGLsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWGGLsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWGGLsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:48:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62697 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932132AbWGGLry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:47:54 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 5/8] FDPIC: Define SEEK_* constants in the Linux kernel headers [try #4]
Date: Fri, 07 Jul 2006 12:47:49 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060707114749.948.57596.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
References: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Add definitions for SEEK_SET, SEEK_CUR and SEEK_END to the kernel header files.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/fs.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 43aef9b..2561020 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -27,6 +27,10 @@ #define INR_OPEN 1024		/* Initial settin
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
 
+#define SEEK_SET	0	/* seek relative to beginning of file */
+#define SEEK_CUR	1	/* seek relative to current file position */
+#define SEEK_END	2	/* seek relative to end of file */
+
 /* And dynamically-tunable limits and defaults: */
 struct files_stat_struct {
 	int nr_files;		/* read only */
