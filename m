Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266051AbRGCX21>; Tue, 3 Jul 2001 19:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266060AbRGCX2R>; Tue, 3 Jul 2001 19:28:17 -0400
Received: from martnet.com ([146.145.176.8]:61358 "EHLO home.martnet.com")
	by vger.kernel.org with ESMTP id <S266051AbRGCX2E>;
	Tue, 3 Jul 2001 19:28:04 -0400
Date: Tue, 3 Jul 2001 19:27:54 -0400
From: John Guthrie <guthrie@home.martnet.com>
Message-Id: <200107032327.TAA19640@home.martnet.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] small patch to ide-tape.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This patch adds a missing semicolon that is noticed only if you define
IDETAPE_DEBUG_LOG_VERBOSE:

John Guthrie
guthrie@martnet.com

------------------------------CUT HERE-------------------------------------

--- ide-tape.c.orig	Tue Jul  3 18:20:22 2001
+++ ide-tape.c	Tue Jul  3 18:22:41 2001
@@ -1409,7 +1409,7 @@
 		case IDETAPE_WRITE_FILEMARK_CMD:	return("WRITE_FILEMARK_CMD");
 		case IDETAPE_SPACE_CMD:			return("SPACE_CMD");
 		case IDETAPE_INQUIRY_CMD:		return("INQUIRY_CMD");
-		case IDETAPE_ERASE_CMD:			return("ERASE_CMD")
+		case IDETAPE_ERASE_CMD:			return("ERASE_CMD");
 		case IDETAPE_MODE_SENSE_CMD:		return("MODE_SENSE_CMD");
 		case IDETAPE_MODE_SELECT_CMD:		return("MODE_SELECT_CMD");
 		case IDETAPE_LOAD_UNLOAD_CMD:		return("LOAD_UNLOAD_CMD");
