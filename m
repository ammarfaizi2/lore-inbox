Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRCFTEY>; Tue, 6 Mar 2001 14:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129402AbRCFTEO>; Tue, 6 Mar 2001 14:04:14 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:15761 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129216AbRCFTEI>; Tue, 6 Mar 2001 14:04:08 -0500
Message-Id: <5.0.2.1.2.20010306110143.027c7698@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 06 Mar 2001 11:01:50 -0800
To: Mike Fedyk <mfedyk@matchmail.com>, Shane Wegner <shane@cm.nu>
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Re: IDE trouble under 2.2.19pre16 with Hedrick's IDE patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AA447EA.CE0EC7AC@matchmail.com>
In-Reply-To: <20010304171528.A4966@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No this error is not by the wrong DMA settings.  If you have a drive in dma 
mode 5 and the controller does not support it, the kernel will give you a 
proper error saying that this dma mode is not supported by the 
controller.  This is most likly something with the kernel.  I'd try 
upgrading to the latest 2.4.2-ac?? series.

Let me know if I'm mistaken about this one guys...

Jasmeet


At 06:14 PM 3/5/2001 -0800, Mike Fedyk wrote:
>Shane Wegner wrote:
> >
> > Hi,
> >
> > Whenever I write a substantial amount of data (200mb) to
> > disk, I get these messages.  The disks lock for about 10
> > seconds and then come back for about 10 seconds again.
> > This continues until the data is successfully written.
> >
> > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> > hde: DMA disabled
>It looks like you have set your drive for a dma mode it doesn't support.
>
>HTH
>
>Mike
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


- - -
Jasmeet Sidhu
Unix Systems Administrator
ArrayComm, Inc.
jsidhu@arraycomm.com
www.arraycomm.com


