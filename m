Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWIXU6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWIXU6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWIXU6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:58:45 -0400
Received: from orion.profiwh.com ([85.93.165.28]:35343 "EHLO orion.profiwh.com")
	by vger.kernel.org with ESMTP id S932096AbWIXU6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:58:45 -0400
Message-id: <874737987984375@wsc.cz>
Subject: [PATCH 1/3] Char: mxser_new, correct include file
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Sun, 24 Sep 2006 16:58:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, correct include file

include mxser_new.h instead of original mxser.h

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit dd2854d08be285b6b2ea538d7a2090a6c0c9982a
tree d59b00af1fb5aa8851019e000d45764c048572b3
parent 7a6d209f0b3ad71818138d9c2b4694fdf3181859
author Jiri Slaby <jirislaby@gmail.com> Sun, 24 Sep 2006 22:26:30 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sun, 24 Sep 2006 22:26:30 +0200

 drivers/char/mxser_new.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index a3aff0b..3c1b750 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -64,7 +64,7 @@ #include <asm/irq.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
-#include "mxser.h"
+#include "mxser_new.h"
 
 #define	MXSER_VERSION	"1.8"
 #define	MXSERMAJOR	 174
