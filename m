Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279884AbRKHOkI>; Thu, 8 Nov 2001 09:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280015AbRKHOj6>; Thu, 8 Nov 2001 09:39:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5905 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S279884AbRKHOjs>;
	Thu, 8 Nov 2001 09:39:48 -0500
Date: Thu, 8 Nov 2001 15:39:38 +0100
From: Jens Axboe <axboe@suse.de>
To: "White, Charles" <Charles.White@compaq.com>
Cc: "Alan Cox (E-mail)" <alan@redhat.com>, linux-kernel@vger.kernel.org,
        "Cameron, Steve" <Steve.Cameron@compaq.com>
Subject: Re: [PATCH] Update to the Compaq cpqarray driver for 2.4.14 kernel tree ...
Message-ID: <20011108153938.M27652@suse.de>
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB0EA3FF@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2C35BB97A9A384CA2816D24522A53BB0EA3FF@cceexc18.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08 2001, White, Charles wrote:
> The patch is to big to include in the e-mail... 
> This is version 2.4.20 of the cpqarray driver... 
> 
> This changes the driver to use the new 2.4 kernel PCI APIs. This changes
> how all our cards are detected. 
> This adds some new IOCTLs for adding/deleting volumes while the driver
> is online. 
> It have added code to request/release the io-region used by our cards.
> 
> It has a small fix to the flush on unload.  
> 
> ftp://ftp.compaq.com/pub/products/drivers/linux/released/cpqarray/cpqarr
> ay_2.4.20D_for_2.4.14.patch

It's backing out the recent changes etc.

-- 
Jens Axboe

