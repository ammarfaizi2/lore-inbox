Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285053AbRLFIk0>; Thu, 6 Dec 2001 03:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285050AbRLFIkQ>; Thu, 6 Dec 2001 03:40:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52745 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285053AbRLFIkE>;
	Thu, 6 Dec 2001 03:40:04 -0500
Date: Thu, 6 Dec 2001 09:39:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Yusuf Goolamabbas <yusufg@outblaze.com>
Cc: ext3-users@redhat.com, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: 2.4.17-pre2+ext3-0.9.16+anton's cache aligned smp
Message-ID: <20011206083943.GH25244@suse.de>
In-Reply-To: <3C0B12C5.F8F05016@zip.com.au> <1007595740.818.2.camel@phantasy> <20011206163056.A15550@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011206163056.A15550@outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06 2001, Yusuf Goolamabbas wrote:
> I'm also trying to see if I can get test with Jen Axboe's blk-highmem
> patch, It applies cleanly to 2.4.17-pre2+ext3-0.9.16 but I can't seem to
> get CONFIG_HIGHIO configured via make {old,menu}config. Any gurus want
> to take a look. I'd really like to reduce usage of bounce buffers.

There was a config bug, please just use Andrea's -aa kernels they have
that fixed.

> Also, on #kernelnewbies, Andre Hedrick claims blk-highmem eats your
> data. That didn't occur last time I tested it. I thought it was rock
> solid and ready for inclusion. Anybody confirm/deny ?

Andre claims a lot of things.

-- 
Jens Axboe

