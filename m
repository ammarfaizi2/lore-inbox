Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUCPACU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbUCPACT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:02:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:64942 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262866AbUCPABt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:01:49 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951493102@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:09 -0800
Message-Id: <10793951494179@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.15, 2004/03/15 14:36:49-08:00, akpm@osdl.org

[PATCH] cdev: warning fix

Against Jon's cdev stuff


 drivers/char/tty_io.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Mar 15 15:28:13 2004
+++ b/drivers/char/tty_io.c	Mon Mar 15 15:28:13 2004
@@ -2234,7 +2234,6 @@
 	int error;
         int i;
 	dev_t dev;
-	char *s;
 	void **p = NULL;
 
 	if (driver->flags & TTY_DRIVER_INSTALLED)

