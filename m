Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVKLPLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVKLPLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 10:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVKLPLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 10:11:16 -0500
Received: from www.swissdisk.com ([216.144.233.50]:15341 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S932361AbVKLPLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 10:11:15 -0500
Date: Sat, 12 Nov 2005 06:03:11 -0800
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Update location of ll_rw_blk.c in docs
Message-ID: <20051112140311.GA29538@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Picked from the ubuntu-2.6 tree

diff-tree d96fe6eeebd11fb8f70d091eb368e901cec64e1b (from cfd55027d8596fdd19e0023573cc0a6b92994d35)
Author: Ben Collins <bcollins@ubuntu.com>
Date:   Sat Nov 12 09:29:51 2005 -0500

    [UBUNTU:Documentation] Update location of ll_rw_blk.c in docs
    
    The change in location for ll_rw_blk.c from drivers/block/ to block/
    caused failure to generate documentation.
    
    UpstreamStatus: Submitted for 2.6.15
    
    Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl
+++ b/Documentation/DocBook/kernel-api.tmpl
@@ -388,7 +388,7 @@ X!Edrivers/pnp/system.c
 
   <chapter id="blkdev">
      <title>Block Devices</title>
-!Edrivers/block/ll_rw_blk.c
+!Eblock/ll_rw_blk.c
   </chapter>
 
   <chapter id="miscdev">
diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -1063,8 +1063,8 @@ Aside:
 4.4 I/O contexts
 I/O contexts provide a dynamically allocated per process data area. They may
 be used in I/O schedulers, and in the block layer (could be used for IO statis,
-priorities for example). See *io_context in drivers/block/ll_rw_blk.c, and
-as-iosched.c for an example of usage in an i/o scheduler.
+priorities for example). See *io_context in block/ll_rw_blk.c, and as-iosched.c
+for an example of usage in an i/o scheduler.
 
 
 5. Scalability related changes

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
