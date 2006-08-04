Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWHDFTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWHDFTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWHDFTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:19:51 -0400
Received: from brick.kernel.dk ([62.242.22.158]:61261 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030235AbWHDFTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:19:50 -0400
Date: Fri, 4 Aug 2006 07:20:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [1/3] add elv_extended_request call to iosched API
Message-ID: <20060804052031.GA4717@suse.de>
References: <5c49b0ed0608031911id21b112t7f0c350a7f10a99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0608031911id21b112t7f0c350a7f10a99@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03 2006, Nate Diller wrote:
> the Elevator iosched would prefer to be unconditionally notified of a
> merge, but the current API calls only one 'merge' notifier
> (elv_merge_requests or elv_merged_requests), even if both front and
> back merges happened.
> 
> elv_extended_request satisfies this requirement in conjunction with
> elv_merge_requests.

Ok, I suppose. But please rebase patches against the 'block' git branch,
there are extensive changes in this area.

-- 
Jens Axboe

