Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316773AbSEWPkG>; Thu, 23 May 2002 11:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316791AbSEWPkF>; Thu, 23 May 2002 11:40:05 -0400
Received: from angband.namesys.com ([212.16.7.85]:12416 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S316773AbSEWPkE>; Thu, 23 May 2002 11:40:04 -0400
Date: Thu, 23 May 2002 19:39:59 +0400
From: Oleg Drokin <green@namesys.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "Gryaznova E." <grev@namesys.botik.ru>, martin@dalecki.de,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
Message-ID: <20020523193959.A2613@namesys.com>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, May 23, 2002 at 04:27:39PM +0200, Martin Dalecki wrote:
> >hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> Since this error can be expected to be quite common.
> Its an installation error. I will just make the corresponding
> error message more intelliglible to the average user:
> hda: checksum error on data transfer occurred!

BTW, I have a particular setup that spits out such errors,
and I somehow thinks the cable is good.

I have IBM DTLA-307030 drive and Seagate Barracuda IV drive (last one purchased
only recently).
IBM drive is connected to far end of 80-wires IDE cable and Barracuda is
connected to the middle of this same wire.
Before I bought IBM drive, everything was ok.
But now I see BadCRC errors on hdb (only on hdb, which is barracuda drive)
usually when both drives are active.
If I disable DMA on IBM drive (or if kernel disables it by itself for some
reason, and it actually does it sometimes), these errors seems to go away.

This is all on 2.4.18, but actually I think this is irrelevant.

If that's a bad cable, why it is only happens when both drives are working
in DMA mode?

Thank you.

Bye,
    Oleg
