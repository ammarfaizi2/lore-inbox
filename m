Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTI3MVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTI3MVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:21:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57828 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261380AbTI3MVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:21:42 -0400
Date: Tue, 30 Sep 2003 14:21:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930122137.GN2908@suse.de>
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F797316.2010401@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30 2003, Andreas Steinmetz wrote:
> Jens Axboe wrote:
> >
> >I think I do.
> >
> >
> >>In order to use kernel interfaces you _need_ to include kernel include
> >>files.
> >
> >
> >False. You need to include the glibc kernel headers.
> >
> Then please tell me why PPPIOCNEWUNIT is only defined in linux/if_ppp.h 
> and not net/if_ppp.h which is still true for glibc-2.3.2. And please 
> don't tell me to ask the glibc folks. There are inconsistencies between 
> kernel headers and userland headers which force the inclusion of kernel 
> headers in userland applications.

I will tell you to talk to the glibc folks, because that's where your
problem is.

-- 
Jens Axboe

