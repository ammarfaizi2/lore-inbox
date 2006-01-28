Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWA1V2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWA1V2B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 16:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWA1V2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 16:28:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39279 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750763AbWA1V2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 16:28:00 -0500
Date: Sat, 28 Jan 2006 22:28:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Libin Varghese <libinv@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: I/O Scheduling
Message-ID: <20060128212858.GB13084@suse.de>
References: <43DB405E.4020602@gmail.com> <20060128185453.12fcd0e6@mango.fruits.de> <1138471719.2799.20.camel@mindpipe> <20060128191814.GD9750@suse.de> <1138477478.2799.39.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138477478.2799.39.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28 2006, Lee Revell wrote:
> On Sat, 2006-01-28 at 20:18 +0100, Jens Axboe wrote:
> > On Sat, Jan 28 2006, Lee Revell wrote:
> > > On Sat, 2006-01-28 at 18:54 +0100, Florian Schmidt wrote:
> > > > 
> > > > i'm also interested in these. Especially I/O priorities per
> > > > process/task similar to scheduling priorities. It would be just
> > > > awesome to be able to give i.e. a hd recording program (or any other
> > > > data aquisition or playback program) a high I/O priority.
> > > > 
> > > 
> > > I believe it's already implemented for the CFQ scheduler only, but the
> > > patch does not seem to be in mainline.
> > > 
> > > Jens, what's the status of this?
> > 
> > It's merged, since 2.6.13.
> > 
> 
> OK, I was looking at an old patch, the API must have changed.  Can it be
> controlled per thread, independently of the nice value/RT priority?

Yes it can, get a recent util-linux and look at ionice (there's a man
page, too).

-- 
Jens Axboe

