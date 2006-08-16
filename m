Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWHPP4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWHPP4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWHPP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:56:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:5779 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932092AbWHPP4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:56:47 -0400
Date: Wed, 16 Aug 2006 08:53:14 -0700
From: Greg KH <gregkh@suse.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Please pull git390 'for-linus' branch
Message-ID: <20060816155314.GA9682@suse.de>
References: <20060816121400.GA29406@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816121400.GA29406@skybase>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 02:14:00PM +0200, Martin Schwidefsky wrote:
> Please pull from 'for-linus' branch of
> 
> 	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus
> 
> to receive the following updates:
> 
>  arch/s390/appldata/appldata_base.c |    2 
>  arch/s390/mm/init.c                |    6 +-
>  drivers/s390/block/dasd.c          |    2 
>  drivers/s390/block/dasd_devmap.c   |   84 +++++++++++++++++--------------------
>  drivers/s390/block/dasd_eckd.c     |    8 +--
>  drivers/s390/block/xpram.c         |   25 -----------
>  drivers/s390/char/tape_class.c     |    2 
>  drivers/s390/cio/device_fsm.c      |    1 
>  drivers/s390/cio/device_ops.c      |    3 +
>  9 files changed, 55 insertions(+), 78 deletions(-)

Hm, I got:
 arch/s390/appldata/appldata_base.c |    2 -
 arch/s390/mm/init.c                |    6 +--
 drivers/s390/block/dasd.c          |    2 -
 drivers/s390/block/dasd_devmap.c   |   84 +++++++++++++++++-------------------
 drivers/s390/block/dasd_eckd.c     |    8 ++-
 drivers/s390/block/xpram.c         |   25 -----------
 6 files changed, 50 insertions(+), 77 deletions(-)

instead when pulling.  I've pushed out my tree so you can see what is missing.

thanks,

greg k-h
