Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRHKP36>; Sat, 11 Aug 2001 11:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268206AbRHKP3t>; Sat, 11 Aug 2001 11:29:49 -0400
Received: from fepF.post.tele.dk ([195.41.46.135]:40617 "EHLO
	fepF.post.tele.dk") by vger.kernel.org with ESMTP
	id <S266864AbRHKP3i>; Sat, 11 Aug 2001 11:29:38 -0400
Date: Sat, 11 Aug 2001 17:32:20 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
Message-ID: <20010811173220.B1721@suse.de>
In-Reply-To: <15218.61869.424038.30544@pizda.ninka.net> <20010809163531.D1575@sventech.com> <slrn9n71kn.28q.kraxel@bytesex.org> <20010810.145836.41632779.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010810.145836.41632779.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10 2001, David S. Miller wrote:
> 
>    I'm using the patch below (pulled out of Jens Axboe's bio
>    patches, i386 only).
> 
> Are you sure you aren't missing anything in this patch?  For example,
> one can't use the patch you've provided for 64-bit DMA unless the
> dma_addr_t type is made larger.

The dma_addr_high_t was dumped along with pci_map_page_high etc, on your
request in fact :-). So all that is there currently is highmem capable
32-bit DMA stuff.

-- 
Jens Axboe

