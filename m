Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265696AbUFUBzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265696AbUFUBzm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 21:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUFUBzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 21:55:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17353 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265696AbUFUBzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 21:55:41 -0400
Date: Mon, 21 Jun 2004 03:55:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.7-mm1: drivers/scsi/hosts.h -> scsi/scsi_host.h
Message-ID: <20040621015537.GK27822@fs.tum.de>
References: <20040620174632.74e08e09.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620174632.74e08e09.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 05:46:32PM -0700, Andrew Morton wrote:
>...
> All 226 patches:
>...
> bk-libata.patch
>...

drivers/scsi/hosts.h is obsolete, use scsi/scsi_host.h.

Please apply
Adrian

--- linux-2.6.7-mm1-full/drivers/scsi/sata_nv.c.old	2004-06-21 03:50:36.000000000 +0200
+++ linux-2.6.7-mm1-full/drivers/scsi/sata_nv.c	2004-06-21 03:51:17.000000000 +0200
@@ -31,7 +31,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include "scsi.h"
-#include "hosts.h"
+#include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
