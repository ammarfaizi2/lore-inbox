Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUIOWww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUIOWww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUIOWw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:52:28 -0400
Received: from mproxy.gmail.com ([216.239.56.246]:64569 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267743AbUIOWtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:49:08 -0400
Message-ID: <c49d2fb004091515492737d6a3@mail.gmail.com>
Date: Wed, 15 Sep 2004 17:49:04 -0500
From: Jeremiah Holt <jholt5638@gmail.com>
Reply-To: Jeremiah Holt <jholt5638@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Patch gamecon.c
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes gc_psx_delay from 60 usecs to 10 usecs. At 60usecs
my system was almost unusable anything a app wanted to use the the
joystick I tried the gc_psx_delay= switch for the module but that
appears to be no longer supported. Please personally CC: all comments
to me thanks

--- ./linux-2.4.28/drivers/char/joystick/gamecon.c      2004-09-15
17:45:43.000000000 -0500
+++ ./linux-2.4.28-patched/drivers/char/joystick/gamecon.c     
2004-09-15 17:27:43.000000000 -0500
@@ -213,7 +213,7 @@
  *
  */

-#define GC_PSX_DELAY   60              /* 60 usec */
+#define GC_PSX_DELAY   10              /* 10 usec */
 #define GC_PSX_LENGTH  8               /* talk to the controller in bytes */

 #define GC_PSX_MOUSE   1               /* Mouse */
