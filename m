Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWGUM64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWGUM64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 08:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWGUM64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 08:58:56 -0400
Received: from outmx018.isp.belgacom.be ([195.238.4.117]:65422 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750700AbWGUM6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 08:58:55 -0400
Subject: Re: [PATCH] block: Conversions from kmalloc+memset to k(z|c)alloc
From: Panagiotis Issaris <takis@gna.org>
To: Jens Axboe <axboe@suse.de>
Cc: takis@issaris.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060721123827.GA26368@suse.de>
References: <20060721113210.GB11822@issaris.org>
	 <20060721121352.GB25045@suse.de> <1153485124.9489.37.camel@hemera>
	 <20060721123827.GA26368@suse.de>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 14:58:42 +0200
Message-Id: <1153486723.9489.46.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On vr, 2006-07-21 at 14:38 +0200, Jens Axboe wrote:
> On Fri, Jul 21 2006, Panagiotis Issaris wrote:
> > Hi,
> > 
> > On vr, 2006-07-21 at 14:13 +0200, Jens Axboe wrote:
> > > On Fri, Jul 21 2006, takis@issaris.org wrote:
> > > > From: Panagiotis Issaris <takis@issaris.org>
> > > > 
> > > > block: Conversions from kmalloc+memset to kzalloc
> > > 
> > > They are already done in the block git repo.
> > Weird, I had even checked if they weren't already done:
> > http://kernel.org/git/?p=linux/kernel/git/axboe/linux-2.6-block.git;a=blob;h=102ebc2c5c34c73f8e7f76c589559ddfde0d9885;hb=82d6897fefca6206bca7153805b4c5359ce97fc4;f=block/cfq-iosched.c
> > 
> > Am I looking at the wrong repos, or is it just not in sync
> > with your daily work?
> 
> It should be in the iosched branch.
Ah... branches! Forgot about those :) So, I guess that makes it nearly 
impossible to avoid effort duplication.

Unless ofcourse, there would be a git script which would check if any of
the maintainers have changed a specific line in any of their branches.

Thanks.

With friendly regards,
Takis

