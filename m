Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933015AbWFWK5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015AbWFWK5C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWFWK4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:56:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6668 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933014AbWFWKzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:55:46 -0400
Date: Fri, 23 Jun 2006 12:55:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ben Collins <bcollins@ubuntu.com>,
       Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/char/agp/nvidia-agp.c: remove unused variable
Message-ID: <20060623105546.GP9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
>  git-agpgart.patch
>...
>  git trees
>...

This patch removes an unused variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm1-full/drivers/char/agp/nvidia-agp.c.old	2006-06-22 18:31:18.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/char/agp/nvidia-agp.c	2006-06-22 18:31:39.000000000 +0200
@@ -387,8 +387,6 @@
 
 static int agp_nvidia_resume(struct pci_dev *pdev)
 {
-	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
-
 	/* set power state 0 and restore PCI space */
 	pci_set_power_state (pdev, 0);
 	pci_restore_state(pdev);
