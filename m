Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129539AbQK3QpG>; Thu, 30 Nov 2000 11:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130367AbQK3Qo5>; Thu, 30 Nov 2000 11:44:57 -0500
Received: from windsormachine.com ([206.48.122.28]:28428 "EHLO
        router.windsormachine.com") by vger.kernel.org with ESMTP
        id <S129539AbQK3Qov>; Thu, 30 Nov 2000 11:44:51 -0500
Message-ID: <3A267CDB.DEC0A214@windsormachine.com>
Date: Thu, 30 Nov 2000 11:14:19 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Guennadi Liakhovetski <gvlyakh@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA for triton again...
In-Reply-To: <E141W6K-000AgZ-00@f6.mail.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:

> Thanks!
>
> > Chipset is a 430FX, Same hard drive as what you have.  Pentium > 133, 48 meg ram.  Kernel 2.2.17 with raid patch, and ide patch.
>
> I don't think I need tha raid patch, do I?

No, its just left overs from my playing with a Promise Ultra/66 card.  Even without the raid and ide patches, i can use DMA

> Intel Morrison64 (not Morrison32!) aka Advanced/MN (in some sources Advanced/AL). BIOS AMI 1.00.03.CA0 (upgraded to 1.00.04.CA0).
>

Opposite side of the spectrum from the utter crap this DataExpert is. =)  Had to get a modified bios, to get a 13.6 gig to exist in the machine without locking it up
on the POST.  Yes, you can tell it no bios, but without the ide patches, it's _very_ slow.

> What version of hdparm are you using? By the output it looks like 3.9, patched? Did DMA work from the very beginning? Can you send me a copy of your .config file?

standard hdparm 3.9, from debian woody.  The difference is i used -i, instead of -I, i think.  I'll see how mangled my .config is.
Looks somewhat clean, a few modules i don't use.  I'll send it in a seperate email.

I've got maybe 3 or 4 of these machines in service as backup servers for small lans.  Small 1.6 gig boot drive, 13.6 gig data drive, a cdrom, and a IDE 7/14 gig HP
tape drive.  Speeds aren't too bad, and DMA seems to work on the parts that support it.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
