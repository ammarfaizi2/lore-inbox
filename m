Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbVJXG3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbVJXG3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 02:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVJXG3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 02:29:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7965 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751026AbVJXG3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 02:29:04 -0400
Date: Mon, 24 Oct 2005 08:29:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-block-2.6:generic-dispatch] kill max_back_kb handling
Message-ID: <20051024062955.GF2811@suse.de>
References: <20051024032731.GA14202@htj.dyndns.org> <20051024033007.GB14202@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024033007.GB14202@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24 2005, Tejun Heo wrote:
> On Mon, Oct 24, 2005 at 12:27:31PM +0900, Tejun Heo wrote:
> >  Hello, Jens.
> > 
> >  This patch kills max_back_kb handling from elv_dispatch_sort() and
> > kills max_back_kb field from struct request_queue.  The implementation
> > was broken (subtracted bytes from blocks) and the usefulness of the
> 
>  Oops, above line is wrong.  Can you please kill the sentence about
> breakage when committing?  Thanks.

Sure, committed.

-- 
Jens Axboe

