Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313138AbSDQSmL>; Wed, 17 Apr 2002 14:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313157AbSDQSmK>; Wed, 17 Apr 2002 14:42:10 -0400
Received: from DHCP-88-97.SLAC.Stanford.EDU ([134.79.88.97]:14233 "EHLO
	antonia.slac.stanford.edu") by vger.kernel.org with ESMTP
	id <S313138AbSDQSmJ>; Wed, 17 Apr 2002 14:42:09 -0400
Date: Wed, 17 Apr 2002 11:41:14 -0700 (PDT)
From: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
X-X-Sender: gowdy@router-273.sgowdy.org
Reply-To: gowdy@slac.stanford.edu
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
        <linux-usb-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8
 (take 2)
In-Reply-To: <Pine.LNX.4.33.0204171043260.17271-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0204171140450.1793-100000@router-273.sgowdy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gadget? non-host?

On Wed, 17 Apr 2002, Linus Torvalds wrote:

> 
> 
> On Wed, 17 Apr 2002, David Brownell wrote:
> >
> > ... except that this code does NOT follow those conventions, as
> > I've argued.  And "client" is explicitly contrary to the USB spec,
> > which uses that as a host-side phrase (though not often).
> 
> Note that the relevance of the USB spec to most people is exactly 0%.
> 
> "USB device" is what people say about the things you call "clients". The
> real world takes precedence, and there is absolutely _no_ way a Linux "USB
> device driver" will ever mean that the driver turns the box into a USB
> device.
> 
> A "USB device driver" is driver for the mouse/scanner/whatever, ie the
> _other_ end, and that's that. Claiming anything else is just confusing and
> silly.
> 
> Since we're talking about the other end of a "host" driver, "client" makes
> sense - in computers, I've always seen "client" as the reverse of the
> "host", but maybe that's just me. Outside of computers, "guest" seems to
> be the proper antonym, but that just strikes me as bizarre (a "USB guest
> driver"?)
> 
> What were the other suggestions?
> 
> 		Linus
> 
> 
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
> 

-- 
 /------------------------------------+-------------------------\
|Stephen J. Gowdy                     | SLAC, MailStop 34,       |
|http://www.slac.stanford.edu/~gowdy/ | 2575 Sand Hill Road,     |
|http://calendar.yahoo.com/gowdy      | Menlo Park CA 94025, USA |
|EMail: gowdy@slac.stanford.edu       | Tel: +1 650 926 3144     |
 \------------------------------------+-------------------------/

