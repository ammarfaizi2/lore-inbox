Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbTL2X7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbTL2X7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:59:35 -0500
Received: from [64.65.177.98] ([64.65.177.98]:38373 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S265493AbTL2X7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:59:33 -0500
Subject: Re: 3ware driver broken with 2.4.22/23 ?
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Samuel Flory <sflory@rackable.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux@3ware.com
In-Reply-To: <20031229234902.GL916@mail.muni.cz>
References: <20031221112113.GE916@mail.muni.cz>
	 <3FE645E3.30602@rackable.com> <1072503925.27022.222.camel@menion.home>
	 <20031229234902.GL916@mail.muni.cz>
Content-Type: text/plain
Message-Id: <1072742359.21939.2.camel@bubbles.imr-net.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 15:59:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-29 at 15:49, Lukas Hejtmanek wrote:
> On Fri, Dec 26, 2003 at 09:45:25PM -0800, Joshua Schmidlkofer wrote:
> > 
> > >    Generally not with such a small rev difference.  You could try the 
> > > latest driver, and firmware in the 7.7.  The driver source is on the Red 
> > > Hat drivers disk.  You should be able to drop in the .c, and .h in 
> > > drivers/scsi, and recompile.
> > > http://3ware.com/support/download.asp?code=5&id=7.7.0&softtype=Driver&releasenotes=&os=Windows
> > > 
> > > PS- Personally I'd suspect an XFS bug.  Try reiserfs.  I've been running 
> > > 2.4.23pres, and 2.4.23 on hundreds of 3ware of numerous different types. 
> > >   With no issue with the prior firmware release.
> > 
> > There are a lot of people, running RAID5 3ware's w/ Terrabyte arrays.  I
> > don't want to say it is not an XFS bug, but I find that highly suspect. 
> 
> Well, with ext3 parition iozone program finishes OK. So it looks like some XFS
> bug.

FWIW have you sent this on to the XFS list?

thanks,
  Joshua




