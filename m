Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265511AbSJaXmz>; Thu, 31 Oct 2002 18:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265514AbSJaXmz>; Thu, 31 Oct 2002 18:42:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17683 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265511AbSJaXmy>;
	Thu, 31 Oct 2002 18:42:54 -0500
Date: Thu, 31 Oct 2002 15:46:21 -0800
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Lee, Jung-Ik" <jung-ik.lee@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bare pci configuration access functions ?
Message-ID: <20021031234621.GE10689@kroah.com>
References: <20021031221136.GC10689@kroah.com> <Pine.LNX.4.33.0210311748050.26260-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210311748050.26260-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 05:50:06PM -0500, Scott Murray wrote:
> On Thu, 31 Oct 2002, Greg KH wrote:
> [snip]
> > Anyway, this is a nice diversion from the real problem here, for 2.4,
> > should I just backport the pci_ops changes which will allow pci
> > hotplugging to work again on ia64, or do we want to do something else?
> 
> It would be nice from a hotplug driver maintenance point of view if the
> 2.4 and 2.5 interfaces were the same IMO.

Yes it would be, but it's not a necessary thing :)

> How about submitting the change in 2.4.21-pre?

It is a _very_ big change.  It hits every architecture.  It was the
right thing to do in 2.5, I'm just questioning if it's the right thing
to do in 2.4 because of the magnitude of it.

So, if people say it's ok, I'll do it.  But I would like to hear from
the PPC64 group first, as I know I caused them a lot of grief and rework
because of it.

thanks,

greg k-h
