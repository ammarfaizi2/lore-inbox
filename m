Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbUC3OeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbUC3OeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:34:08 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:61323 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263676AbUC3OeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:34:06 -0500
Date: Tue, 30 Mar 2004 15:32:10 +0100
From: Dave Jones <davej@redhat.com>
To: luca.risolia@studio.unibo.it
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] w9968cf driver misplaced ;
Message-ID: <20040330143210.GA25834@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	luca.risolia@studio.unibo.it,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.4/drivers/usb/media/w9968cf.c~	2004-03-30 15:28:43.000000000 +0100
+++ linux-2.6.4/drivers/usb/media/w9968cf.c	2004-03-30 15:29:08.000000000 +0100
@@ -3369,7 +3369,7 @@
 		if (copy_from_user(&tuner, arg, sizeof(tuner)))
 			return -EFAULT;
 
-		if (tuner.tuner != 0);
+		if (tuner.tuner != 0)
 			return -EINVAL;
 
 		strcpy(tuner.name, "no_tuner");
