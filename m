Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266285AbUAGR5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUAGR5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:57:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:15318 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266285AbUAGR5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:57:02 -0500
Date: Wed, 7 Jan 2004 09:56:51 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olh@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Andrey Borzenkov <arvidjaar@mail.ru>,
       Andries Brouwer <aebr@win.tue.nl>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107175651.GE31177@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103133749.A3393@pclin040.win.tue.nl> <20040103124216.GA31006@suse.de> <200401031905.31806.arvidjaar@mail.ru> <20040103175414.GX5523@suse.de> <20040107094321.GC21059@suse.de> <20040107095029.GX3483@suse.de> <20040107095632.GA22213@suse.de> <20040107095922.GY3483@suse.de> <20040107102515.GC22770@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107102515.GC22770@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:25:15AM +0100, Olaf Hering wrote:
>  On Wed, Jan 07, Jens Axboe wrote:
> 
> > On Wed, Jan 07 2004, Olaf Hering wrote:
> > >  On Wed, Jan 07, Jens Axboe wrote:
> > > 
> > > > No need to put it in the kernel, user space fits the bil nicely. I don't
> > > > see how this would lead to IO errors?
> > > 
> > > Ok, how should it be done on my SCSI and parallel port ZIP? An ATAPI ZIP
>         ^^^
> 
> "How"? We need a sane way to deal with removeable medias.
> Do you have example code that can be put into the udev distribution?

In udev?  Why, that sounds like the job for some other tool/program,
that can sit around and poll devices.  Not job for udev (which is for
naming devices.)

thanks,

greg k-h
