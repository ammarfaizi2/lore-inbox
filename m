Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130537AbRBHIFx>; Thu, 8 Feb 2001 03:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130708AbRBHIFm>; Thu, 8 Feb 2001 03:05:42 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:61194 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129694AbRBHIF3>; Thu, 8 Feb 2001 03:05:29 -0500
Date: Thu, 8 Feb 2001 07:59:04 +0000
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PS/2 Mouse/Keyboard conflict and lockup
Message-ID: <20010208075904.A558@colonel-panic.com>
Mail-Followup-To: pdh, "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3A8205D4.7C7E358E@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8205D4.7C7E358E@Hell.WH8.TU-Dresden.De>; from sorisor@Hell.WH8.TU-Dresden.De on Thu, Feb 08, 2001 at 03:35:00AM +0100
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 03:35:00AM +0100, Udo A. Steinberg wrote:
> 
> I'm not sure whether this is related to the ominous ps/2 mouse bug
> you have been chasing, but this problem is 100% reproducible and
> very annoying.
> 
> After upgrading my Asus A7V Bios from 1003 to 1005D, gpm no longer
> receives any mouse events and the mouse doesn't work in text
> consoles. Once I kill gpm and restart gpm -t ps2 the keyboard
> locks up.
> 
> Logging in remotely and looking at dmesg revealed the following:
> 
> keyboard: Timeout - AT keyboard not present?
> keyboard: unrecognized scancode (70) - ignored
> 
> If I don't kill and restart gpm, but start X, the mouse works
> perfectly, but only in X.
> 

Similiar problems here after my upgrade to 1005D. Linux somehow kills
the keyboard if I start the box without a PS/2 mouse connected. I have
another machine (these are both 2.4.1) which is a much older K6-233, and
it too kills the keyboard if no mouse is present. Keyboard works at LILO
prompt but is dead by the time I get to login. GPM doesn't work for me
either.

P.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
