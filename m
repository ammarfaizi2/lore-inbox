Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbVCQHCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVCQHCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 02:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVCQHCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 02:02:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:34471 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261753AbVCQHCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 02:02:03 -0500
Date: Wed, 16 Mar 2005 22:17:24 -0800
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050317061724.GC14644@kroah.com>
References: <20050315170834.GA25475@kroah.com> <9e47339105031615163579ea50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105031615163579ea50@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 06:16:19PM -0500, Jon Smirl wrote:
> On Tue, 15 Mar 2005 09:08:34 -0800, Greg KH <greg@kroah.com> wrote:
> > Hi all,
> > 
> > There are 4 patches being posted here in response to this message that
> > start us on the way toward cleaning up the driver model code so that
> > it's actually usable by mere kernel developers :)
> 
> Is this going to let me make subdirectories in /sys/class/xxx
> directories that generate hotplug events?

Not yet, no, sorry.

> One example:
> /sys/class/graphics/fb0/monitor(edid)
> 
> If the monitor is hotplugged the monitor directory will be
> created/destroyed causing a hotplug event.

That would be a good thing, on the todo list...

greg k-h
