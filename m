Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281249AbRKMCgs>; Mon, 12 Nov 2001 21:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281052AbRKMCgd>; Mon, 12 Nov 2001 21:36:33 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:17266 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281249AbRKMCgN>; Mon, 12 Nov 2001 21:36:13 -0500
Date: Mon, 12 Nov 2001 21:36:12 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: Fwd: eepro100 pm fix (fwd)
Message-ID: <20011112213612.A16461@devserv.devel.redhat.com>
In-Reply-To: <mailman.1005569101.17579.linux-kernel2news@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <mailman.1005569101.17579.linux-kernel2news@redhat.com>; from saw@saw.sw.com.sg on Mon, Nov 12, 2001 at 03:50:03PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

The patch looks good but it does not help my case.
The eepro100 is dead after resume on my Sony PCG-Z505JE.
BTW, my difficulties started somewhere in 2.4.10 or thereabouts,
so they are probably unrelated to what Jens reported "a year ago".

-- Pete

> Path: post-office.corp.redhat.com!not-for-mail
> From: Andrey Savochkin <saw@saw.sw.com.sg>
> Newsgroups: linux-kernel
> Date: Mon, 12 Nov 2001 15:50:03 +0300
> Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
>    Andrew Morton <akpm@zip.com.au>
> To: torvalds@transmeta.com

> Linus,
> 
> Could you apply it, please?
> 
> 	Andrey
> 
> ----- Forwarded message from Jens Axboe <axboe@suse.de> -----
> 
> Date: Mon, 12 Nov 2001 13:24:53 +0100
> From: Jens Axboe <axboe@suse.de>
> To: saw@saw.sw.com.sg
> Subject: eepro100 pm fix
> Message-ID: <20011112132453.B786@suse.de>
> 
> Hi Andrey,
> 
> This patch posted by Andrew Morton makes the eepro100 actually survive a
> apm suspend and resume without totally croaking (a problem I reported
> probably a year or so ago :-). Any chance you could include it?
> 
> -- 
> Jens Axboe
