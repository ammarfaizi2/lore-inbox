Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVLTI4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVLTI4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVLTI4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:56:42 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:13292 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1750894AbVLTI4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:56:41 -0500
Date: Tue, 20 Dec 2005 09:56:53 +0100
From: Sander <sander@humilis.net>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Willy Tarreau <willy@w.ods.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, axboe@suse.de,
       vandrove@vc.cvut.cz, aia21@cam.ac.uk, akpm@osdl.org
Subject: Re: [RFC] Let non-root users eject their ipods?
Message-ID: <20051220085653.GA3137@favonius>
Reply-To: sander@humilis.net
References: <1135047119.8407.24.camel@leatherman> <20051220051821.GM15993@alpha.home.local> <2cd57c900512192206g7292cb1m@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900512192206g7292cb1m@mail.gmail.com>
X-Uptime: 07:43:24 up 32 days, 18:42, 24 users,  load average: 1.06, 1.20, 1.27
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote (ao):
> 2005/12/20, Willy Tarreau <willy@w.ods.org>:
> > On Mon, Dec 19, 2005 at 06:51:58PM -0800, john stultz wrote:
> > >       I'm getting a little tired of my roommates not knowing how to safely
> > > eject their usb-flash disks from my system and I'd personally like it if
> > > I could avoid bringing up a root shell to eject my ipod. Sure, one could
> > > suid the eject command, but that seems just as bad as changing the
> > > permissions in the kernel (eject wouldn't be able to check if the user
> > > has read/write permissions on the device, allowing them to eject
> > > anything).
> >
> > You may find my question stupid, but what is wrong with umount ? That's
> > how I proceed with usb-flash and I've never sent any eject command to
> > it (I even didn't know that the ioctl would be accepted by an sd device).
> 
> IMHO, umount doesn't guarantee sync, isn't it?

I'm pretty sure it does :-)

Anyway, that is how I treat all usb/firewire disks, and I've never lost
data. Just umount and unplug when the prompt returns.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
