Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSIPBR0>; Sun, 15 Sep 2002 21:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318383AbSIPBR0>; Sun, 15 Sep 2002 21:17:26 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:36092
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318369AbSIPBRZ>; Sun, 15 Sep 2002 21:17:25 -0400
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020915162412.A17345@work.bitmover.com>
References: <E17qRfU-0001qz-00@starship>
	<Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com>
	<20020915190435.GA19821@nevyn.them.org> 
	<20020915162412.A17345@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 16 Sep 2002 02:23:23 +0100
Message-Id: <1032139403.26857.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 00:24, Larry McVoy wrote:
> My position is that you either understand the code or you don't.  Code
> that you don't understand is read only.  Having a debugger show you some
> variables isn't going to make you understand the code at the level which
> is required in order to be making changes.

It isnt about understanding the code. You issue a perfectly valid
command to your scsi driver. Your ethernet crashes. All your code is
perfect. 

Thats a real scenario. In fact thats a horribly common scenario, and the
kind of thing I have to deal with every day of the week because I debug
driver code. 

Understanding your own code by using a debugger (or printk) to see what
is does is not good practice. Understanding misdocumented or crap code
often needs a debugger to see what is going on, and to be able to
understand how to fix it. The moment you hit the hardware layer the fun
really begins, and you need the debugger, not to understand your code
flow but to snoop around the machine to see what the device did or
didn't do.

