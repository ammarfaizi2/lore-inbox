Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSJ1QFb>; Mon, 28 Oct 2002 11:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSJ1QFb>; Mon, 28 Oct 2002 11:05:31 -0500
Received: from rth.ninka.net ([216.101.162.244]:22702 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261310AbSJ1QFa>;
	Mon, 28 Oct 2002 11:05:30 -0500
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
From: "David S. Miller" <davem@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <20021028155401.GI2937@suse.de>
References: <20021018155650.GJ15494@suse.de>
	<20021028.043507.104714061.davem@redhat.com> <20021028124240.GC872@suse.de>
	<1035816048.8970.1.camel@rth.ninka.net> <20021028150832.GF2937@suse.de>
	<1035821017.9282.7.camel@rth.ninka.net>  <20021028155401.GI2937@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 08:25:10 -0800
Message-Id: <1035822310.8970.9.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 07:54, Jens Axboe wrote:
> I agree then. I will remove references to flush_dcache_page() in
> bio_map_user() and bio_unmap_user(), and we'll just unconditionally do
> flush_dcache_page() on every page mapped in get_user_pages(). That
> sounds far better to me. Do you really expect users of get_user_pages()
> to get this right (remember, we are often talking about device drivers
> :-). I sure am not :)

I have no expectations whatsoever :-)
I totally agree with you.

