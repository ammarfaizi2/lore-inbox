Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265989AbUAQNrC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 08:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbUAQNrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 08:47:02 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:10208 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S265989AbUAQNrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 08:47:00 -0500
Date: Sat, 17 Jan 2004 13:42:56 +0000
From: in <i.n@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] <drivers/usb/storage/dpcm.c>, kernel <2.6.1>
Message-Id: <20040117134256.09046469.i.n@netcabo.pt>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2004 13:46:59.0293 (UTC) FILETIME=[60F540D0:01C3DD00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] <drivers/usb/storage/dpcm.c>, kernel <2.6.1>

It just takes out the unused int! just takes of the warning when compiling!

--- a/drivers/usb/storage/dpcm.c  2003-12-18 02:59:15.000000000 +0000
+++ linux/drivers/usb/storage/dpcm.c    2004-01-17 13:22:49.000000000 +0000
@@ -43,8 +43,6 @@
  */
 int dpcm_transport(Scsi_Cmnd *srb, struct us_data *us)
 {
-  int ret;
-
   if(srb == NULL)
     return USB_STOR_TRANSPORT_ERROR;
 

