Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130677AbQKNHLc>; Tue, 14 Nov 2000 02:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbQKNHLM>; Tue, 14 Nov 2000 02:11:12 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:55044 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130677AbQKNHLF>; Tue, 14 Nov 2000 02:11:05 -0500
Date: Tue, 14 Nov 2000 01:40:31 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: davej@suse.de
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: UDMA66/100 errors...
In-Reply-To: <Pine.LNX.4.21.0011140106040.1173-100000@neo.local>
Message-ID: <Pine.LNX.4.21.0011140138080.966-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000 davej@suse.de wrote:

>Date: Tue, 14 Nov 2000 01:08:51 +0000 (GMT)
>From: davej@suse.de
>To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>Cc: mharris@opensourceadvocate.org
>Content-Type: TEXT/PLAIN; charset=US-ASCII
>Subject: Re: UDMA66/100 errors...
>
>
>Mike Harris wrote..
>
>>I'm getting the following error when I try and enable UDMA on my
>>new IBM Deskstar UDMA100 drive:
>>...
>> DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
>
>Ok, the drive supports UDMA5 (ATA100)

Yep..

>> setting xfermode to 67 (UltraDMA mode3)
>>ide0: Speed warnings UDMA 3/4/5 is not functional.
>
>Why can this be?

I have Quantum UDMA/33 on Master and IBM UDMA/66 on Slave?  Just
an idea..

>>00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
>
>This chipset only does up to UDMA2.

This motherboard states that it does ATA/66.  I suspect that it
is the Linux IDE driver biting me this time..  ;o(

Time to upgrade kernels..

----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

[Favorite quotes of Linus Torvalds - Sept 6, 2000]
I'm a bastard. I have absolutely no clue why people can ever think
otherwise. Yet they do. People think I'm a nice guy, and the fact is that
I'm a scheming, conniving bastard who doesn't care for any hurt feelings
or lost hours of work if it just results in what I consider to be a better
system.  And I'm not just saying that. I'm really not a very nice person. 
I can say "I don't care" with a straight face, and really mean it.
        -- Linus Torvalds on linux-kernel mailing list

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
