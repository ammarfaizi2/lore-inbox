Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUAQJvj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 04:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUAQJvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 04:51:39 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:25565 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S265999AbUAQJvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 04:51:37 -0500
Date: Sat, 17 Jan 2004 11:51:35 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Cheng Huang <cheng@cse.wustl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hang with Promise Ultra100 TX2 (kernel 2.4.18)
Message-ID: <20040117095135.GM1254@edu.joroinen.fi>
References: <20040115114922.GI1254@edu.joroinen.fi> <006801c3dc74$16e57780$0400a8c0@ChengDELL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <006801c3dc74$16e57780$0400a8c0@ChengDELL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 03:02:44PM -0600, Cheng Huang wrote:
> Thanks for replying. Can you explain a little bit where to get the driver for latest versions? Thanks.
> 

Copy the promise driver from 2.4.24 kernel to 2.4.18 kernel, and hope it
works :)

- Pasi Kärkkäinen

> -----Original Message-----
> From: Pasi K???kk???nen [mailto:pasik@iki.fi] 
> Sent: Thursday, January 15, 2004 5:49 AM
> To: Cheng Huang
> Cc: linux-kernel@vger.kernel.org; cheng@cse.wustl.edu
> Subject: Re: Hang with Promise Ultra100 TX2 (kernel 2.4.18)
> 
> On Thu, Jan 15, 2004 at 03:17:12AM -0600, Cheng Huang wrote:
> > I have to use kernel 2.4.18 because I need to install KURT (realtime
> > linux) with it. However, my system hangs on boot with the following
> > message:
> > 
> > PDC20268: not 100% native mode: will probe irqs later
> > PDC20268: ROM enabled at 0xff900000
> >     ide2: BM-DMA at 0xfcc0-0xfcc7, BIOS settings: hde:pio, hdf:pio
> >     ide3: BM-DMA at 0xfcc8-0xfccf, BIOS settings: hdg:pio, hdh:pio
> > 
> > I have tried tricks I could find in through google, like setting boot
> > parameters "hde=4866,255,63 hde=noprobe hdg=24321,255,163 hdg=noprobe".
> > But it didn't work.
> > 
> > Could anybody provide some clue about how to fix this problem? Thanks
> > very much.
> > 
> 
> I think there has been a lot of bug fixes in the latest 2.4 kernels for
> promise cards.
> 
> I'm running promise ultra133-tx2 successfully with 2.4.22 kernel.
> 
> Merge the promise driver from later 2.4.x kernels to 2.4.18 and recompile? 
> 
> -- Pasi Kärkkäinen
>        
>                                    ^
>                                 .     .
>                                  Linux
>                               /    -    \
>                              Choice.of.the
>                            .Next.Generation.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

