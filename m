Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUAOXVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265156AbUAOXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:21:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:37544 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265137AbUAOXVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:21:12 -0500
Date: Thu, 15 Jan 2004 15:03:42 -0800
From: Greg KH <greg@kroah.com>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
Message-ID: <20040115230342.GN22433@kroah.com>
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com> <20040114171527.GB5472@kroah.com> <40058086.5000106@nortelnetworks.com> <4005971F.4020608@vgertech.com> <20040114211417.GC6650@kroah.com> <400645D9.1040400@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400645D9.1040400@vgertech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 07:48:41AM +0000, Nuno Silva wrote:
> Hi!
> 
> Greg KH wrote:
> >On Wed, Jan 14, 2004 at 07:23:11PM +0000, Nuno Silva wrote:
> >
> >>This would be nice but I think that full info for every new hotplugged 
> >>device is even better. It's only 1 line :-)
> >
> >
> >Heh, care to make that one line patch?  :)
> >
> 
> Ehehehe I was talking about the extra line ending up in syslog. :-)
> 
> Anyway, attached is a simple patch that outputs 50% of what I'd like to 
> see - still missing the SYSFS_model, serial, etc because 
> sysfs_get_classdev_attributes didn't work at my first try, but that's my 
> faulty C showing :)

Hm, I just took Kay's patch instead.  Care to make up a patch for this
based off of it?

thanks,

greg k-h
