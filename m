Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUIAVgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUIAVgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUIAVG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:06:59 -0400
Received: from baikonur.stro.at ([213.239.196.228]:21175 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267968AbUIAU4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:34 -0400
Subject: [patch 10/25]  drivers/char/rocket_int.h MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:33 +0200
Message-ID: <E1C2c9h-0007MH-Lr@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/rocket_int.h |    4 ----
 1 files changed, 4 deletions(-)

diff -puN drivers/char/rocket_int.h~min-max-char_rocket_int.h drivers/char/rocket_int.h
--- linux-2.6.9-rc1-bk7/drivers/char/rocket_int.h~min-max-char_rocket_int.h	2004-09-01 19:34:10.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/rocket_int.h	2004-09-01 19:34:10.000000000 +0200
@@ -1241,10 +1241,6 @@ struct r_port {
 #define TTY_ROCKET_MAJOR	46
 #define CUA_ROCKET_MAJOR	47
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 #ifdef PCI_VENDOR_ID_RP
 #undef PCI_VENDOR_ID_RP
 #undef PCI_DEVICE_ID_RP8OCTA

_
