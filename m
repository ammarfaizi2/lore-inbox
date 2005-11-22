Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbVKVV3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbVKVV3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVKVV3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:29:05 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:595 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S965055AbVKVV3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:29:01 -0500
Subject: Re: Christmas list for the kernel
From: Kasper Sandberg <lkml@metanurb.dk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 22:28:55 +0100
Message-Id: <1132694935.10574.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 16:13 -0500, Jon Smirl wrote:
> On 11/22/05, Greg KH <greg@kroah.com> wrote:
> > On Tue, Nov 22, 2005 at 01:31:16PM -0500, Jon Smirl wrote:
> > >
> > > 4) Merge klibc and fix up the driver system so that everything is
> > > hotplugable. This means no more need to configure drivers in the
> > > kernel, the right drivers will just load automatically.
> >
> > What driver subsystem is not hotplugable and does not have automatically
> > loaded modules today?
> 
> All of the legacy stuff - VGA, Vesafb, PS2, serial, parallel,
> joystick, floppy, gameport, etc. Those drivers could be in initramfs
> and only load if the hardware is found. Most of these legacy devices
> have poor sysfs support too. Also, it's not just x86 legacy device all
> of the platforms have them.
> 
> Currently you have to compile most of this stuff into the kernel.
forgive my ignorance, but whats stopping you from doing this now?
> 
> > There are a few issues around PnP devices that I know of, and PCMCIA
> > needs some seriously love, but other than that I think we are well off.
> > Or am I missing something big here?
> >
> > thanks,
> >
> > greg k-h
> >
> 
> 
> --
> Jon Smirl
> jonsmirl@gmail.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

