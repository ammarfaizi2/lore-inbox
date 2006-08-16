Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWHPQ3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWHPQ3B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWHPQ3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:29:01 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:28734 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751088AbWHPQ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:29:00 -0400
Subject: Re: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060816155314.GA9682@suse.de>
References: <20060816121400.GA29406@skybase> <20060816155314.GA9682@suse.de>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 16 Aug 2006 18:28:56 +0200
Message-Id: <1155745736.5865.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 08:53 -0700, Greg KH wrote:
> > Please pull from 'for-linus' branch of
> > 
> > 	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus
> > 
> > to receive the following updates:
> > 
> >  arch/s390/appldata/appldata_base.c |    2 
> >  arch/s390/mm/init.c                |    6 +-
> >  drivers/s390/block/dasd.c          |    2 
> >  drivers/s390/block/dasd_devmap.c   |   84 +++++++++++++++++--------------------
> >  drivers/s390/block/dasd_eckd.c     |    8 +--
> >  drivers/s390/block/xpram.c         |   25 -----------
> >  drivers/s390/char/tape_class.c     |    2 
> >  drivers/s390/cio/device_fsm.c      |    1 
> >  drivers/s390/cio/device_ops.c      |    3 +
> >  9 files changed, 55 insertions(+), 78 deletions(-)
> 
> Hm, I got:
>  arch/s390/appldata/appldata_base.c |    2 -
>  arch/s390/mm/init.c                |    6 +--
>  drivers/s390/block/dasd.c          |    2 -
>  drivers/s390/block/dasd_devmap.c   |   84 +++++++++++++++++-------------------
>  drivers/s390/block/dasd_eckd.c     |    8 ++-
>  drivers/s390/block/xpram.c         |   25 -----------
>  6 files changed, 50 insertions(+), 77 deletions(-)
> 
> instead when pulling.  I've pushed out my tree so you can see what is missing.

That is strange. Just tested it again and I get:

Fast forward
 arch/s390/appldata/appldata_base.c |    2 -
 arch/s390/mm/init.c                |    6 +--
 drivers/s390/block/dasd.c          |    2 -
 drivers/s390/block/dasd_devmap.c   |   84 +++++++++++++++++-------------------
 drivers/s390/block/dasd_eckd.c     |    8 ++-
 drivers/s390/block/xpram.c         |   25 -----------
 drivers/s390/char/tape_class.c     |    2 -
 drivers/s390/cio/device_fsm.c      |    1
 drivers/s390/cio/device_ops.c      |    3 +
 9 files changed, 55 insertions(+), 78 deletions(-)

Do you keep a local copy of the git390 tree on you harddrive ?

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


