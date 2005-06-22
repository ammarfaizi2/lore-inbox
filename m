Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVFVH1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVFVH1s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVFVHZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:25:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:58779 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262771AbVFVFVv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:51 -0400
Cc: ladis@linux-mips.org
Subject: [PATCH] ds1337: export ds1337_do_command
In-Reply-To: <11194174624139@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:43 -0700
Message-Id: <11194174631916@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ds1337: export ds1337_do_command

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit da17838c5e7256976c34c5d051dc8fb3c6f364b7
tree 179d41ec3c1e01263cae06cee297ebcf35769aa7
parent 912b9c0c52b95696165e84d67fdab2af81a2213e
author Ladislav Michl <ladis@linux-mips.org> Wed, 11 May 2005 10:32:54 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:52 -0700

 drivers/i2c/chips/ds1337.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -380,5 +380,7 @@ MODULE_AUTHOR("James Chapman <jchapman@k
 MODULE_DESCRIPTION("DS1337 RTC driver");
 MODULE_LICENSE("GPL");
 
+EXPORT_SYMBOL_GPL(ds1337_do_command);
+
 module_init(ds1337_init);
 module_exit(ds1337_exit);

