Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWHDNiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWHDNiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161212AbWHDNiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:38:55 -0400
Received: from brick.kernel.dk ([62.242.22.158]:10275 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161211AbWHDNiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:38:55 -0400
Date: Fri, 4 Aug 2006 15:39:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nate.diller@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] [1/3] add elv_extended_request call to iosched API
Message-ID: <20060804133938.GX20624@suse.de>
References: <5c49b0ed0608031911id21b112t7f0c350a7f10a99@mail.gmail.com> <20060804052031.GA4717@suse.de> <20060803224519.dd9bf38e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803224519.dd9bf38e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03 2006, Andrew Morton wrote:
> On Fri, 4 Aug 2006 07:20:32 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > On Thu, Aug 03 2006, Nate Diller wrote:
> > > the Elevator iosched would prefer to be unconditionally notified of a
> > > merge, but the current API calls only one 'merge' notifier
> > > (elv_merge_requests or elv_merged_requests), even if both front and
> > > back merges happened.
> > > 
> > > elv_extended_request satisfies this requirement in conjunction with
> > > elv_merge_requests.
> > 
> > Ok, I suppose. But please rebase patches against the 'block' git branch,
> > there are extensive changes in this area.
> > 
> 
> argh, the great (but partial ;)) renaming bites again.
> 
> A suitable patch to merge against is
> http://www.zip.com.au/~akpm/linux/patches/stuff/git-block.patch

not so much the renaming (that's easy enough), but the elevator core
parts changed in some areas.

-- 
Jens Axboe

