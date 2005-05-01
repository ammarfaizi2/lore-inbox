Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVEAP6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVEAP6T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 11:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVEAPzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:55:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63752 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261677AbVEAPua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:50:30 -0400
Date: Sun, 1 May 2005 17:50:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix "make mandocs" after class_simple.c removal
Message-ID: <20050501155022.GW3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the removal of class_simple.c, "make mandocs" no longer works.

This patch fixes this issue.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Apr 2005

--- linux-2.6.12-rc2-mm3-full/Documentation/DocBook/kernel-api.tmpl.old	2005-04-17 23:26:10.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/Documentation/DocBook/kernel-api.tmpl	2005-04-17 23:26:17.000000000 +0200
@@ -338,7 +338,6 @@
 X!Iinclude/linux/device.h
 -->
 !Edrivers/base/driver.c
-!Edrivers/base/class_simple.c
 !Edrivers/base/core.c
 !Edrivers/base/firmware_class.c
 !Edrivers/base/transport_class.c

