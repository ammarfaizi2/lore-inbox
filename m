Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263939AbUEHA0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUEHA0C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUEHAXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:23:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:52355 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263937AbUEHAVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:21:54 -0400
Date: Fri, 7 May 2004 16:25:10 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       vojtech@suse.cz
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040507232510.GO14660@kroah.com>
References: <200404230142.46792.dtor_core@ameritech.net> <200404251648.07232.dtor_core@ameritech.net> <20040504210414.GC27037@kroah.com> <200405050208.11348.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405050208.11348.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 02:08:11AM -0500, Dmitry Torokhov wrote:
> On Tuesday 04 May 2004 04:04 pm, Greg KH wrote:
> > On Sun, Apr 25, 2004 at 04:48:07PM -0500, Dmitry Torokhov wrote:
> > >  
> > > No, I am still getting the oops.. hmm.. it seems a little bit different,
> > > but still in the hiddev. I investigated further and the oops only happens
> > > if I yank a HID device connected to an USB hub or if I yank entire hub with
> > > a HID device connected to it. Tried with APC UPS and MS Intellimouse
> > > Explorer. If they are connected directly to the laptop's ports everything is
> > > fine, also other devices (USB printer for example) handle hub disconnection
> > > just fine. It does not matter if I have device open or closed for oops to
> > > happen. And, for the record, oops itself:
> > 
> > Are you still getting this in the 2.6.6-rc3 kernel?
> > 
> > How about the latest -mm release?
> > 
> 
> With tonight's bk pull + USB patch from 2.6.6-rc3-mm1 I am still getting the
> following oops when pulling a HID device out of a hub:

Ick, I'll work on trying to duplicate this and see if I can figure it
out...

thanks for letting me know.

greg k-h
