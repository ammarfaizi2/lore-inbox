Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271946AbRHVGoH>; Wed, 22 Aug 2001 02:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271947AbRHVGn5>; Wed, 22 Aug 2001 02:43:57 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:31243 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S271946AbRHVGns>; Wed, 22 Aug 2001 02:43:48 -0400
Date: Wed, 22 Aug 2001 08:46:49 +0200
From: Jens Axboe <axboe@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
Message-ID: <20010822084649.F604@suse.de>
In-Reply-To: <20010821195525.05d0f8bf.skraw@ithnet.com> <200108211833.f7LIXHY96688@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108211833.f7LIXHY96688@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21 2001, Justin T. Gibbs wrote:
> [...] Unfortunately the x86 port
> doesn't support passing large dma addresses to drivers so bouncing is required
> in order to do PAE.

With the PCI64 + highmem no-bounce patches it does, so feel free to
convert aic7xxx to the newpci64 API :-)

-- 
Jens Axboe

