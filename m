Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265465AbSKAARB>; Thu, 31 Oct 2002 19:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265471AbSKAARB>; Thu, 31 Oct 2002 19:17:01 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:44676 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S265465AbSKAARA>; Thu, 31 Oct 2002 19:17:00 -0500
Date: Thu, 31 Oct 2002 19:23:23 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Greg KH <greg@kroah.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Lee, Jung-Ik" <jung-ik.lee@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bare pci configuration access functions ?
In-Reply-To: <20021031234621.GE10689@kroah.com>
Message-ID: <Pine.LNX.4.33.0210311917040.26260-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Greg KH wrote:

> On Thu, Oct 31, 2002 at 05:50:06PM -0500, Scott Murray wrote:
> > On Thu, 31 Oct 2002, Greg KH wrote:
> > [snip]
> > > Anyway, this is a nice diversion from the real problem here, for 2.4,
> > > should I just backport the pci_ops changes which will allow pci
> > > hotplugging to work again on ia64, or do we want to do something else?
> >
> > It would be nice from a hotplug driver maintenance point of view if the
> > 2.4 and 2.5 interfaces were the same IMO.
>
> Yes it would be, but it's not a necessary thing :)

Yeah, yeah, I can deal. ;)

> > How about submitting the change in 2.4.21-pre?
>
> It is a _very_ big change.  It hits every architecture.  It was the
> right thing to do in 2.5, I'm just questioning if it's the right thing
> to do in 2.4 because of the magnitude of it.
>
> So, if people say it's ok, I'll do it.  But I would like to hear from
> the PPC64 group first, as I know I caused them a lot of grief and rework
> because of it.

I hadn't realized the magnitude of the changes from the previous
discussion here on the list, my apologies.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

