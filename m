Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTD3WHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTD3WHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:07:01 -0400
Received: from pointblue.com.pl ([62.89.73.6]:53772 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262458AbTD3WHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:07:00 -0400
Subject: 2.5.68-bk10 drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET'
	undeclared
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1051741247.4565.1.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Apr 2003 23:20:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/bluetooth/hci_usb.c: In function `hci_usb_send_bulk':
drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET' undeclared (first use
in this function)
drivers/bluetooth/hci_usb.c:461: (Each undeclared identifier is reported
only once
drivers/bluetooth/hci_usb.c:461: for each function it appears in.)
make[2]: *** [drivers/bluetooth/hci_usb.o] Error 1
make[1]: *** [drivers/bluetooth] Error 2
make: *** [drivers] Error 2

probably #define USB_ZERO_PACKET should help, but i am not convinent.

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

