Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281643AbRKPXRE>; Fri, 16 Nov 2001 18:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281644AbRKPXQz>; Fri, 16 Nov 2001 18:16:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5394 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281643AbRKPXQp>;
	Fri, 16 Nov 2001 18:16:45 -0500
Date: Sat, 17 Nov 2001 00:16:27 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [patch] block-highmem-all-18
Message-ID: <20011117001626.H11826@suse.de>
In-Reply-To: <20011116193057.O1825-100000@gerard> <20011116.135409.118971851.davem@redhat.com> <20011116234555.C11826@suse.de> <20011116.150516.105434270.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011116.150516.105434270.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Fri, 16 Nov 2001 23:45:55 +0100
>    
>    it was introduced before we supported full 64-bit
>    dma, and should now just be called can_highmem_io or something
>    similar.
> 
> I encourage you to make this change :-)

Change has been made, I'll roll out -18b once I flush a few more pending
changes (notably the ULL -> pfn lastdataend change so we can loose
page_to_phys) :-)

-- 
Jens Axboe

