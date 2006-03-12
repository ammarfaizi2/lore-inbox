Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWCLW5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWCLW5u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWCLW5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:57:50 -0500
Received: from mail.dvmed.net ([216.237.124.58]:29138 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751833AbWCLW5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:57:49 -0500
Message-ID: <4414A76A.4090109@garzik.org>
Date: Sun, 12 Mar 2006 17:57:46 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Blazejowski <paulb@blazebox.homeip.net>
CC: Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Linux v2.6.16-rc6
References: <1142189154.21274.20.camel@blaze.homeip.net>	 <1142199970.25358.173.camel@mindpipe> <1142202089.9934.13.camel@blaze.homeip.net>
In-Reply-To: <1142202089.9934.13.camel@blaze.homeip.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Blazejowski wrote:
> sata_sil 0000:05:0a.0: Applying R_ERR on DMA activate FIS errata fix

sata_sil

> ata5: SATA max UDMA/100 cmd 0xF9402080 ctl 0xF940208A bmdma 0xF9402000
> irq 23
> ata6: SATA max UDMA/100 cmd 0xF94020C0 ctl 0xF94020CA bmdma 0xF9402008
> irq 23
> ata7: SATA max UDMA/100 cmd 0xF9402280 ctl 0xF940228A bmdma 0xF9402200
> irq 23
> ata8: SATA max UDMA/100 cmd 0xF94022C0 ctl 0xF94022CA bmdma 0xF9402208
> irq 23

host max udma5

> ata5: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
> ata5: dev 0 configured for UDMA/100

dev max udma5, configured for udma5

> ata6: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
> ata6: dev 0 configured for UDMA/100

dev max udma6, configured for host maximum udma5

Everything looks correct.

	Jeff


