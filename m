Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSGARoi>; Mon, 1 Jul 2002 13:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSGARoh>; Mon, 1 Jul 2002 13:44:37 -0400
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:6672 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S315942AbSGARoh>; Mon, 1 Jul 2002 13:44:37 -0400
Message-Id: <200207011746.g61Hkxf27019@blake.inputplus.co.uk>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18. 
In-Reply-To: Message from Anton Altaparmakov <aia21@cantab.net> 
   of "Mon, 01 Jul 2002 18:26:02 BST." <5.1.0.14.2.20020701181959.041d0070@pop.cus.cam.ac.uk> 
Date: Mon, 01 Jul 2002 18:46:58 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Anton,

> > What I'd like to see, if both hid.o and usbkbd.o can handle a
> > keyboard, is that hid.o gets the job.  Then usbkbd.o can stay in
> > config.in and be built just in case it's needed.
> 
> usbkbd.o is never needed when hid.o is present unless I have
> misunderstood something.

Ah, I thought that in the same way the BIOS might not support the HID
interface and so can use the simpler Boot interface, a keyboard might
not implement the HID interface and just implement the simpler Boot one.
Apologies if this isn't the case.  I agree that hid.o should be able to
cope with everything then.

> > Ah, OK, thanks.  Unfortunately, I've already moved onto 2.4.18 built
> > from source due to some of my other needs.
> 
> In that case just reconfigure your kernel not to include usbkbd and
> use hid instead, recompile, and be happy.

Yes, that's what I've done, and I'm happy, but still wish to persue the
problem in order that usbkbd.o gets fixed.  Otherwise, someone else will
spend their weekend learning about usbkbd.c, HID, Boot, etc.  :-)

Cheers,


Ralph.

