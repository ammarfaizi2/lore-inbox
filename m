Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbUAPVDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 16:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUAPVDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 16:03:24 -0500
Received: from cliff.cse.wustl.edu ([128.252.166.5]:51190 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S265765AbUAPVCs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:02:48 -0500
From: "Cheng Huang" <cheng@cse.wustl.edu>
To: "=?utf-8?Q?'Pasi_K=E9=8B=9Ckk=E9=8B=93nen'?=" <pasik@iki.fi>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Hang with Promise Ultra100 TX2 (kernel 2.4.18)
Date: Fri, 16 Jan 2004 15:02:44 -0600
Message-ID: <006801c3dc74$16e57780$0400a8c0@ChengDELL>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20040115114922.GI1254@edu.joroinen.fi>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for replying. Can you explain a little bit where to get the driver for latest versions? Thanks.

-- Cheng

-----Original Message-----
From: Pasi K鋜kk鋓nen [mailto:pasik@iki.fi] 
Sent: Thursday, January 15, 2004 5:49 AM
To: Cheng Huang
Cc: linux-kernel@vger.kernel.org; cheng@cse.wustl.edu
Subject: Re: Hang with Promise Ultra100 TX2 (kernel 2.4.18)

On Thu, Jan 15, 2004 at 03:17:12AM -0600, Cheng Huang wrote:
> I have to use kernel 2.4.18 because I need to install KURT (realtime
> linux) with it. However, my system hangs on boot with the following
> message:
> 
> PDC20268: not 100% native mode: will probe irqs later
> PDC20268: ROM enabled at 0xff900000
>     ide2: BM-DMA at 0xfcc0-0xfcc7, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xfcc8-0xfccf, BIOS settings: hdg:pio, hdh:pio
> 
> I have tried tricks I could find in through google, like setting boot
> parameters "hde=4866,255,63 hde=noprobe hdg=24321,255,163 hdg=noprobe".
> But it didn't work.
> 
> Could anybody provide some clue about how to fix this problem? Thanks
> very much.
> 

I think there has been a lot of bug fixes in the latest 2.4 kernels for
promise cards.

I'm running promise ultra133-tx2 successfully with 2.4.22 kernel.

Merge the promise driver from later 2.4.x kernels to 2.4.18 and recompile? 

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

