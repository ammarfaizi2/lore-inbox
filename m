Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313595AbSDHJXc>; Mon, 8 Apr 2002 05:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313596AbSDHJXc>; Mon, 8 Apr 2002 05:23:32 -0400
Received: from [195.63.194.11] ([195.63.194.11]:778 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313595AbSDHJXb>;
	Mon, 8 Apr 2002 05:23:31 -0400
Message-ID: <3CB1530F.4030809@evision-ventures.com>
Date: Mon, 08 Apr 2002 10:21:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: paulus@samba.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-pmac.c update
In-Reply-To: <15537.20957.722974.330178@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> Martin,
> 
> The patch below updates drivers/ide/ide-pmac.c (the powermac IDE
> driver) to use the PCI DMA API and to correspond with the recent
> changes to the ide driver.  It also arranges for report_drive_dmaing
> to be exported from ide-dma.c so ide-pmac.c can use it, and fixes a
> minor problem in ide-probe.c where an instance of "ide_floppy" got
> missed in the change to ATA_FLOPPY.

Indeed I have noticed recently this omission already as well myself...

> Assuming the patch looks OK to you, could you forward it to Linus for
> him to apply to his linux-2.5 tree, please?  If you prefer I can make
> this available in a bitkeeper tree for you to pull from.

The patch looks fine - thank you.
However I don't use BK myself, so "classical" patches are fine with me.
I will submitt it, if I'm ready with the "killing" of the mate member
in ata_channel (unit is sufficient to distinguish different channels
and pointers are *evil*).

