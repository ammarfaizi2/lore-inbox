Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTDKX0H (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTDKX0G (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:26:06 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46030 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262569AbTDKXZi (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:25:38 -0400
Date: Fri, 11 Apr 2003 16:37:19 -0700
From: Greg KH <greg@kroah.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411233719.GD4539@kroah.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411192827.GC31739@ca-server1.us.oracle.com> <20030411195843.GO1821@kroah.com> <20030411232507.GC4917@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411232507.GC4917@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 04:25:07PM -0700, Joel Becker wrote:
> On Fri, Apr 11, 2003 at 12:58:43PM -0700, Greg KH wrote:
> > > There's going to be a war over this naming, and that's why this is
> > > hard.
> > 
> > No, there isn't.  That's what I am trying to completely avoid with udev.
> > It will allow you to plug in whatever device naming scheme that you
> > want.
> 
> 	And this is exactly what we can't have happen.  If I am an
> administrator, I don't want to have to write all my scripts to do:
> 
> if [ -f /etc/redhat-release ]
> then
>     DISKPREFIX="/dev/disk"
> elif [ -f /etc/unitedlinux-release ]
> then
>     DISKPREFIX="/dev/disc"
> elif [ -f /dev/volume0 ]
> then
>     DISKPREFIX="/dev/volume"
> elif 
>     ...

But all the distros will do that for you :)

> 	Please, let's not repeat GNOME/KDE, OpenLook/Motif,
> mkinitrd/mkinitrd, etc for all our devices.

Then try to convince LSB to add a device naming document to their spec.
That's the only way this is going to happen...

Good luck,

greg k-h
