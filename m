Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313482AbSDQTDP>; Wed, 17 Apr 2002 15:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313510AbSDQTDO>; Wed, 17 Apr 2002 15:03:14 -0400
Received: from waste.org ([209.173.204.2]:28084 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S313482AbSDQTCS>;
	Wed, 17 Apr 2002 15:02:18 -0400
Date: Wed, 17 Apr 2002 14:02:00 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
        <linux-usb-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8
 (take 2)
In-Reply-To: <Pine.LNX.4.33.0204171043260.17271-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0204171358570.8537-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Linus Torvalds wrote:

> A "USB device driver" is driver for the mouse/scanner/whatever, ie the
> _other_ end, and that's that. Claiming anything else is just confusing and
> silly.
>
> Since we're talking about the other end of a "host" driver, "client" makes
> sense - in computers, I've always seen "client" as the reverse of the
> "host", but maybe that's just me. Outside of computers, "guest" seems to
> be the proper antonym, but that just strikes me as bizarre (a "USB guest
> driver"?)

Client isn't quite right, as it may imply the other end is 'server'. And
you can certainly think of a USB drive as a 'server' of disk data. Target
is a SCSIism that's too obscure. I suggest 'slave' or a politically
correct variant thereof.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

