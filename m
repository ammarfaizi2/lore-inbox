Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSGARWv>; Mon, 1 Jul 2002 13:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSGARWu>; Mon, 1 Jul 2002 13:22:50 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:50757 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315893AbSGARWt>; Mon, 1 Jul 2002 13:22:49 -0400
Message-Id: <5.1.0.14.2.20020701181959.041d0070@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 01 Jul 2002 18:26:02 +0100
To: Ralph Corderoy <ralph@inputplus.co.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18. 
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200207011647.g61GlNx14474@blake.inputplus.co.uk>
References: <Message from Pete Zaitcev <zaitcev@redhat.com>
 <200207011516.g61FGnP20648@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:47 01/07/02, Ralph Corderoy wrote:
>What I'd like to see, if both hid.o and usbkbd.o can handle a keyboard,
>is that hid.o gets the job.  Then usbkbd.o can stay in config.in and be
>built just in case it's needed.

usbkbd.o is never needed when hid.o is present unless I have misunderstood 
something.

> > > I'll try and use hid.o instead, usbkbd.o was just picked by this Red
> > > Hat 7.2 system on adding the keyboard.
> >
> > Do up2date and be happy: usbkbd.o was removed from Red Hat kernels
> > somewhere in erratas.
>
>Ah, OK, thanks.  Unfortunately, I've already moved onto 2.4.18 built
>from source due to some of my other needs.

In that case just reconfigure your kernel not to include usbkbd and use hid 
instead, recompile, and be happy.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

