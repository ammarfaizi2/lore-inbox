Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262754AbSI1JLX>; Sat, 28 Sep 2002 05:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262756AbSI1JLX>; Sat, 28 Sep 2002 05:11:23 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:53518 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262754AbSI1JLV>; Sat, 28 Sep 2002 05:11:21 -0400
Date: Sat, 28 Sep 2002 02:16:34 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice driver
Message-ID: <20020928091634.GC32017@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209262140380.1655-100000@home.transmeta.com> <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 09:46:35AM +0200, Ingo Molnar wrote:
> 
> On Thu, 26 Sep 2002, Linus Torvalds wrote:
> > On Thu, 26 Sep 2002, Jeff Garzik wrote:
> > > Tangent question, is it definitely to be named 2.6?
> > 
> > I see no real reason to call it 3.0.
> > 
> > The order-of-magnitude threading improvements might just come closest to
> > being a "new thing", but yeah, I still consider it 2.6.x. We don't have
> > new architectures or other really fundamental stuff. In many ways the
> > jump from 2.2 -> 2.4 was bigger than the 2.4 -> 2.6 thing will be, I
> > suspect.
> 
> i consider the VM and IO improvements one of the most important things
> that happened in the past 5 years - and it's definitely something that
> users will notice. Finally we have a top-notch VM and IO subsystem (in
> addition to the already world-class networking subsystem) giving
> significant improvements both on the desktop and the server - the jump
> from 2.4 to 2.5 is much larger than from eg. 2.0 to 2.4.
> 
> I think due to these improvements if we dont call the next kernel 3.0 then
> probably no Linux kernel in the future will deserve a major number. In 2-4
> years we'll only jump to 3.0 because there's no better number available
> after 2.8. That i consider to be ... boring :) [while kernel releases are
> supposed to be a bit boring, i dont think they should be _that_ boring.]
> 

Ingo, I agree with Linus.  My recollection of when we moved
to 2.0 was that the major number reflected the user<->kernel
ABI.  I have no problem with a version 2.42 if things stay
stable that long.   I hope they don't but that is another
issue.

Version 3.0 implies incompatibility with binaries from 2.x
The distributions can play around with version numbers
reflecting the GUI interface, libraries or installers but
the kernel major version should stay the same until binary
compatibility is broken.  When we move old syscalls (such as
32 bit file ops) from deprecated to unsupported is when we
increment the major number.

It may be that 2.7 will see the cruft cut out and be the end
of 2.x but 2.5 isn't that.  So far 2.5 is performance
enhancement.  Terrific performance enhancement, thanks to you
and many others.  But it isn't adding major new features nor
is it removing old interfaces.  In many ways 2.6 looks like
a sign that the 2.x kernel is getting mature.  2.6 means
users can expect improvements but don't have to make big changes.
2.6 is an upgrade, 3.0 would be a replacement.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
