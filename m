Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVF1WjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVF1WjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVF1WfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:35:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:55763 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262204AbVF1Wcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:32:33 -0400
Date: Tue, 28 Jun 2005 13:08:24 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Mike Bell <kernel@mikebell.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628200824.GA12851@kroah.com>
References: <20050624081808.GA26174@kroah.com> <20050627232559.GA7690@mikebell.org> <20050628074015.GA3577@kroah.com> <200506281400.08777.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506281400.08777.oliver@neukum.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 02:00:08PM +0200, Oliver Neukum wrote:
> Am Dienstag, 28. Juni 2005 09:40 schrieb Greg KH:
> > On Mon, Jun 27, 2005 at 04:26:00PM -0700, Mike Bell wrote:
> > > On Mon, Jun 27, 2005 at 05:35:50PM -0500, Dmitry Torokhov wrote:
> > > > AFAIK there is no requirement in input subsystem that devices should be
> > > > created under /dev/input. When devfs is activated they are created there
> > > > by default, but that's it.
> > > 
> > > Things which accept a path to an event file as an argument will work
> > > just fine. But anything which tries autodiscovery HAS to be able to find
> > > the device nodes. Think directfb, most (but not all) of the X patches,
> > > any user-space driver that wants to find the hardware it owns, etc.
> > > 
> > > This illustrates nicely my reasons for preferring devfs.
> > > 
> > > 1) Predictable, canonical device names are a Good Thing.
> > 
> > And impossible for the kernel to generate given hotpluggable devices.
> 
> That is not true. The kernel can generate predictable device names.
> It just cannot generate _stable_ device names under all circumstances.

Well, I view "canonical" as, "this is the name for this specific device,
and will always be that name".  But, if others think of it differently,
hey, that's fine with me too.

And yes, I also agree with your statement.

thanks,

greg k-h
