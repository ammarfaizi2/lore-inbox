Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUI0Rvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUI0Rvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUI0Rvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:51:31 -0400
Received: from itapoa.terra.com.br ([200.154.55.227]:44474 "EHLO
	itapoa.terra.com.br") by vger.kernel.org with ESMTP id S266879AbUI0RvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:51:07 -0400
Date: Mon, 27 Sep 2004 13:55:09 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5]: usb-serial: Add module version information.
Message-Id: <20040927135509.4815c6d4.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Add module version information for drivers/usb/serial/usb-serial.c.

(against 2.6.9-rc2-mm4).

Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 drivers/usb/serial/usb-serial.c |    1 +
 1 files changed, 1 insertion(+)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2004-09-26 13:57:20.000000000 -0300
+++ a~/drivers/usb/serial/usb-serial.c	2004-09-26 13:57:48.000000000 -0300
@@ -1371,6 +1371,7 @@ EXPORT_SYMBOL(usb_serial_port_softint);
 /* Module information */
 MODULE_AUTHOR( DRIVER_AUTHOR );
 MODULE_DESCRIPTION( DRIVER_DESC );
+MODULE_VERSION( DRIVER_VERSION );
 MODULE_LICENSE("GPL");
 
 module_param(debug, bool, S_IRUGO | S_IWUSR);
