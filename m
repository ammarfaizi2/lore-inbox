Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUGVHMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUGVHMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 03:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUGVHMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 03:12:08 -0400
Received: from 209-87-233-98.storm.ca ([209.87.233.98]:16028 "EHLO
	ottawa.interneqc.com") by vger.kernel.org with ESMTP
	id S266821AbUGVHLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 03:11:40 -0400
Date: Thu, 22 Jul 2004 03:04:54 -0400
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, corbet@lwn.net, bgerst@didntduck.org,
       linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040722070453.GA21907@kroah.com>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722025539.5d35c4cb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 02:55:39AM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > Changes that remove functionally like Greg's patch are hopefully 
> > still 2.7 stuff - 2.6 is a stable kernel series and smooth upgrades 
> > inside a stable kernel series are a must for many users.
> 
> I don't necessarily agree that such changes in the userspace interface
> should be tied to the kernel version number, really.  That's a three or
> four year warning period, which is unreasonably long.  Six to twelve months
> should be long enough for udev-based replacements to stabilise and
> propagate out into distributions.

Users have had the 6-12 month warning about devfs for a while now :)
And udev is currently available in the latest distro versions of:
	- Red Hat
	- SuSE
	- Gentoo
	- Debian
	- Mandrake

While devfs is only supported in Gentoo at this time (and udev fills
that support issue for those users.)

> That being said, mid-2005 would be an appropriate time to remove devfs.  If
> that schedule pushes things along faster than they would otherwise have
> progressed, well, good.

Ok, if people think that would really change anything, I'll wait a year.
I'm patient :)

thanks,

greg k-h
