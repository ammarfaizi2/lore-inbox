Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130872AbRCFCOu>; Mon, 5 Mar 2001 21:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbRCFCOl>; Mon, 5 Mar 2001 21:14:41 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6663
	"EHLO gateway.matchmail.com") by vger.kernel.org with ESMTP
	id <S130872AbRCFCOY>; Mon, 5 Mar 2001 21:14:24 -0500
Message-ID: <3AA447EA.CE0EC7AC@matchmail.com>
Date: Mon, 05 Mar 2001 18:14:02 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Shane Wegner <shane@cm.nu>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE trouble under 2.2.19pre16 with Hedrick's IDE patch
In-Reply-To: <20010304171528.A4966@cm.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Wegner wrote:
> 
> Hi,
> 
> Whenever I write a substantial amount of data (200mb) to
> disk, I get these messages.  The disks lock for about 10
> seconds and then come back for about 10 seconds again.
> This continues until the data is successfully written.
> 
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hde: DMA disabled
It looks like you have set your drive for a dma mode it doesn't support.

HTH

Mike
