Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267324AbTABXpP>; Thu, 2 Jan 2003 18:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267325AbTABXpO>; Thu, 2 Jan 2003 18:45:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:65287 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267324AbTABXoR>; Thu, 2 Jan 2003 18:44:17 -0500
Date: Thu, 2 Jan 2003 18:50:38 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
In-Reply-To: <Pine.LNX.4.44.0301011435300.27623-100000@dell.qualified-at.bofh.it>
Message-ID: <Pine.LNX.3.96.1030102183855.21114A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Robert P. J. Day wrote:

> Loadable module support
>     
>     Does "Module unloading" mean whether or not I can run "rmmod"?
>   And if I deselect this, why can I still select "Forced module
>   unloading"?  Either I can unload or I can't, no?

I think that one is an error.
>
>     And what's the rationale behind making unloading an option,
>   anyway?  If I want loadable module support, is it really a
>   big deal to assume I'll want the ability to unload them as
>   well?  Just curious, that's all.  Under what circumstances
>   would I explicitly *not* want the ability to rmmod?  Tight
>   space embedded kernels, possibly?

I would encourage Rusty to answer, or you to read the archives.
>
> Processor family
> 
>     It seems that the final option, "Preemptible kernel", does
>   not belong there.  In fact, there seem to be a number of 
>   kernel-related, kind of hacking/debugging options, that
>   could be collected in one place, like preemption, sysctl,
>   hacking, executable file formats, etc.  "Low-level kernel
>   options", perhaps?

This makes sense. Certainly a better term than "kernel hacking" if other
things are included. And stack checking, etc, aren't really hacking
anyway...

> 
> Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> 
>     First, there's no hint from that heading that hot-pluggable
>   settings are hidden under there as well.

Which hot plugging, PCMCIA or PCI? I'm not sure they're a problem where
they are.
> 
>     In addition, why does "Bus options" not include the USB bus,
>   the I2C bus, FireWire, etc?  A bus is a bus, isn't it?

A fine idea.
> 
> Multimedia devices
> 
>     How come "Sound" is not here?  And (as we've already 
>   established), Radio Adapters is not a sub-entry of Video for
>   Linux. :-)  (And is there a reason why Amateur Radio Support
>   and Radio Adapters are so far apart in the config menus?
> 
> Wireless networking/protocols
> 
>    Yes, I realize there's no such category, but there *should*
>   be, which would include:
> 
> 	Wireless LAN (non ham-radio)
> 	Bluetooth
> 	IrDA

On this whole thing, I would say that a more intuitive layout might have
all media interfaces as next level choices, video, sound, etc. Then have
all wireless devices in another menu, possibly with amateur radio as a
submenu, along with anything else which connects with a non-wire.
> 
>   anyway, just some observations from someone who doesn't
> know any better.

Who better to offer idea about what is and isn't intuitive? Kernel config
in 2.4 is just short of an adventure game. 2.5 is getting much better, but
there are parts of it which still don't adhere to Plauger's "law of least
astonishment."

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

