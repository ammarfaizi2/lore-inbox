Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285390AbRLNPRg>; Fri, 14 Dec 2001 10:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285392AbRLNPR1>; Fri, 14 Dec 2001 10:17:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46098 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285390AbRLNPRV>;
	Fri, 14 Dec 2001 10:17:21 -0500
Date: Fri, 14 Dec 2001 16:16:42 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: lord@sgi.com, gibbs@scsiguy.com, LB33JM16@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
Message-ID: <20011214151642.GE30529@suse.de>
In-Reply-To: <200112132048.fBDKmog10485@aslan.scsiguy.com> <1008277112.22093.7.camel@jen.americas.sgi.com> <1008278244.22208.12.camel@jen.americas.sgi.com> <20011213.132734.38711065.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213.132734.38711065.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13 2001, David S. Miller wrote:
>    From: Steve Lord <lord@sgi.com>
>    Date: 13 Dec 2001 15:17:24 -0600
>    
>    OK, I can confirm this fixes it for me. A side not for Jens, this still
>    pushes the scsi layer into those DMA shortage messages:
> 
> Yes we know, once Jens finishes up his work on using a mempool for the
> scatterlist allocations this problem will dissapate.

Indeed, the below patch should fix it right up and also has all of
David's fixes and merging cleanups.

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre11/bio-pre11-5.bz2

-- 
Jens Axboe

