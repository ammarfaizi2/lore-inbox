Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283549AbRK3Hmx>; Fri, 30 Nov 2001 02:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283552AbRK3Hmi>; Fri, 30 Nov 2001 02:42:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25362 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283545AbRK3Hl5>;
	Fri, 30 Nov 2001 02:41:57 -0500
Date: Fri, 30 Nov 2001 08:41:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.1-pre4: drivers/scsi/scsi_lib.c
Message-ID: <20011130084132.I16796@suse.de>
In-Reply-To: <3C06F218.4050907@si.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C06F218.4050907@si.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Frank Davis wrote:
> Hello,
>    I haven't seen this posted yet, so here it is..
> During a 'make bzImage' for 2.5.1-pre4, I received the following error:
> 
> scsi_lib.c: In function 'scsi_io_completion'
> scsi_lib.c:585: parse error before 'good_sectors'
> ..Error 1, in drivers/scsi
> 
> The following patch does the trick....missing comma

I had to guess the location since you didn't include the patch, but
that's ok :-)

-- 
Jens Axboe

