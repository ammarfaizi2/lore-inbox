Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUCPObC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUCPO3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:29:50 -0500
Received: from styx.suse.cz ([82.208.2.94]:3714 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261947AbUCPOTt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:49 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467782227@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 36/44] Don't define DEBUG in hid-ff by default
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <10794467781493@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.78.10, 2004-03-08 13:30:04+01:00, vojtech@suse.cz
  input: Don't define DEBUG in hid-ff by default. It spews messgaes
         even when no FF device is present.


 hid-ff.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-ff.c b/drivers/usb/input/hid-ff.c
--- a/drivers/usb/input/hid-ff.c	Tue Mar 16 13:17:52 2004
+++ b/drivers/usb/input/hid-ff.c	Tue Mar 16 13:17:52 2004
@@ -29,7 +29,7 @@
 
 #include <linux/input.h>
 
-#define DEBUG
+#undef DEBUG
 #include <linux/usb.h>
 
 #include "hid.h"

