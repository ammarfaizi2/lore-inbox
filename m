Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290983AbSC0UvJ>; Wed, 27 Mar 2002 15:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291279AbSC0UvE>; Wed, 27 Mar 2002 15:51:04 -0500
Received: from [195.39.17.254] ([195.39.17.254]:28806 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S290120AbSC0Uty>;
	Wed, 27 Mar 2002 15:49:54 -0500
Date: Tue, 26 Mar 2002 18:52:39 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Wakko Warner <wakko@animx.eu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
Message-ID: <20020326185238.A324@toy.ucw.cz>
In-Reply-To: <20020325152617.A18605@animx.eu.org> <Pine.LNX.4.10.10203251319100.1305-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >   The way you say that makes me think that it does support at some other
> > > > level... hot swap controller? Doesn't match MY hardware. Hot swap
> > > 
> > > Controller level hotswap works mostly (think about pcmcia ide for example)
> > 
> > Just to throw this out there.  Is it possible to make the ide subsystem look
> > like a scsi controller ?  that way the scsi layer could insert/remove
> > devices.  say: ide0/1 = scsi0 (assuming no other scsi controllers) and hda =
> > scsi0 channel0 id0 lun0  and hdc = scsi0 channel1 id0 lun0 ...
> > 
> > Personally, if it's doable, i'd like it.
> 
> Hardware is different.
> You can paint a goose yellow and call it a duck, but it is still a goose.
> The electrical/electronic interface will kill you!

We already have support for SCSI-(raid)controllers which use IDE disks for
storage, so...

USB mass storage is not SCSI (in some cases), either. [Ouch, and some
usb-storage devices *are* IDE.]

So it makes sense to view IDE as very odd SCSI controllers.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

