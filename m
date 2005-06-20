Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVFUAmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFUAmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVFUAiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:38:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:45028 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261767AbVFTW7z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:55 -0400
Cc: gregkh@suse.de
Subject: [PATCH] driver core: change export symbol for driver_for_each_device()
In-Reply-To: <1119308366271@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <11193083662974@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: change export symbol for driver_for_each_device()

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Index: linux-2.6.12-rc2/drivers/base/driver.c
===================================================================

---
commit 126eddfbf8cae8a20c22708192bffcbd77c8a889
tree 204287a611f015bb68f96d3be1135d2e93826b35
parent 4d12d2d953ca5e299de6a653f1d0478f670d7bc6
author gregkh@suse.de <gregkh@suse.de> Tue, 22 Mar 2005 12:17:13 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:24 -0700

 drivers/base/driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -52,7 +52,7 @@ int driver_for_each_device(struct device
 	return error;
 }
 
-EXPORT_SYMBOL(driver_for_each_device);
+EXPORT_SYMBOL_GPL(driver_for_each_device);
 
 
 /**

