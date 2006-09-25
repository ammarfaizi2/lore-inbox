Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWIYJYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWIYJYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 05:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIYJYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 05:24:43 -0400
Received: from symlink.to.noone.org ([85.10.207.172]:4027 "EHLO sym.noone.org")
	by vger.kernel.org with ESMTP id S1750746AbWIYJYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 05:24:42 -0400
Date: Mon, 25 Sep 2006 11:24:40 +0200
From: Tobias Klauser <tklauser@distanz.ch>
To: Amol Lad <amol@verismonetworks.com>
Cc: kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [KJ] [PATCH] Handcrafted MIN/MAX removal
Message-ID: <20060925092440.GK10725@distanz.ch>
References: <1159176031.25016.44.camel@amol.verismonetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159176031.25016.44.camel@amol.verismonetworks.com>
X-Editor: Vi IMproved 6.3
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-09-25 at 11:20:31 +0200, Amol Lad <amol@verismonetworks.com> wrote:
> Sending to lkml also
> 
> Cleanups done to use min/max macros from kernel.h. Handcrafted MIN/MAX
> macros are changed to use macros in kernel.h
> 
> Tested for allmodconfig
> 
> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
>  drivers/isdn/hardware/eicon/debug.c    |    4 +--
>  drivers/isdn/hardware/eicon/di.c       |    8 +++----
>  drivers/isdn/hardware/eicon/io.c       |    2 -
>  drivers/isdn/hardware/eicon/istream.c  |    4 +--
>  drivers/isdn/hardware/eicon/platform.h |    8 -------
>  drivers/scsi/aic7xxx/aic79xx.h         |    8 -------
>  drivers/scsi/aic7xxx/aic79xx_core.c    |   22 ++++++++++-----------
>  drivers/scsi/aic7xxx/aic79xx_osm.c     |    6 ++---
>  drivers/scsi/aic7xxx/aic7xxx.h         |    8 -------
>  drivers/scsi/aic7xxx/aic7xxx_core.c    |   18 ++++++++---------
>  drivers/scsi/aic7xxx/aic7xxx_osm.c     |    4 +--
>  fs/xfs/xfs_btree.h                     |   34 +++++++++------------------------
>  fs/xfs/xfs_rtalloc.c                   |   20 +++++++++----------
>  fs/xfs/xfs_rtalloc.h                   |    3 --

Split up by driver/subsystem, please.

Cheers, Tobias
