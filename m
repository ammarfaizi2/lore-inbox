Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311483AbSDQR6z>; Wed, 17 Apr 2002 13:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311536AbSDQR6y>; Wed, 17 Apr 2002 13:58:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43282 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311483AbSDQR6w>; Wed, 17 Apr 2002 13:58:52 -0400
Date: Wed, 17 Apr 2002 10:57:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Brownell <david-b@pacbell.net>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8
 (take 2)
In-Reply-To: <074401c1e629$0a9ea020$6800000a@brownell.org>
Message-ID: <Pine.LNX.4.33.0204171043260.17271-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Apr 2002, David Brownell wrote:
>
> ... except that this code does NOT follow those conventions, as
> I've argued.  And "client" is explicitly contrary to the USB spec,
> which uses that as a host-side phrase (though not often).

Note that the relevance of the USB spec to most people is exactly 0%.

"USB device" is what people say about the things you call "clients". The
real world takes precedence, and there is absolutely _no_ way a Linux "USB
device driver" will ever mean that the driver turns the box into a USB
device.

A "USB device driver" is driver for the mouse/scanner/whatever, ie the
_other_ end, and that's that. Claiming anything else is just confusing and
silly.

Since we're talking about the other end of a "host" driver, "client" makes
sense - in computers, I've always seen "client" as the reverse of the
"host", but maybe that's just me. Outside of computers, "guest" seems to
be the proper antonym, but that just strikes me as bizarre (a "USB guest
driver"?)

What were the other suggestions?

		Linus

