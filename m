Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTLWSwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTLWSvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:51:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47277 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262283AbTLWStN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:49:13 -0500
Date: Tue, 23 Dec 2003 19:49:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031223184915.GA4253@suse.de>
References: <20031223165829.GF1601@suse.de> <Pine.LNX.4.44.0312231828540.972-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312231828540.972-100000@neptune.local>
X-OS: Linux 2.4.23aa1-axboe i686
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23 2003, Pascal Schmidt wrote:
> On Tue, 23 Dec 2003, Jens Axboe wrote:
> 
> > On Tue, Dec 23 2003, Jens Axboe wrote:
> > > -				rq->errors = 1;
> > > +					info->write_timeout = jiffies + ATAPI_WAIT_WRITE_BUSY;
> > > +				++rq->errors;
> > 
> > Didn't mean to change the = 1, here's an updated one.
> 
> Applied, compiled, and tested. MO drive workes just fine with the
> updated patch applied.

Great, thanks for testing.

Jens

