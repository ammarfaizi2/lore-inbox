Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269951AbUJVHND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269951AbUJVHND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269794AbUJSQvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:51:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:55236 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269793AbUJSQir convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:47 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <1098203795555@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:37 -0700
Message-Id: <1098203797223@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.5, 2004/09/24 11:45:49-07:00, mochel@digitalimplant.org

[driver model] Change symbol exports to GPL only in firmware.c

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/firmware.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/firmware.c b/drivers/base/firmware.c
--- a/drivers/base/firmware.c	2004-10-19 09:21:53 -07:00
+++ b/drivers/base/firmware.c	2004-10-19 09:21:53 -07:00
@@ -30,5 +30,5 @@
 	return subsystem_register(&firmware_subsys);
 }
 
-EXPORT_SYMBOL(firmware_register);
-EXPORT_SYMBOL(firmware_unregister);
+EXPORT_SYMBOL_GPL(firmware_register);
+EXPORT_SYMBOL_GPL(firmware_unregister);

