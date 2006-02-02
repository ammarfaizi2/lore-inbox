Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWBBUT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWBBUT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWBBUT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:19:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26856 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751181AbWBBUTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:19:55 -0500
Date: Thu, 2 Feb 2006 21:19:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
Message-ID: <20060202201943.GB2264@elf.ucw.cz>
References: <43DEA195.1080609@tmr.com> <20060201210433.GC8552@ucw.cz> <43E2602C.2090008@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43E2602C.2090008@tmr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-02-06 14:40:28, Bill Davidsen wrote:
> Pavel Machek wrote:
> >On Mon 30-01-06 18:30:29, Bill Davidsen wrote:
> >
> >>Please take this as a question to elicit information, not 
> >>an invitation for argument.
> >>
> >>In Linux currently:
> >>SCSI - liiks like SCSI
> >>USB - looks like SCSI
> >>Firewaire - looks like SCSI
> >>SATA - looks like SCSI
> >>Compact flash and similar - looks like SCSI
> >
> >
> >Your definition of "looks like scsi" is way too broad. CF looks like
> >PCMCIA and that in turn is ide chip on isa-like bus.
> >
> >(unless you plug it to usb reader)
> >
> I was unaware of any serious use of PCMCIA reader cards therese days, as 
> you note the CD shows up as an sd device. I have a laptop which might 
> have a card slot, if it takes CD I'll pull one from my camera and try it 
> there instead of the USB reader.

CD? Did you want to say CF?

Anyway it is not really PCMCIA reader. It is just PCMCIA-to-CF
adapter, plugged into PCMCIA slot. Adapter is pretty much passive. 

> The question is still why not make all devices look like SCSI, and use 
> one set of drivers and a bit of glue. Redhat used to use ide-scsi by 
> default if my memory serves, and the overhead wasn't an issue even back 
> on my 1st Linux laptop running Slackware on a Thinkpad 486-25 (the fat 
> one, not the 486-16 -;).

CF card is as much ide as it can get. You can even pug it to IDE cable
with passive adapter!

Forcing everything to SCSI makes about as much sense as making
everything look like IDE.
							Pavel
-- 
Thanks, Sharp!
