Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129620AbRBHD2b>; Wed, 7 Feb 2001 22:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRBHD2V>; Wed, 7 Feb 2001 22:28:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49930 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129620AbRBHD2L>;
	Wed, 7 Feb 2001 22:28:11 -0500
Date: Thu, 8 Feb 2001 04:28:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: aacraid 2.4.0 kernel
Message-ID: <20010208042806.J27027@suse.de>
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9CA3@ausxmrr501.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9CA3@ausxmrr501.us.dell.com>; from Matt_Domsch@Dell.com on Wed, Feb 07, 2001 at 09:24:00PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07 2001, Matt_Domsch@Dell.com wrote:
> > I haven't seen this driver, but if it uses the SCSI layer instead
> > of being a "pure" block driver then I can see a slight problem
> > in that currently only understand max sg entry limits and not
> > total request sizes. I would rather fix this limitation then, and
> > would also be interested to know if any of the (older) SCSI drivers
> > have such limitations too.
> 
> Yes, it's a SCSI driver, not a block driver.  Adaptec thought it prudent to
> try to fix this in their driver rather than try to change the SCSI layer in
> 2.4.x just now.  They expected it would be more difficult getting such a
> change through validation and into the kernel in a timely manner.

The changes are going to be really small and obvious. Which I bet
the driver changes won't :-). And as I said, if other drivers have
this limitation too then we need to do it anyway.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
