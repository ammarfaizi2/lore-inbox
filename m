Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314031AbSDQNFv>; Wed, 17 Apr 2002 09:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314038AbSDQNFu>; Wed, 17 Apr 2002 09:05:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29452 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314031AbSDQNFt>;
	Wed, 17 Apr 2002 09:05:49 -0400
Date: Wed, 17 Apr 2002 15:05:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@suse.de>, Helge Hafting <helgehaf@aitel.hist.no>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020417130536.GH800@suse.de>
In-Reply-To: <20020415125606.GR12608@suse.de> <02db01c1e498$7180c170$58dc703f@bnscorp.com> <20020416102510.GI17043@suse.de> <3CBD2527.EB976895@aitel.hist.no> <20020417150153.J32185@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17 2002, Dave Jones wrote:
> On Wed, Apr 17, 2002 at 09:32:55AM +0200, Helge Hafting wrote:
>  > I tried it.  It had to run as root to get permission to read.
>  > Then it hung the machine - caps & scroll lock blinking.
>  > 
>  > I can retry it without X (and fs'es remounted r/o) _if_ the
>  > resulting crash may help with debugging.
> 
> The blinking LEDs indicate you oopsed. Try it without X and you
> should see an oops that when decoded may be useful for Jens / Martin.

This bug has been fixed in the latest patches, it's the 'ar was on
stack, don't return to pool' bug.

-- 
Jens Axboe

