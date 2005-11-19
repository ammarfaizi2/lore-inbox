Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbVKSBmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbVKSBmQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbVKSBmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:42:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:26560 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161121AbVKSBmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:42:16 -0500
Date: Fri, 18 Nov 2005 17:26:32 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Ian McDonald <imcdnzl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
Message-ID: <20051119012632.GA28458@kroah.com>
References: <20051117111807.6d4b0535.akpm@osdl.org> <200511181835.11719.tomlins@cam.org> <20051118235116.GA26405@kroah.com> <200511182024.33858.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511182024.33858.tomlins@cam.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 08:24:33PM -0500, Ed Tomlinson wrote:
> On Friday 18 November 2005 18:51, Greg KH wrote:
> > On Fri, Nov 18, 2005 at 06:35:11PM -0500, Ed Tomlinson wrote:
> > > On Friday 18 November 2005 18:16, Ed Tomlinson wrote:
> > > > On Friday 18 November 2005 16:14, Ian McDonald wrote:
> > > > > On 11/19/05, Greg KH <greg@kroah.com> wrote:
> > > > > > Are you using debian?
> > > > > > If so, what version of udev are you using?  There are some known
> > > > > > reported problems with this, so I would suggest referring to the udev
> > > > > > bug list.
> > > > > >
> > > > > In particular check the version requirements for udev - you need to be
> > > > > on a version greater than or equal to 71. Sarge/stable has a really
> > > > > old version. In particular I am running unstable as I had too many
> > > > > funny errors (including this one) - but etch should be fine.
> > > > > 
> > > > > If running another distribution check this also as it is a real requirement.
> > > > > 
> > > > > To find the latest version of udev required check Documentation/Changes
> > > > 
> > > > devinfo -v 
> > > > udevinfo, version 074 
> > > > 
> > > > dpkg -s 
> > > > Package: udev
> > > > Status: install ok installed
> > > > Priority: extra
> > > > Section: admin
> > > > Installed-Size: 1072
> > > > Maintainer: Marco d'Itri <md@linux.it>
> > > > Architecture: amd64
> > > > Version: 0.074-3
> > > > 
> > > > Interestingly the same udev works fine with 14-rc4-mm1.  I'll check the debian
> > > > bugs.
> > > 
> > > There does not seem to be anything that fits this reported as a debian bug.  Where
> > > is the udev bugs list?
> > 
> > For Debian?  I have no idea as I do not use it :)
> > 
> > For general udev issues/queries try the linux-hotplug-devel mailing
> > list.
> > 
> > Oh, and are you sure you actually have the proper module loaded?
> 
> Think only the mousedev module is not loaded.  Once I modprobe it the mouse works
> and the /dev/input/mice appears.  The mouse works normally with all buttons and wheels
> acting normal.

Then you just need to make sure that module is loaded properly, which
doesn't sound like a udev issue :)

thanks,

greg k-h
