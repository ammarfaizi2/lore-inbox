Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266207AbSKFXQs>; Wed, 6 Nov 2002 18:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266208AbSKFXQs>; Wed, 6 Nov 2002 18:16:48 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:15869 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S266207AbSKFXQr>;
	Wed, 6 Nov 2002 18:16:47 -0500
Date: Wed, 6 Nov 2002 18:23:22 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106232322.GB27210@www.kroptech.com>
References: <20021106041330.GA9489@www.kroptech.com> <20021106072223.GB4369@suse.de> <20021106155656.GA20403@www.kroptech.com> <20021106184508.GB897@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106184508.GB897@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 07:45:08PM +0100, Jens Axboe wrote:
> On Wed, Nov 06 2002, Adam Kropelin wrote:
> > Hard disk is sdc on onboard AIC7xxx.
> 
> Ah ok, yes on SCSI it's very easy to starve requests. There's no good
> way to control this yet, unfortunately. Please set max number of tags to
> 2-4 or so, and you should not be able to kill the burn.

Tags set to 2 or 4 seem to make no difference. I'll keep
experimenting...

> > > I'll try and reproduce that here, there's been a similar report (same
> > > oops) before. If you can just send me the dmesg output after a boot that
> > > should be fine.
> > 
> > Will do when I get home (now +9 hrs or so)...

dmesg sent privately...

--Adam
