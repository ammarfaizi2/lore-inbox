Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVBIByr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVBIByr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 20:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVBIByq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 20:54:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51972 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261737AbVBIByo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 20:54:44 -0500
Date: Wed, 9 Feb 2005 02:54:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill drivers/scsi/hosts.h
Message-ID: <20050209015443.GB2978@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since more than half a year ago, drivers/scsi/hosts.h gives a warning, 
so it seems to be time to remove it.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm1-full/drivers/scsi/hosts.h	2004-12-24 22:34:30.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,2 +0,0 @@
-#warning "This file is obsolete, please use <scsi/scsi_host.h> instead"
-#include <scsi/scsi_host.h>
