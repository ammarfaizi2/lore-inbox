Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268311AbTBMXED>; Thu, 13 Feb 2003 18:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268313AbTBMXED>; Thu, 13 Feb 2003 18:04:03 -0500
Received: from fmr02.intel.com ([192.55.52.25]:29144 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268311AbTBMXEC>; Thu, 13 Feb 2003 18:04:02 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Matt Porter <porter@cox.net>
Cc: Scott Murray <scottm@somanetworks.com>, Patrick Mochel <mochel@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030213155817.B1738@home.com>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
	<Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com> 
	<20030213155817.B1738@home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Feb 2003 14:05:39 -0800
Message-Id: <1045173941.1009.4.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 14:58, Matt Porter wrote:
> On Thu, Feb 13, 2003 at 04:12:28PM -0500, Scott Murray wrote:
> > On Thu, 13 Feb 2003, Patrick Mochel wrote:
> > > 
> > [snip]
> > > Create a watchdog timer class. That will contain all watchdog timers, no 
> > > matter what bus they are on. 
> > > 
> > > I apologize for leading you astray with suggesting you treat them as 
> > > system devices; I was under the assumption they were more important. :)
> > > They should always be in the most accurate place in the tree. Don't worry 
> > > about what the user sees; consistency and accuracy are more important..
> > 
> > I like this idea, since it means my init scripts wouldn't have to dig 
> > around looking for watchdog directories/files on various flavours of cPCI 
> > CPU cards. :)
> 
> Yes, and on embedded SoC devices we have watchdog facilities sitting
> on an internal chip bus.  It would be nice to find access points in
> a uniform place on any Linux system.  i.e. PCI watchdog on my x86 desktop
> is in the same place as the on-chip watchdog on my PPC44x system.
> 
> IMHO, anything else would be a logical step backwards from accessing
> /dev/watchdog across platforms.
> 
> Regards,
> -- 
> Matt Porter
> porter@cox.net
> This is Linux Country. On a quiet night, you can hear Windows reboot.

I'm reworking the proposal and the patch to create a new class... but I
need to do some experimenting to make sure I really understand how
classes/interfaces/devices/drivers are suppose to work.

    --rustyl

