Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSIPDwx>; Sun, 15 Sep 2002 23:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318789AbSIPDwx>; Sun, 15 Sep 2002 23:52:53 -0400
Received: from mnh-1-28.mv.com ([207.22.10.60]:2310 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318787AbSIPDwx>;
	Sun, 15 Sep 2002 23:52:53 -0400
Message-Id: <200209160455.XAA04265@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Daniel Jacobowitz <dan@debian.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34 
In-Reply-To: Your message of "Sun, 15 Sep 2002 15:32:23 -0400."
             <20020915193223.GA22800@nevyn.them.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Sep 2002 23:55:54 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dan@debian.org said:
> I run into problems fairly often that I can't reproduce in UML -
> timing sensitive, 

Timing works both ways.  Maybe you run into a bug on native i386 that UML
won't reproduce.  Maybe UML will reproduce bugs you won't see on hardware.
That doesn't help you track down a particular bug you're seeing on hardware,
but as far as overall bug smashing goes, it looks like a wash to me.

> hardware sensitive, etc.  

That's potentially fixable.  UML has SCSI support now, with a USB driver
in the works.  Other hardware access is possible, too.

> UML
> also doesn't use a lot of the code under arch/i386/ (or didn't at
> least) which makes debugging that code under UML a bit futile.

Then we need to push code out from arch into the generic kernel.  That's
happening slowly, but there's a bunch more to go.

				Jeff

