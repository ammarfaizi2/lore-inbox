Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314242AbSDRGN5>; Thu, 18 Apr 2002 02:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSDRGN4>; Thu, 18 Apr 2002 02:13:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314242AbSDRGN4>;
	Thu, 18 Apr 2002 02:13:56 -0400
Date: Thu, 18 Apr 2002 08:12:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Dave Jones <davej@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.5.8-dj1 reading /proc/ide/.../identify
Message-ID: <20020418061209.GE858@suse.de>
In-Reply-To: <02ac01c1e666$95ddac70$02c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17 2002, Adam Kropelin wrote:
> The following oops is reproducable on 2.5.8-dj1 here.
> 
> cat /proc/ide/ide0/hda/identify a few times and *bang*.
> 
> The system usually takes one more command after the oops,
> then locks solid. The oops never makes it to syslog.

Problem has been solved in later kernels. Fix is in the patch I just
sent to you in the other thread, the archives should also hold a message
from me explaining what the problem is and how to fix it (see static ar,
return to pool, ATA_AR_RETURN/ATA_AR_POOL).

-- 
Jens Axboe

