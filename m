Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267833AbTBKR1x>; Tue, 11 Feb 2003 12:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267869AbTBKR1x>; Tue, 11 Feb 2003 12:27:53 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:49541 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267833AbTBKR1x>; Tue, 11 Feb 2003 12:27:53 -0500
Date: Tue, 11 Feb 2003 11:37:50 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: ebuddington@wesleyan.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60-i386 freezes after decompress on Athlon
In-Reply-To: <20030211120033.B27012@ma-northadams1b-418bur.adelphia.net>
Message-ID: <Pine.LNX.4.44.0302111130530.3897-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003, Eric Buddington wrote:

> 2.5.60, compiled for i386 but running on an Athlon, darn near
> everything as modules.
> 
> I get the standard "Uncompressing linux... booting" on boot, then a
> hard freeze; no keyboard LED response, no SysRq reboot.
> 
> I tried with acpi=off, same result.
> 
> I initially assumed that console traffic was directed elsewhere, but
> VGA console is compiled in and vga=6 specified on the GRUB boot line.
> 
> 2.4.20 works fine on this system, 2.5.58 at least boots.
> 
> I have no idea what to try next.

Try making all your input layer as built in rather than modules.  Check 
your console specification.  If you have framebuffer support compiled in, 
make sure you have console on framebuffer enabled also.

I've run into something similar-sounding as I've been playing with 2.5.59 
and later.  It's looking as if people need to be very careful about how 
they specify console support.

