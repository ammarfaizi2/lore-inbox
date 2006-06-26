Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWFZBMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWFZBMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWFZA6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16527 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964978AbWFZA61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:27 -0400
Date: Sun, 25 Jun 2006 17:57:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 07/43] Eliminate unnecessary whitespace delta vs. Linus' tree
Message-Id: <klibc.200606251757.07@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus' tree has a space-tab sequence for a few lines in these files,
causing an unnecessary delta.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 7c753dbe7467f0d5ff6904f1bf5840350527e3c4
tree c40a68f6556a702a836d9a6e90f5d632eed0bc0c
parent 0f5a324d655ad582246b6830843114d09835f593
author H. Peter Anvin <hpa@zytor.com> Thu, 06 Apr 2006 14:15:53 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:46:34 -0700

 arch/i386/kernel/setup.c   |    2 +-
 arch/x86_64/kernel/setup.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 54c72d9..4945931 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1460,7 +1460,7 @@ #ifdef CONFIG_EFI
 		efi_enabled = 1;
 #endif
 
-	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
+ 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
 	edid_info = EDID_INFO;
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 6d4f025..003667e 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -599,7 +599,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	unsigned long kernel_end;
 
-	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
+ 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	screen_info = SCREEN_INFO;
 	edid_info = EDID_INFO;
 	saved_video_mode = SAVED_VIDEO_MODE;
