Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVBYX6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVBYX6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVBYX6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:58:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:40074 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262119AbVBYX6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:58:54 -0500
Date: Fri, 25 Feb 2005 15:58:39 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlink /sys/class/block to /sys/block
Message-ID: <20050225235839.GB29912@kroah.com>
References: <courier.4217CBC9.000027C1@mail.farside.org.uk> <20050222190412.GA23687@suse.de> <courier.421C5047.00003EBA@mail.farside.org.uk> <20050224233458.GB26941@suse.de> <loom.20050225T020954-395@post.gmane.org> <20050225223926.GB28014@kroah.com> <20050225235349.GA12485@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225235349.GA12485@vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 12:53:49AM +0100, Kay Sievers wrote:
> On Fri, Feb 25, 2005 at 02:39:27PM -0800, Greg KH wrote:
> > > The hotplug events will still have the /block/* devpath, so this symlink
> > > will give us nothing than problems.
> > 
> > It will not give hotplug programs issues, as the block devpath still
> > remains the same.
> 
> No, but anything like udevstart or HAL coldplugging will have a problem
> with that inconsistency.

Damm, forgot about that, good point :)

Ok, forget the symlink.  Or, for that matter, ever moving from
/sys/block/...

thanks,

greg k-h
