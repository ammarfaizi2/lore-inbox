Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282917AbRLGQpU>; Fri, 7 Dec 2001 11:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLGQoy>; Fri, 7 Dec 2001 11:44:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1033 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282907AbRLGQoj>;
	Fri, 7 Dec 2001 11:44:39 -0500
Date: Fri, 7 Dec 2001 17:44:31 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Oops on 2.5.1-pre6 doing mkreiserfs on loop device
Message-ID: <20011207164431.GA27629@suse.de>
In-Reply-To: <20011206233759.A173@earthlink.net> <20011207144836.GF12017@suse.de> <20011207145431.GI12017@suse.de> <20011207150058.GJ12017@suse.de> <20011207114046.A152@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011207114046.A152@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07 2001, rwhron@earthlink.net wrote:
> On Fri, Dec 07, 2001 at 04:00:58PM +0100, Jens Axboe wrote:
> > > argh, that should read 'i' and not '0' of course.
> > 
> > Updated patch follows.
> 
> I got a very similar oops during mkreiserfs /dev/loop0 on this
> HIGHMEM machine.

loop can't be trusted yet. btw, updated patch on kernel.org,
/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre6

-- 
Jens Axboe

