Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbTD3WMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbTD3WMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:12:47 -0400
Received: from granite.he.net ([216.218.226.66]:48901 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262477AbTD3WMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:12:45 -0400
Date: Wed, 30 Apr 2003 15:26:09 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk10 - usbkbd.c compilation error
Message-ID: <20030430222609.GA25332@kroah.com>
References: <mailman.1051727220.20780.linux-kernel2news@redhat.com> <200304302212.h3UMCDV00426@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304302212.h3UMCDV00426@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 06:12:13PM -0400, Pete Zaitcev wrote:
> >   gcc -Wp,-MD,drivers/usb/input/.usbkbd.o.d -D__KERNEL__ -Iinclude -Wall
> > -DKBUILD_MODNAME=usbkbd -c -o drivers/usb/input/.tmp_usbkbd.o
> > drivers/usb/input/usbkbd.c
> 
> Just curious, why do you use usbkbd and usbmouse?

He must be building an embedded system, as that's the only people who
should be using those drivers (as is explained in the help entries.)

> I think they should have been removed from the kernel long ago.

The embedded people would hate you :)

thanks,

greg k-h
