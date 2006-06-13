Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWFMVSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWFMVSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWFMVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:18:39 -0400
Received: from ns.suse.de ([195.135.220.2]:43675 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932277AbWFMVSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:18:38 -0400
Date: Tue, 13 Jun 2006 14:16:04 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Oliver Bock <o.bock@fh-wolfenbuettel.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Message-ID: <20060613211604.GB26851@kroah.com>
References: <200606100042.19441.o.bock@fh-wolfenbuettel.de> <20060609224957.GA15130@elf.ucw.cz> <200606121934.05619.o.bock@fh-wolfenbuettel.de> <20060613192304.GG27312@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060613192304.GG27312@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 09:23:04PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > BTW could we get come better name for the driver? cy7c63 looks like
> > > password of very paranoid sysadmin.
> > 
> > Hm, the chipset family is just called like that and there're at least three 
> > other Cypress related drivers (cypress, cypress_m8 and cytherm) with generic 
> > names. I think this name shows clearly what kind of device it supports, 
> > doesn't it?
> 
> cypress_63 might be unique and still easier to pronounce?

Who cares what the thing is called.  It only has to be unique in the
whole kernel driver namespace, and it will be automatically loaded by
the tools when the device is plugged in, so it will never be typed in by
hand (except by developers, and they are used to looney names like
this.)

Oliver wrote it, so he gets to name it :)

thanks,

greg k-h
