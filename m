Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbSJ1OwH>; Mon, 28 Oct 2002 09:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbSJ1OwG>; Mon, 28 Oct 2002 09:52:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25496 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261284AbSJ1OwF>;
	Mon, 28 Oct 2002 09:52:05 -0500
Date: Mon, 28 Oct 2002 15:55:33 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
Message-ID: <20021028145533.GD2937@suse.de>
References: <20021018155650.GJ15494@suse.de> <20021028.043507.104714061.davem@redhat.com> <20021028124240.GC872@suse.de> <1035816048.8970.1.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035816048.8970.1.camel@rth.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28 2002, David S. Miller wrote:
> On Mon, 2002-10-28 at 04:42, Jens Axboe wrote:
> > > This work reminds me that get_user_pages() (or it's callers)
> > > need to be doing some flush_dcache_page()
> > 
> > Was wondering about that. Can you tell me what it needs? And what about
> > bio_unmap_user(), surely that needs to flush cache as well for reads?
> 
> Documentation/cachetlb.txt describes where flush_dcache_page is needed.
> If that doesn't describe it enough for you, that is a bug and please
> tell me what part is confusing so I may make the document better.

Didn't know about that document, will read it first.

-- 
Jens Axboe

