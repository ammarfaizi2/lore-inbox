Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271484AbRHPFuY>; Thu, 16 Aug 2001 01:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271485AbRHPFuO>; Thu, 16 Aug 2001 01:50:14 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:55561 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S271484AbRHPFuD>; Thu, 16 Aug 2001 01:50:03 -0400
Date: Thu, 16 Aug 2001 07:52:27 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010816075227.G4352@suse.de>
In-Reply-To: <20010815140740.A4352@suse.de> <20010815.053524.48804759.davem@redhat.com> <20010815151052.C4352@suse.de> <20010815.070204.39155321.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010815.070204.39155321.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 15 Aug 2001 15:10:52 +0200
> 
>    On Wed, Aug 15 2001, David S. Miller wrote:
>    >    The only truly problematic area is the alt_address thing.
>    >    It is would be a nice thing to rip this eyesore out of the scsi
>    >    layer anyways.
>    
>    The SCSI issue was exactly what was on my mind, and is indeed the reason
>    why I didn't go all the way and did a complete conversion there. The
>    SCSI layer is _not_ very clean in this regard, didn't exactly enjoy this
>    part of the work...
>    
> I just took a quick look at this, and I think I can make this
> alt_address thing into a scsi-layer-specific mechanism and
> thus be able to safely remove it from struct scatterlist.
> 
> Would you like me to whip up such a set of changes?  I'll be
> more than happy to work on it.

Yes please, that'd be great.

-- 
Jens Axboe

