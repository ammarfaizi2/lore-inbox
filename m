Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTI3MbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTI3MbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:31:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45799 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261411AbTI3Maw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:30:52 -0400
Date: Tue, 30 Sep 2003 14:30:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930123051.GP2908@suse.de>
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de> <20030930122137.GN2908@suse.de> <3F797690.4020706@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F797690.4020706@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30 2003, Andreas Steinmetz wrote:
> Jens Axboe wrote:
> >On Tue, Sep 30 2003, Andreas Steinmetz wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>I think I do.
> >>>
> >>>
> >>>
> >>>>In order to use kernel interfaces you _need_ to include kernel include
> >>>>files.
> >>>
> >>>
> >>>False. You need to include the glibc kernel headers.
> >>>
> >>
> >>Then please tell me why PPPIOCNEWUNIT is only defined in linux/if_ppp.h 
> >>and not net/if_ppp.h which is still true for glibc-2.3.2. And please 
> >>don't tell me to ask the glibc folks. There are inconsistencies between 
> >>kernel headers and userland headers which force the inclusion of kernel 
> >>headers in userland applications.
> >
> >
> >I will tell you to talk to the glibc folks, because that's where your
> >problem is.
> >
> I don't think so. If ioctls are introduced in the kernel the kernel 
> people should propagate these to the glibc people. I don't think it is 
> the task of userland developers.

It's not solely their responsibility, I agree. Just see my mail to
davem. Did you tell the glibc folks about the missing ioctls?

> But then this is my point of view and I don't think it necessary to 
> discuss this further.

Agree. It's long been established that kernel headers aren't always
suitable for user space inclusion, this discussion doesn't change that
fact.

-- 
Jens Axboe

