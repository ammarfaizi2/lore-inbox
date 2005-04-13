Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVDMHpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVDMHpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 03:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVDMHpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 03:45:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58051 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262541AbVDMHpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 03:45:13 -0400
Date: Wed, 13 Apr 2005 09:45:10 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] new fifo I/O elevator that really does nothing at all
Message-ID: <20050413074509.GF20044@suse.de>
References: <7A4826DE8867D411BAB8009027AE9EB91DB47626@scsmsx401.amr.corp.intel.com> <200504121758.j3CHwQg11702@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504121758.j3CHwQg11702@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12 2005, Chen, Kenneth W wrote:
> Chen, Kenneth W wrote on Tuesday, April 05, 2005 5:13 PM
> > Jens Axboe wrote on Tuesday, April 05, 2005 7:54 AM
> > > On Tue, Mar 29 2005, Chen, Kenneth W wrote:
> > > > Jens Axboe wrote on Tuesday, March 29, 2005 12:04 PM
> > > > > No such promise was ever made, noop just means it does 'basically
> > > > > nothing'. It never meant FIFO in anyway, we cannot break the semantics
> > > > > of block layer commands just for the hell of it.
> > > >
> > > > Acknowledged and understood, will try your patch shortly.
> > >
> > > Did you test it?
> >
> > Experiment is in the queue, should have a result in a day or two.
> 
> 
> Jens, your patch works!  We are seeing a little bit increase in

Super.

> indirect branch calls with your patch where our patch tries to remove
> elevator_merge_fn() completely.  But the difference is all within
> noise range.

Yeah that is expected. Thanks for testing!

> If there is no other issues (I don't see any), we would like to see
> this patch merged upstream.  Thanks.

I will pass it along.

-- 
Jens Axboe

