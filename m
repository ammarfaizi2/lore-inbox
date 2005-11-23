Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVKWRQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVKWRQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVKWRQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:16:49 -0500
Received: from styx.suse.cz ([82.119.242.94]:37835 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751255AbVKWRQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:16:48 -0500
Date: Wed, 23 Nov 2005 18:16:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Marc Koschewski <marc@osknowledge.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: Christmas list for the kernel
Message-ID: <20051123171647.GA3666@ucw.cz>
References: <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com> <20051123155650.GB6970@stiffy.osknowledge.org> <20051123160520.GH15449@flint.arm.linux.org.uk> <9e4733910511230837v1519d3b3t28176b1fd6017ffc@mail.gmail.com> <20051123164907.GA2981@ucw.cz> <9e4733910511230859y3879e65fp927a7aa4d71d8fee@mail.gmail.com> <20051123170508.GE6970@stiffy.osknowledge.org> <9e4733910511230913y7fe5f9cfw99bfbb077ea9c87a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511230913y7fe5f9cfw99bfbb077ea9c87a@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 12:13:06PM -0500, Jon Smirl wrote:

> On 11/23/05, Marc Koschewski <marc@osknowledge.org> wrote:
> > * Jon Smirl <jonsmirl@gmail.com> [2005-11-23 11:59:27 -0500]:
> > > Another would be to have a little user space daemon that listened to
> > > the pty creation, and then mknod the tty nodes as need and pipe the
> > > data through. That would be a first step to moving to a user space
> > > console implementation.
> >
> > Shouldn't this be udev then? I hear people scream when 'some deamon'
> > created a device in /dev. Was it udev? Was is 'ttydevd'? Even
> > 'ondemanddevd'?
> 
> udev listens to /sys/class for it's indications on when to create a node.
> 
> The tty daemon would need to listen for pty creation to tell it when
> to create a node. Then after it creates the node it needs to maintain
> a pipe between the pty and tty. This is a lot different than what udev
> does.
 
Except for that it wouldn't work for a reason I've described earlier, it
could well be launched from udev.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
