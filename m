Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284204AbRLGReU>; Fri, 7 Dec 2001 12:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLGReK>; Fri, 7 Dec 2001 12:34:10 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:5111 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S284204AbRLGRd6>; Fri, 7 Dec 2001 12:33:58 -0500
Date: Fri, 7 Dec 2001 12:36:50 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Oops on 2.5.1-pre6 doing mkreiserfs on loop device
Message-ID: <20011207123650.A118@earthlink.net>
In-Reply-To: <20011206233759.A173@earthlink.net> <20011207144836.GF12017@suse.de> <20011207145431.GI12017@suse.de> <20011207150058.GJ12017@suse.de> <20011207114046.A152@earthlink.net> <20011207164431.GA27629@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207164431.GA27629@suse.de>; from axboe@suse.de on Fri, Dec 07, 2001 at 05:44:31PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 05:44:31PM +0100, Jens Axboe wrote:
> > I got a very similar oops during mkreiserfs /dev/loop0 on this
> > HIGHMEM machine.
> 
> loop can't be trusted yet. btw, updated patch on kernel.org,
> /pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre6

It's a lot better with bio-pre6-2. :) No more oops.  mkreiserfs,
mount, cpio into the loop filesystem work now.  sync will hang on 
/dev/loop0 though.

It's amazing what you get done in one day.
-- 
Randy Hron

