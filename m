Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRAaWlA>; Wed, 31 Jan 2001 17:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129456AbRAaWku>; Wed, 31 Jan 2001 17:40:50 -0500
Received: from mail09.voicenet.com ([207.103.0.35]:17549 "HELO
	mail09.voicenet.com") by vger.kernel.org with SMTP
	id <S129065AbRAaWki>; Wed, 31 Jan 2001 17:40:38 -0500
Message-ID: <3A78945F.C82E7CAF@voicenet.com>
Date: Wed, 31 Jan 2001 17:40:31 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Raufeisen <david@fortyoz.org>, Vojtech Pavlik <vojtech@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <Pine.LNX.4.30.0101312302410.14538-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:

> On Wed, 31 Jan 2001, safemode wrote:
>
> > I'm wondering... Perhaps it's a problem motherboard specific.  I'm
> > using the KA7 and saw pretty bad problems (extreme fs corruption)
> > and bad latency. Perhaps the K7V and the KT7's dont have this problem.
> > I dont see any of the problems with dma enabled on 2.2.x
>
> But are you using the same DMA mode in 2.2 as in 2.4?  You can check that
> using hdparm -i, I believe.
>
> /Tobias

yea i know. . same mode       i also had a big problem with DMA timeouts on
2.4 so  .. i dont know what's up with 2.4 and my motherboard ...    2.2
hasn't shown a single irq or DMA error yet since going back to it.
currently 2.2.19-pre7 is using UDMA4     i just flashed the bios today so ..
hopefully that should have fixed any problems.  I get 24MB/s each according
to hdparm -t   on my hdd's and both are on the same channel.   This is much
better than i ever got with 2.4 even when only one drive was on a channel.
Right now my k7-2 750 is at 849mhz with a FSB of 114Mhz and PCI at 34Mhz.
my nbench performance under 2.2 is comparable to results for 1Ghz t-bird's so
i'm happy with 2.2.  The only thing that would make me want to upgrade would
be latency patches.  I'm convinced 2.4 has performance issues so i guess i'll
be using 2.2 until 2.5 begins.      Is it really only 1 or 2 people having
this Via corruption problem?   i doubt it's a bios problem because wouldn't
2.2 be effected by a bios bug if 2.4 is?   In either case the changelogs dont
show any  fixes for it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
