Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272378AbTGaEjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 00:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272380AbTGaEjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 00:39:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:38084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272378AbTGaEjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 00:39:19 -0400
Date: Wed, 30 Jul 2003 21:11:03 -0700
From: Greg KH <greg@kroah.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030731041103.GA7668@kroah.com>
References: <3F26F009.4090608@mrs.umn.edu> <20030730231753.GB5491@kroah.com> <20030731011450.GA2772@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731011450.GA2772@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 03:14:50AM +0200, Andries Brouwer wrote:
> On Wed, Jul 30, 2003 at 04:17:53PM -0700, Greg KH wrote:
> > On Tue, Jul 29, 2003 at 05:07:05PM -0500, Grant Miner wrote:
> > > I have a Microtech CompactFlash ZiO! USB
> > > P:  Vendor=04e6 ProdID=1010 Rev= 0.05
> > > S:  Manufacturer=SHUTTLE
> > > S:  Product=SCM Micro USBAT-02
> > > 
> > > but it does not show up in /dev; this is in 2.6.0-pre1.  (It never 
> > > worked in 2.4 either.)  config is attached.  Any ideas?
> > 
> > Linux doesn't currently support this device, sorry.
> 
> Hmm. I think I recall seeing people happily using that.
> Do I misremember?
> 
> Google gives
>   http://www.scm-pc-card.de/service/linux/zio-cf.html
> and
>   http://usbat2.sourceforge.net/

In looking at the kernel source, I don't see support for this device.  I
do see support for others like it, but with different product ids.
Perhaps Grant can play with the settings in
drivers/usb/storage/unusual_devs.h to try to tweak things to work for
his device.

Sorry for not stating this originally, it has been a long day :)

greg k-h
