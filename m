Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbSIYRSO>; Wed, 25 Sep 2002 13:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbSIYRSO>; Wed, 25 Sep 2002 13:18:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30093 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262033AbSIYRSN>;
	Wed, 25 Sep 2002 13:18:13 -0400
Date: Wed, 25 Sep 2002 19:23:11 +0200
From: Jens Axboe <axboe@suse.de>
To: "Neulinger, Nathan" <nneul@umr.edu>
Cc: Linux-kernel@vger.kernel.org
Subject: Re: tons of "Warning - running *really* short on DMA buffers" messages - 2.4.19, aic7xxx
Message-ID: <20020925172311.GI15479@suse.de>
References: <2B45A04D8F18D947A400F0850CE3B53B061692@umr-mail7.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2B45A04D8F18D947A400F0850CE3B53B061692@umr-mail7.umr.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25 2002, Neulinger, Nathan wrote:
> Is there anything that can be done about these? Running 2.4.19 on a
> piii-800, 512MB, scsi hardware raid.
> 
> Seeing tons of these messages (flooding syslogs) whenever I do much I/O
> to the drives.
> 
> Is there any vm tuning that can be done?

These are "fixed" in 2.4.20-pre so you should try that, if for nothing
else than testing that it works well. The old setup is just fragile.

-- 
Jens Axboe

