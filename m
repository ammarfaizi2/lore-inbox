Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271142AbRHOLPs>; Wed, 15 Aug 2001 07:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271143AbRHOLP2>; Wed, 15 Aug 2001 07:15:28 -0400
Received: from fe010.worldonline.dk ([212.54.64.195]:50181 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S271142AbRHOLPV>; Wed, 15 Aug 2001 07:15:21 -0400
Date: Wed, 15 Aug 2001 13:13:35 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010815131335.H545@suse.de>
In-Reply-To: <20010815095018.B545@suse.de> <20010815.021133.71088933.davem@redhat.com> <20010815112621.F545@suse.de> <20010815.032218.55508716.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010815.032218.55508716.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 15 Aug 2001 11:26:21 +0200
>    
>    Ok, here's an updated version. Maybe modulo the struct scatterlist
>    changes, I'd like to see this included in 2.4.x soonish. Or at least the
>    interface we agree on -- it'll make my life easier at least. And finally
>    provide driver authors with something not quite as stupid as struct
>    scatterlist.
> 
> Jens, have a look at the patch I have below.  What do you
> think about it?  Specifically the set of interfaces.

Looks fine to me, exactly the interface I've used/wanted. But you want
to add the extra page/offset to the existing scatterlist, and not scrap
that one completely?

> we can.   The x86 versions of the asm/pci.h and
> asm/scatterlist.h bits are pretty mindless and left as
> an exercise to the reader :-)

:-)

-- 
Jens Axboe

