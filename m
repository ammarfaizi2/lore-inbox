Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030637AbWKOQOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030637AbWKOQOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030632AbWKOQOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:14:10 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11452 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030630AbWKOQOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:14:06 -0500
Date: Wed, 15 Nov 2006 16:19:28 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] usb: escaped ktermios conversion
Message-ID: <20061115161928.3f29d403@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/usb/serial/sierra.c linux-2.6.19-rc5-mm2/drivers/usb/serial/sierra.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/usb/serial/sierra.c	2006-11-15 13:26:48.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/usb/serial/sierra.c	2006-11-15 13:52:22.000000000 +0000
@@ -145,7 +145,7 @@
 }
 
 static void sierra_set_termios(struct usb_serial_port *port,
-			struct termios *old_termios)
+			struct ktermios *old_termios)
 {
 	dbg("%s", __FUNCTION__);
 
