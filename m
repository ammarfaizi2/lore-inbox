Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVFVGWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVFVGWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVFVGW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:22:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:35996 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262806AbVFVFWI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:08 -0400
Cc: clemens.koller@anagramm.de
Subject: [PATCH] I2C: rtc8564.c remove duplicate include
In-Reply-To: <1119417461139@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:41 -0700
Message-Id: <11194174613004@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: rtc8564.c remove duplicate include

[PATCH] I2C rtc8564.c remove duplicate include

Trivial fix: removes duplicate include line.

Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 792f156d61d327671f58829dc04ad5609152e393
tree 4dd7af551142c79867620b20e3f8d91dfa402529
parent 68cc9d0b714d7d533c0cfc257a62f7f7f4f22a11
author Clemens Koller <clemens.koller@anagramm.de> Mon, 11 Apr 2005 11:49:14 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:49 -0700

 drivers/i2c/chips/rtc8564.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
--- a/drivers/i2c/chips/rtc8564.c
+++ b/drivers/i2c/chips/rtc8564.c
@@ -19,7 +19,6 @@
 #include <linux/string.h>
 #include <linux/rtc.h>		/* get the user-level API */
 #include <linux/init.h>
-#include <linux/init.h>
 
 #include "rtc8564.h"
 

