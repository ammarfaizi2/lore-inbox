Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbULZPep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbULZPep (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbULZPd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:33:58 -0500
Received: from coderock.org ([193.77.147.115]:32480 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261673AbULZPdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:33:00 -0500
Subject: [patch 3/6] delete unused file
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sun, 26 Dec 2004 16:33:02 +0100
Message-Id: <20041226153246.AE6C31F126@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/drivers/char/rsf16fmi.h |   13 -------------
 1 files changed, 13 deletions(-)

diff -L drivers/char/rsf16fmi.h -puN drivers/char/rsf16fmi.h~remove_file-drivers_char_rsf16fmi.h /dev/null
--- kj/drivers/char/rsf16fmi.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,13 +0,0 @@
-/* SF16FMI FMRadio include file.
- * (c) 1998 Petr Vandrovec
- *
- * Not in include/linux/ because there's no need for anyone
- * to know about these details, I reckon.
- */
-
-#ifndef __RSF16FMI_H
-#define __RSF16FMI_H
-
-int radiosf16fmi_init(void);
-
-#endif /* __RSF16FMI_H */
_
