Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVK0I7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVK0I7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 03:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVK0I7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 03:59:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:20682 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750947AbVK0I7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 03:59:12 -0500
X-Authenticated: #4707809
Date: Sun, 27 Nov 2005 09:59:10 +0100
From: Fridtjof Busse <fbusse@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Assertion failed in libata
Message-Id: <20051127095910.4abeef90.fbusse@gmx.de>
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.14-rc2 on a Thinkpad T43, using libata.atapi_enabled=1
and ATA_ENABLE_PATA/ATAPI_ENABLE_DMADIR in include/linux/libata.h.
During heavy diskload, I sometimes get a couple of errors (not
reproducable for me yet):

Assertion failed! qc->n_elem >
0,drivers/scsi/libata-core.c,ata_fill_sg,line=2482

Since the reading/writing has problems accessing the file if this
occurs, I guess it is more than just a warning. Since Google didn't
turn anything up, I just wanted to report this.
Please CC me, thanks.

-- 
Fridtjof Busse
