Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUIAVEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUIAVEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267988AbUIAVDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:03:25 -0400
Received: from baikonur.stro.at ([213.239.196.228]:34723 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267977AbUIAU5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:06 -0400
Subject: [patch 16/25]  include/linux/isicom.h MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:06 +0200
Message-ID: <E1C2cAE-0007QX-J1@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/include/linux/isicom.h |    1 -
 1 files changed, 1 deletion(-)

diff -puN include/linux/isicom.h~min-max-linux_isicom.h include/linux/isicom.h
--- linux-2.6.9-rc1-bk7/include/linux/isicom.h~min-max-linux_isicom.h	2004-09-01 19:34:22.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/include/linux/isicom.h	2004-09-01 19:34:22.000000000 +0200
@@ -102,7 +102,6 @@ typedef	struct	{
 #define ClearInterrupt(base) (inw((base)+0x0a))	
 
 #define	BOARD(line)  (((line) >> 4) & 0x3)
-#define MIN(a, b) ( (a) < (b) ? (a) : (b) )
 
 	/*	isi kill queue bitmap	*/
 	

_
