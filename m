Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSJ1Mje>; Mon, 28 Oct 2002 07:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262444AbSJ1Mje>; Mon, 28 Oct 2002 07:39:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35720 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262442AbSJ1Mjd>;
	Mon, 28 Oct 2002 07:39:33 -0500
Date: Mon, 28 Oct 2002 13:42:40 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
Message-ID: <20021028124240.GC872@suse.de>
References: <20021018155650.GJ15494@suse.de> <20021028.043507.104714061.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028.043507.104714061.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28 2002, David S. Miller wrote:
> 
> This work reminds me that get_user_pages() (or it's callers)
> need to be doing some flush_dcache_page()

Was wondering about that. Can you tell me what it needs? And what about
bio_unmap_user(), surely that needs to flush cache as well for reads?

-- 
Jens Axboe

