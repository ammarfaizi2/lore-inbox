Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135346AbRDZMMQ>; Thu, 26 Apr 2001 08:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135363AbRDZMMH>; Thu, 26 Apr 2001 08:12:07 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:48002 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S135346AbRDZMLr>;
	Thu, 26 Apr 2001 08:11:47 -0400
Date: Thu, 26 Apr 2001 08:11:09 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 4-order allocation failed
In-Reply-To: <Pine.LNX.4.10.10104252238590.3810-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0104260809180.6221-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestion. but where to get pre-2.4.4 kernel? when I
looked into the kernel traffic mail list, peoples are talking about 2.4.4,
but i checked kernel.org, the lastest one i found is 2.4.3

regards,

Alex


On Wed, 25 Apr 2001, Mark Hahn wrote:

> > I am running linux-2.4.3 on a Dell dual PIII machine with 128M memory.
>
> 2.4.3 has many known flaws; why not try a pre-2.4.4 kernel?
>
> > __alloc_pages: 4-order allocation failed.
>
> these happen when someone tries to allocate large contiguous blocks.
>
> > and sometime the system will crash. I looked into the memory info,
> > there still has some free physical memory (20M) left and swap space is
> > almost not in use. (250M swap)
>
> your ram is fragmented; it's the contiguity that is causing the failure.
>
> > I didn't have this problem when I ran 2.4.0 (I even didn't see it on
> > 2.4.2) could anybody tell me what's wrong or where should I look into this
> > problem?
>
> you can simply perturb ram (flush, etc), or use a newer kernel.
>

-- 
 Feng Xian
     .-.
     /v\    L   I   N   U   X
    // \\
   /(   )\
    ^^-^^

