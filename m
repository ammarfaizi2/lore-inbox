Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWBHD1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWBHD1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbWBHD0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:26:37 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60544 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030481AbWBHDSm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:42 -0500
To: torvalds@osdl.org
Subject: [PATCH 10/29] missing include in ser_a2232
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Message-Id: <E1F6fqs-0006CL-1I@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138603235 -0500

Fallout from tty changes

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/char/ser_a2232.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

3023b438c4b6103d520690cfa8b790bdd3868dc2
diff --git a/drivers/char/ser_a2232.c b/drivers/char/ser_a2232.c
index 80a5b84..fee68cc 100644
--- a/drivers/char/ser_a2232.c
+++ b/drivers/char/ser_a2232.c
@@ -103,6 +103,7 @@
 
 #include <linux/serial.h>
 #include <linux/generic_serial.h>
+#include <linux/tty_flip.h>
 
 #include "ser_a2232.h"
 #include "ser_a2232fw.h"
-- 
0.99.9.GIT

