Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269795AbRHTWz4>; Mon, 20 Aug 2001 18:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269781AbRHTWzq>; Mon, 20 Aug 2001 18:55:46 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:60178 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S269810AbRHTWzi>; Mon, 20 Aug 2001 18:55:38 -0400
Date: Tue, 21 Aug 2001 00:55:46 +0200
From: Cliff Albert <cliff@oisec.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010821005546.A29315@oisec.net>
In-Reply-To: <20010820230909.A28422@oisec.net> <200108202145.f7KLjsY43284@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108202145.f7KLjsY43284@aslan.scsiguy.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 03:45:54PM -0600, Justin T. Gibbs wrote:

> >> And here they are, the dmesg is my bootup dmesg with the devices drivers 
> >> and stuff, and the second dmesg is the actual errors (verbose turned on)
> >
> >Some more research pointed out that the errors/lock of the scsi bus always 
> >appears about 20 seconds after kernel load when i cold boot the machine. 
> >With a warm boot the machine gives these errors/lock at random times.
> 
> IIRC, the problem has to do with the state of the write cache in the drive.
> The cache will be in a different state after power-on as compared to
> after some amount of activity.

Well i still suspect the broken firmware of the disk isn't the only cause of
these errors as i've heard more people heaving problems with the new aic7xxx
driver on multiple platforms with different discs, but having the same error
messages as i've experienced. I'll get together with those people and will
try to collect some more debugging info for your needs.

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
