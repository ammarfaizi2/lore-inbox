Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUEFGnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUEFGnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 02:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUEFGnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 02:43:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60560 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261672AbUEFGnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 02:43:10 -0400
Date: Thu, 6 May 2004 08:43:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
Message-ID: <20040506064301.GC10069@suse.de>
References: <200405052212.i45MC0F28121@unix-os.sc.intel.com> <20040506062028.GB10069@suse.de> <20040505233426.704926da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505233426.704926da.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Do you have any numbers at all for this? I'd say these calculations are
> >  severly into the noise area when submitting io.
> 
> The difference will not be measurable, but I think the patch makes sense
> regardless of what the numbers say.

Humm dunno, I'd rather save the sizeof(int) * 2.

> I uninlined the new function though.  Two callsites, both slowpath...

The more reason not to make it static :). I don't feel too strongly
about it though.

-- 
Jens Axboe

