Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbTAATrd>; Wed, 1 Jan 2003 14:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbTAATrd>; Wed, 1 Jan 2003 14:47:33 -0500
Received: from tomts13.bellnexxia.net ([209.226.175.34]:19957 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261693AbTAATrc>; Wed, 1 Jan 2003 14:47:32 -0500
Date: Wed, 1 Jan 2003 14:55:01 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: observations on 2.5 config screens
Message-ID: <Pine.LNX.4.44.0301011435300.27623-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  while i read a recent post stating, essentially, "it's unlikely
that the overall hierarchy of the config screens is going to 
change much," i find the 2.5 layout pretty much as confusing
and illogical as the 2.4 screens.  some petty and not-so-petty
examples and suggestions:

Loadable module support
    
    Does "Module unloading" mean whether or not I can run "rmmod"?
  And if I deselect this, why can I still select "Forced module
  unloading"?  Either I can unload or I can't, no?

    And what's the rationale behind making unloading an option,
  anyway?  If I want loadable module support, is it really a
  big deal to assume I'll want the ability to unload them as
  well?  Just curious, that's all.  Under what circumstances
  would I explicitly *not* want the ability to rmmod?  Tight
  space embedded kernels, possibly?

Processor family

    It seems that the final option, "Preemptible kernel", does
  not belong there.  In fact, there seem to be a number of 
  kernel-related, kind of hacking/debugging options, that
  could be collected in one place, like preemption, sysctl,
  hacking, executable file formats, etc.  "Low-level kernel
  options", perhaps?

Bus options (PCI, PCMCIA, EISA, MCA, ISA)

    First, there's no hint from that heading that hot-pluggable
  settings are hidden under there as well.

    In addition, why does "Bus options" not include the USB bus,
  the I2C bus, FireWire, etc?  A bus is a bus, isn't it?

Multimedia devices

    How come "Sound" is not here?  And (as we've already 
  established), Radio Adapters is not a sub-entry of Video for
  Linux. :-)  (And is there a reason why Amateur Radio Support
  and Radio Adapters are so far apart in the config menus?

Wireless networking/protocols

   Yes, I realize there's no such category, but there *should*
  be, which would include:

	Wireless LAN (non ham-radio)
	Bluetooth
	IrDA


  anyway, just some observations from someone who doesn't
know any better.

rday
	

