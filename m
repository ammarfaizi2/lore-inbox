Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTAVUTp>; Wed, 22 Jan 2003 15:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTAVUTp>; Wed, 22 Jan 2003 15:19:45 -0500
Received: from holomorphy.com ([66.224.33.161]:1172 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263204AbTAVUTo>;
	Wed, 22 Jan 2003 15:19:44 -0500
Date: Wed, 22 Jan 2003 12:28:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: remove EXT2_MAX_BLOCK_SIZE
Message-ID: <20030122202851.GR780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 100% unused EXT2_MAX_BLOCK_SIZE.

 ext2_fs.h |    1 -
 1 files changed, 1 deletion(-)


diff -urpN cleanup-2.5.59-3/include/linux/ext2_fs.h cleanup-2.5.59-4/include/linux/ext2_fs.h
--- cleanup-2.5.59-3/include/linux/ext2_fs.h	2003-01-16 18:21:39.000000000 -0800
+++ cleanup-2.5.59-4/include/linux/ext2_fs.h	2003-01-22 12:26:00.000000000 -0800
@@ -90,7 +90,6 @@ static inline struct ext2_sb_info *EXT2_
  * Macro-instructions used to manage several block sizes
  */
 #define EXT2_MIN_BLOCK_SIZE		1024
-#define	EXT2_MAX_BLOCK_SIZE		4096
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
 #ifdef __KERNEL__
 # define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
