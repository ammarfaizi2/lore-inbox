Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270306AbUJTCit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270306AbUJTCit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270301AbUJTCis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:38:48 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:50122 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270280AbUJTCiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:38:07 -0400
Date: Tue, 19 Oct 2004 19:38:03 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH] USB: remove (unneeded proto) that causes a warning w/o CONFIG_PM
Message-ID: <20041020023803.GF8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove (unneeded proto) that causes a warning w/o CONFIG_PM

Signed-off-by: cw@f00f.org

diff -Nru a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
--- a/drivers/usb/host/ohci-hcd.c	2004-10-19 17:48:05 -07:00
+++ b/drivers/usb/host/ohci-hcd.c	2004-10-19 17:48:05 -07:00
@@ -140,7 +140,6 @@
 
 static void ohci_dump (struct ohci_hcd *ohci, int verbose);
 static int ohci_init (struct ohci_hcd *ohci);
-static int ohci_restart (struct ohci_hcd *ohci);
 static void ohci_stop (struct usb_hcd *hcd);
 
 #include "ohci-hub.c"
