Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWDDJ2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWDDJ2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWDDJ2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:28:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:46791 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932414AbWDDJ2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:28:08 -0400
Message-ID: <44323C24.4010402@garzik.org>
Date: Tue, 04 Apr 2006 05:28:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Mauro Tassinari <mtassinari@cmanet.it>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: libata/sata status on ich[?]
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.7 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.7 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Tassinari wrote:
> Hi Jeff, All,
> 
> our latest tests on previously reported ICH6 platforms show
> 2.6.16.git not reporting any device on 4th master port.
> The same behaviour was previously observed with 2.6.16-mm2,
> regardless the hd brand and type.

Is this fixed in 2.6.17-rc1?


> 2.6.16.1
> ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
> ata2: dev 0 ATA-7, max UDMA/133, 320173056 sectors: LBA48

> 2.6.16-git16
> ata_piix 0000:00:1f.2: MAP [ P0 P1 P2 P3 ]
> ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
> ata2: SATA port has no device.

Thanks for that info.  Can you also provide 'lspci -vvv' (run as root)?

	Jeff


