Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbUK3CiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUK3CiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUK3CAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:00:47 -0500
Received: from baikonur.stro.at ([213.239.196.228]:42216 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261923AbUK3B5e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:34 -0500
Subject: [patch 08/11] Subject: ifdef typos: drivers_usb_net_usbnet.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org,
       rddunlap@osdl.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:31 +0100
Message-ID: <E1CYxGm-0002vE-74@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Although neither symbol is not defined (yet?); code uses some
GENELINK_* (_ACK too), so this seems right.

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk13-max/drivers/usb/net/usbnet.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/usb/net/usbnet.c~ifdef-drivers_usb_net_usbnet drivers/usb/net/usbnet.c
--- linux-2.6.10-rc2-bk13/drivers/usb/net/usbnet.c~ifdef-drivers_usb_net_usbnet	2004-11-30 02:41:41.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/drivers/usb/net/usbnet.c	2004-11-30 02:41:41.000000000 +0100
@@ -1298,7 +1298,7 @@ struct gl_header {
 	struct gl_packet	packets;
 };
 
-#ifdef	GENLINK_ACK
+#ifdef	GENELINK_ACK
 
 // FIXME:  this code is incomplete, not debugged; it doesn't
 // handle interrupts correctly.  interrupts should be generic
_
