Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285313AbRLFXiQ>; Thu, 6 Dec 2001 18:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285311AbRLFXiB>; Thu, 6 Dec 2001 18:38:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15565 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285310AbRLFXhq>;
	Thu, 6 Dec 2001 18:37:46 -0500
Date: Thu, 6 Dec 2001 18:37:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Greg KH <greg@kroah.com>
cc: Rene Rebe <rene.rebe@gmx.net>, Jonathan Hudson <jonathan@daria.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
In-Reply-To: <20011206152721.M2710@kroah.com>
Message-ID: <Pine.GSO.4.21.0112061835010.29985-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Dec 2001, Greg KH wrote:

> On Thu, Dec 06, 2001 at 10:30:50PM +0100, Rene Rebe wrote:
> > 
> > This is what I do - but IT SUCKS!! Can't the USB stuff simply use devfs so
> > I can control the permissions of this USB nodes in a very nice / cleaner
> > way I do with all my other stuff??? (In contrast to use some find -name

Because anybody who uses devfs might as well make everything in /dev 666
and do the same with /etc/shadow while we are at it?

> > | xargs chmod ... or simillar hacks ...)
> 
> How is using devfs (and devfsd) any different in "hack level" from using
> /sbin/hotplug?
> 
> usbdevfs does not require devfs, which enables the majority of Linux
> users to actually use it.

s/majority of/& sane/

