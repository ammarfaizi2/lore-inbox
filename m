Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUAPB0v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUAPB0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:26:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:21968 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265232AbUAPB0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:26:49 -0500
Date: Thu, 15 Jan 2004 17:24:31 -0800
From: Greg KH <greg@kroah.com>
To: Kieran Morrissey <linux@mgpenguin.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.1: Update PCI Name database, fix gen-devlist.c for long device names.
Message-ID: <20040116012431.GO23253@kroah.com>
References: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 02:28:39PM +1100, Kieran Morrissey wrote:
> Hi all and sundry..
> 
> Although /proc/pci and by extension the name database is allegedly legacy 
> and therefore deprecated, some (including myself) still use it for things 
> such as phpSysInfo, and the still-widespread usage of it is obvious in the 
> regularity of slight patches to pci.ids. So, this is an all-inclusive patch 
> to bring things up to date:
> 
> * Updates pci.ids with a snapshot from http://pciids.sourceforge.net/ as at 
> 14 Jan 04.
> * Fixes gen-devlist.c to truncate long device names rather than reject the 
> whole database
>   (previously the latest databases had some devices that were too long and 
> caused a kernel with the latest db to fail to compile)

Your patch is line-wrapped and can't be applied.

Please try it again.

> I've included the (minor) changes to gen-devlist.c in this email if anyone 
> cares to discuss them, but since the pci database changes aren't really 
> that worthy of discussion on the list and the patch is 83kb, THE COMPLETE 
> PATCH has been posted on the web:
> 
> http://digital.mgpenguin.net/linux/patch-2.6.1.pci-db/patch.2.6.1.pci-db.diff

Feel free to just send this patch to me, as it's much easier for me to
apply this if I get an email with it in it (include the description
please too.)

thanks,

greg k-h
