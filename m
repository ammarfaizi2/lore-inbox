Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSGAQpC>; Mon, 1 Jul 2002 12:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSGAQpB>; Mon, 1 Jul 2002 12:45:01 -0400
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:27492 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S315748AbSGAQpB>; Mon, 1 Jul 2002 12:45:01 -0400
Message-Id: <200207011647.g61GlNx14474@blake.inputplus.co.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18. 
In-Reply-To: Message from Pete Zaitcev <zaitcev@redhat.com> 
   of "Mon, 01 Jul 2002 11:16:49 EDT." <200207011516.g61FGnP20648@devserv.devel.redhat.com> 
Date: Mon, 01 Jul 2002 17:47:23 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

> > My theory is that usbkbd.o doesn't cope with ErrorRollover which is
> > being generated, unlike hid.o which didn't used to but does now.
> 
> I have an idea: remove usbkbd or make it extremely hard for newbies to
> build (e.g. drop CONFIG_USB_KBD from config.in, so it would need to be
> added manually if you want usbkbd).

That doesn't sound too great.

> At the very minimum I would like to see all distros, and especially
> SuSE (because of Vojtech) to stop shipping usbkbd.o.

What I'd like to see, if both hid.o and usbkbd.o can handle a keyboard,
is that hid.o gets the job.  Then usbkbd.o can stay in config.in and be
built just in case it's needed.

> > I'll try and use hid.o instead, usbkbd.o was just picked by this Red
> > Hat 7.2 system on adding the keyboard.
> 
> Do up2date and be happy: usbkbd.o was removed from Red Hat kernels
> somewhere in erratas.

Ah, OK, thanks.  Unfortunately, I've already moved onto 2.4.18 built
from source due to some of my other needs.

Cheers,


Ralph.

