Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWBTPoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWBTPoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWBTPoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:44:09 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:42000 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S964941AbWBTPoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:44:08 -0500
From: Meelis Roos <mroos@linux.ee>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
In-Reply-To: <1140445182.26526.1.camel@localhost.localdomain>
User-Agent: tin/1.8.1-20060215 ("Mealasta") (UNIX) (Linux/2.6.16-rc4-dirty (i686))
Message-Id: <20060220154404.0383313F93@rhn.tartu-labor>
Date: Mon, 20 Feb 2006 17:44:03 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AC> Various fixes and cleanups, some new functionality notably Promise
AC> 20246/2026x support which although basic should get it going with disk.

So I enabled more config options as before and got a compile error:

--- drivers/scsi/pata_pcmcia.c.orig	2006-02-20 17:41:01.000000000 +0200
+++ drivers/scsi/pata_pcmcia.c	2006-02-20 17:41:10.000000000 +0200
@@ -377,7 +377,7 @@
 
 static struct pcmcia_driver pcmcia_driver = {
 	.owner		= THIS_MODULE,
-	.drv	{
+	.drv	= {
 		.name		= DRV_NAME,
 	},
 	.id_table	= pcmcia_devices,

-- 
Meelis Roos
