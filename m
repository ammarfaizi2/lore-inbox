Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTAAT6y>; Wed, 1 Jan 2003 14:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbTAAT6y>; Wed, 1 Jan 2003 14:58:54 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:1216 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262394AbTAAT6w>; Wed, 1 Jan 2003 14:58:52 -0500
Date: Wed, 1 Jan 2003 21:07:17 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
Message-ID: <20030101200717.GA17053@louise.pinerecords.com>
References: <Pine.LNX.4.44.0301011435300.27623-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301011435300.27623-100000@dell>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Does "Module unloading" mean whether or not I can run "rmmod"?
>   And if I deselect this, why can I still select "Forced module
>   unloading"?  Either I can unload or I can't, no?
>
>     And what's the rationale behind making unloading an option,
>   anyway?  If I want loadable module support, is it really a
>   big deal to assume I'll want the ability to unload them as
>   well?  Just curious, that's all.  Under what circumstances
>   would I explicitly *not* want the ability to rmmod?  Tight
>   space embedded kernels, possibly?

These two are for Rusty to answer.

>     It seems that the final option, "Preemptible kernel", does
>   not belong there.  In fact, there seem to be a number of 
>   kernel-related, kind of hacking/debugging options, that
>   could be collected in one place, like preemption, sysctl,
>   hacking, executable file formats, etc.  "Low-level kernel
>   options", perhaps?

Should go to "General config" IMHO.

> Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> 
>     First, there's no hint from that heading that hot-pluggable
>   settings are hidden under there as well.

Well, PCMCIA pretty much suggests that, doesn't it?

>     In addition, why does "Bus options" not include the USB bus,
>   the I2C bus, FireWire, etc?  A bus is a bus, isn't it?

Yes, this is a valid comment.  Placing USB under "Bus options"
should be totally straightforward, but that one's for Greg KH
to decide.

> Multimedia devices
> 
>     How come "Sound" is not here?  And (as we've already
>   established), Radio Adapters is not a sub-entry of Video for
>   Linux. :-)  (And is there a reason why Amateur Radio Support
>   and Radio Adapters are so far apart in the config menus?

Yeah, this one is a puzzle. <g>

> Wireless networking/protocols
> 
>    Yes, I realize there's no such category, but there *should*
>   be, which would include:
> 
> 	Wireless LAN (non ham-radio)
> 	Bluetooth
> 	IrDA

IrDA isn't necessarily networking, Bluetooth either.
Wireless LAN is where it should be.

>   anyway, just some observations from someone who doesn't
> know any better.

Thanks.

-- 
Tomas Szepe <szepe@pinerecords.com>
