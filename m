Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQLPWC1>; Sat, 16 Dec 2000 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQLPWCH>; Sat, 16 Dec 2000 17:02:07 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:52745
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129477AbQLPWB4>; Sat, 16 Dec 2000 17:01:56 -0500
Date: Sat, 16 Dec 2000 13:31:20 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: safemode <safemode@voicenet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE bugs for intel 440LX chipset in Test12?
In-Reply-To: <3A380613.22D085CC@voicenet.com>
Message-ID: <Pine.LNX.4.10.10012161329400.17989-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anyone with a PIIX4,PIIX4AB,PIIX4EB has a hardware bug.
If many of the chipset makers followed and reverse engineered their stuff
against that bug then ths explains all of the timeout issues.

I am working on a fix, but do not have one yet.

Cheers,

On Wed, 13 Dec 2000, safemode wrote:

> All I can say right now is that enabling DMA on a 440LX chipset with
> 2.4.0-test12  or any other kernel I can remember has caused DMA timeout
> and ide-reset problems.  Disabling dma on the harddrives doesn't help
> that much either, I still get ide resets.   What I'm looking for right
> now is some information on how to log what the kernel recieves from the
> harddrive and possibly what it sends so I can give rik some better
> information on what's going on in this chipset.  Thanks.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
