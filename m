Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUAPB0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUAPB0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:26:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:22736 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265233AbUAPB0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:26:51 -0500
Date: Thu, 15 Jan 2004 17:23:14 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kieran Morrissey <linux@mgpenguin.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.1: Update PCI Name database, fix gen-devlist.c for long device names.
Message-ID: <20040116012314.GN23253@kroah.com>
References: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net> <40061188.8060705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40061188.8060705@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 11:05:28PM -0500, Jeff Garzik wrote:
> Kieran Morrissey wrote:
> >Hi all and sundry..
> >
> >Although /proc/pci and by extension the name database is allegedly 
> >legacy and therefore deprecated, some (including myself) still use it 
> >for things such as phpSysInfo, and the still-widespread usage of it is 
> >obvious in the regularity of slight patches to pci.ids. So, this is an 
> >all-inclusive patch to bring things up to date:
> >
> >* Updates pci.ids with a snapshot from http://pciids.sourceforge.net/ as 
> >at 14 Jan 04.
> >* Fixes gen-devlist.c to truncate long device names rather than reject 
> >the whole database
> >  (previously the latest databases had some devices that were too long 
> >and caused a kernel with the latest db to fail to compile)
> 
> 
> Well, appreciated, but we really do need to remove it.  We don't need 
> these strings in the kernel at all.  pci.ids is just a static lookup 
> table that is best kept in userspace.

It will be removed in 2.7.

thanks,

greg k-h
