Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285154AbRLMUUx>; Thu, 13 Dec 2001 15:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbRLMUUn>; Thu, 13 Dec 2001 15:20:43 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:9488 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S285154AbRLMUUe>;
	Thu, 13 Dec 2001 15:20:34 -0500
Message-Id: <200112132015.fBDKFig09255@aslan.scsiguy.com>
To: Steve Lord <lord@sgi.com>
cc: Jens Axboe <axboe@suse.de>, LBJM <LB33JM16@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping 
In-Reply-To: Your message of "13 Dec 2001 14:10:20 CST."
             <1008274220.22093.3.camel@jen.americas.sgi.com> 
Date: Thu, 13 Dec 2001 13:15:44 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And this is the scb:
>0xc7f945b0 c7f90040 c7f943dc 00000000 00000000   @.yG\CyG........
>0xc7f945c0 c7f945f0 c7f5e000 c7fb0800 00000000   pEyG.`uG..{G....
>0xc7f945d0 c7bd38c0 c7bd3900 c530c000 0530c008   @8=G.9=G.@0E.@0.
>0xc7f945e0 00000080 c7f90140 c7f94478 00000000   ....@.yGxDyG....
>0xc7f945f0 00000000 c7f94554 c7f58000 c7fb0800   ....TEyG..uG..{G
>0xc7f94600 00004000 c7bd38a0 c7bd3900 c530c400   .@.. 8=G.9=G.D0E
>0xc7f94610 0530c408 00000080 c7f90080 c7f94478   .D0.......yGxDyG
>0xc7f94620 00000000 c7f9464c c7f94a00 c7f59c00   ....LFyG.JyG..uG
>
>I have the system in a debugger and can look at memory for you
>if you want.

I'd like to know the value of scb->io_ctx->use_sg.

--
Justin
