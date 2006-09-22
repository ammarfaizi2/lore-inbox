Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWIVPuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWIVPuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWIVPuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:50:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:36248 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964777AbWIVPuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:50:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QSDsV5faFkDS8ZnoIQj+9fcyTyMkQHBsgAKymDZt5K6xUwquCw96eQEXsFoS2pZNmy200X97oed0CaI2iaWiEuRO4NbkhEsG22fLEO2bHjZ3KMVVy+DEtRfc0hlnymw5+FdZ4Qx++iiqZ5VUfbUDufYbY7BP1tB5v11TkDH6/0Q=
Message-ID: <bd0cb7950609220850k7186efco7e0b6328e9461bf5@mail.gmail.com>
Date: Fri, 22 Sep 2006 11:50:19 -0400
From: "Tom St Denis" <tomstdenis@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sky2 network driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sky2 network driver for 965P-S3 Gigabyte
motherboards by adding the device ID required for this revision of the
chipset.

Signed-Off-by: Tom St Denis <tomstdenis@gmail.com>

--- linux-2.6.18/drivers/net/sky2.c	2006-09-20 03:42:06.000000000 +0000
+++ linux-2.6.18-tom/drivers/net/sky2.c	2006-09-22 21:28:03.000000000 +0000
@@ -121,6 +121,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4361) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4362) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4363) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4364) },
 	{ 0 }
 };



Tom
