Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266641AbUAOLwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 06:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266759AbUAOLwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 06:52:22 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:61321 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S266641AbUAOLtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 06:49:25 -0500
Date: Thu, 15 Jan 2004 13:49:22 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Cheng Huang <cheng@cs.wustl.edu>
Cc: linux-kernel@vger.kernel.org, cheng@cse.wustl.edu
Subject: Re: Hang with Promise Ultra100 TX2 (kernel 2.4.18)
Message-ID: <20040115114922.GI1254@edu.joroinen.fi>
References: <Pine.GSO.4.58.0401150308350.1943@siesta.cs.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.58.0401150308350.1943@siesta.cs.wustl.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
