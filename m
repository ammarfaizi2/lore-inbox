Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265836AbTL3WYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbTL3WNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:13:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:50881 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265836AbTL3WGc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:32 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219711203@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:11 -0800
Message-Id: <10728219711770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.8.35, 2003/12/19 11:49:32-08:00, greg@kroah.com

[PATCH] I2C: removed #include <linux/i2c.h> from sa1100_stork.c as it's not needed.

Thanks to Jean Delvare <khali@linux-fr.org> for pointing it out.


 drivers/pcmcia/sa1100_stork.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/pcmcia/sa1100_stork.c b/drivers/pcmcia/sa1100_stork.c
--- a/drivers/pcmcia/sa1100_stork.c	Tue Dec 30 12:29:25 2003
+++ b/drivers/pcmcia/sa1100_stork.c	Tue Dec 30 12:29:25 2003
@@ -23,7 +23,6 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/device.h>
-#include <linux/i2c.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>

