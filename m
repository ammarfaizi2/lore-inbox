Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269846AbUJVHr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269846AbUJVHr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269843AbUJSQpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:45:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:57796 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269801AbUJSQiu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:50 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038153853@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:58 -0700
Message-Id: <10982038183359@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.14, 2004/09/24 19:24:17-07:00, mochel@digitalimplant.org

[driver core] Change symbol exports to GPL only in power/resume.c

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/power/resume.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/power/resume.c b/drivers/base/power/resume.c
--- a/drivers/base/power/resume.c	2004-10-19 09:21:06 -07:00
+++ b/drivers/base/power/resume.c	2004-10-19 09:21:06 -07:00
@@ -58,7 +58,7 @@
 	up(&dpm_sem);
 }
 
-EXPORT_SYMBOL(device_resume);
+EXPORT_SYMBOL_GPL(device_resume);
 
 
 /**
@@ -97,6 +97,6 @@
 	dpm_power_up();
 }
 
-EXPORT_SYMBOL(device_power_up);
+EXPORT_SYMBOL_GPL(device_power_up);
 
 

