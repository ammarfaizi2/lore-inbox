Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSFCFqM>; Mon, 3 Jun 2002 01:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317283AbSFCFqL>; Mon, 3 Jun 2002 01:46:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17929 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317282AbSFCFqJ>; Mon, 3 Jun 2002 01:46:09 -0400
Message-ID: <3CFAF4EB.6000606@evision-ventures.com>
Date: Mon, 03 Jun 2002 06:47:39 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.19 IDE 78
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>	<3CF9B58B.9080509@evision-ventures.com>	<15609.58274.499517.16643@argo.ozlabs.ibm.com>	<3CFA733F.4070907@evision-ventures.com> <15610.38211.645247.449007@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
>>>>-	OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
>>>>+	ata_irq_enale(drive, 0);
>>>
>>For sure not. The nIEN bit is *negated* on the part of the
>>device - please look at the ata_irq_enable() functions definition.
>>I have explained it there.
> 
> 
> Martin, that's a bit of your patch I was quoting.  I was just trying
> to point out that you wrote "ata_irq_enale" instead of "ata_irq_enable".

Yeep I realized and it's fixed in 82.

