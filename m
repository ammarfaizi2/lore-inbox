Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbUK1SCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUK1SCc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbUK1SCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:02:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60939 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261540AbUK1SC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:02:29 -0500
Date: Sun, 28 Nov 2004 19:02:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.29-pre1: add missing SCSI_SATA_AHCI Configure.help entry
Message-ID: <20041128180228.GB4390@stusta.de>
References: <20041125220305.GA4912@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125220305.GA4912@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 08:03:06PM -0200, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.28 to v2.4.29-pre1
> ============================================
>...
> Jeff Garzik:
>...
>   o [libata] add AHCI driver
>...

Could you introduce a penalty for people forgetting the Configure.help 
entry when adding a new option?  ;-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.4.29-pre1-full/Documentation/Configure.help.old	2004-11-28 18:59:40.000000000 +0100
+++ linux-2.4.29-pre1-full/Documentation/Configure.help	2004-11-28 19:00:42.000000000 +0100
@@ -9345,6 +9345,11 @@
 
   If unsure, say N.
 
+CONFIG_SCSI_SATA_AHCI
+  This option enables support for AHCI Serial ATA.
+
+  If unsure, say N.
+
 CONFIG_SCSI_SATA_SVW
   This option enables support for Broadcom/Serverworks/Apple K2
   SATA support.




