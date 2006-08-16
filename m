Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWHPRDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWHPRDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWHPRDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:03:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:34438 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751167AbWHPRDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:03:18 -0400
Date: Wed, 16 Aug 2006 10:02:32 -0700
From: Greg KH <gregkh@suse.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Please pull git390 'for-linus' branch
Message-ID: <20060816170232.GA27220@suse.de>
References: <20060816121400.GA29406@skybase> <20060816155314.GA9682@suse.de> <1155745736.5865.31.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155745736.5865.31.camel@localhost>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 06:28:56PM +0200, Martin Schwidefsky wrote:
> On Wed, 2006-08-16 at 08:53 -0700, Greg KH wrote:
> > > Please pull from 'for-linus' branch of
> > > 
> > > 	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus
> > > 
> > > to receive the following updates:
> > > 
> > >  arch/s390/appldata/appldata_base.c |    2 
> > >  arch/s390/mm/init.c                |    6 +-
> > >  drivers/s390/block/dasd.c          |    2 
> > >  drivers/s390/block/dasd_devmap.c   |   84 +++++++++++++++++--------------------
> > >  drivers/s390/block/dasd_eckd.c     |    8 +--
> > >  drivers/s390/block/xpram.c         |   25 -----------
> > >  drivers/s390/char/tape_class.c     |    2 
> > >  drivers/s390/cio/device_fsm.c      |    1 
> > >  drivers/s390/cio/device_ops.c      |    3 +
> > >  9 files changed, 55 insertions(+), 78 deletions(-)
> > 
> > Hm, I got:
> >  arch/s390/appldata/appldata_base.c |    2 -
> >  arch/s390/mm/init.c                |    6 +--
> >  drivers/s390/block/dasd.c          |    2 -
> >  drivers/s390/block/dasd_devmap.c   |   84 +++++++++++++++++-------------------
> >  drivers/s390/block/dasd_eckd.c     |    8 ++-
> >  drivers/s390/block/xpram.c         |   25 -----------
> >  6 files changed, 50 insertions(+), 77 deletions(-)
> > 
> > instead when pulling.  I've pushed out my tree so you can see what is missing.
> 
> That is strange. Just tested it again and I get:
> 
> Fast forward
>  arch/s390/appldata/appldata_base.c |    2 -
>  arch/s390/mm/init.c                |    6 +--
>  drivers/s390/block/dasd.c          |    2 -
>  drivers/s390/block/dasd_devmap.c   |   84 +++++++++++++++++-------------------
>  drivers/s390/block/dasd_eckd.c     |    8 ++-
>  drivers/s390/block/xpram.c         |   25 -----------
>  drivers/s390/char/tape_class.c     |    2 -
>  drivers/s390/cio/device_fsm.c      |    1
>  drivers/s390/cio/device_ops.c      |    3 +
>  9 files changed, 55 insertions(+), 78 deletions(-)
> 
> Do you keep a local copy of the git390 tree on you harddrive ?

No, what happened is that you had three changesets in your tree that I
had already pulled from last week.  Those did not show up in this
diffstat as they were already present in my tree.

So all should be fine.

thanks,

greg k-h
