Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUHNQg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUHNQg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUHNQg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:36:59 -0400
Received: from web14923.mail.yahoo.com ([216.136.225.7]:14207 "HELO
	web14923.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263875AbUHNQgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:36:51 -0400
Message-ID: <20040814163651.17487.qmail@web14923.mail.yahoo.com>
Date: Sat, 14 Aug 2004 09:36:51 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though sysfs)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1092497235.27144.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the API that a user space apps will use to control the state of
VGA devices?

For example:
1) a standard device exposing IOCTLs needing an header file describing
it.
or 2) Building a new tree in /sys/class/vga that uses attributes to
control the state. you turn the device on by copying a '1' to the
attribute.

Once we pick sysfs or ioctl API, what should the full set of calls look
like?

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sad, 2004-08-14 at 00:56, Jon Smirl wrote:
> > I know internally how to find the VGA cards using the PCI class. I
> > meant this in the context of how do you enumerate all of the VGA
> > devices in a domain from a user space app. What is the API for
> this?
> > What is the user space API for turning off all of the VGA devices
> in a
> > domain?
> 
> I don't follow the logic behind the question. Once you have the vga
> locking device then that needs to handle the vga on/off.
> 
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
