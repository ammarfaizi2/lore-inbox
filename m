Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbVJ2GI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVJ2GI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 02:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVJ2GI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 02:08:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:13992 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751422AbVJ2GI4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 02:08:56 -0400
Date: Sat, 29 Oct 2005 07:08:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] missing bits in sparkspkr conversion
Message-ID: <20051029060849.GD7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/drivers/input/misc/sparcspkr.c current/drivers/input/misc/sparcspkr.c
--- RC14-base/drivers/input/misc/sparcspkr.c	2005-10-28 22:35:58.000000000 -0400
+++ current/drivers/input/misc/sparcspkr.c	2005-10-29 01:55:46.000000000 -0400
@@ -143,7 +143,7 @@
 	sparcspkr_dev->name = "Sparc ISA Speaker";
 	sparcspkr_dev->event = isa_spkr_event;
 
-	input_register_device(&sparcspkr_dev);
+	input_register_device(sparcspkr_dev);
 
 	return 0;
 }
