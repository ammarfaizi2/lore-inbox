Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263179AbVG3W1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbVG3W1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 18:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbVG3W1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 18:27:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31250 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263161AbVG3W07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 18:26:59 -0400
Date: Sat, 30 Jul 2005 23:26:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Grant Coady <lkml@dodo.com.au>
Cc: Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Heads up for distro folks: PCMCIA hotplug differences (Re: -rc4: arm broken?)
Message-ID: <20050730232652.P26592@flint.arm.linux.org.uk>
Mail-Followup-To: Grant Coady <lkml@dodo.com.au>,
	Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050730130406.GA4285@elf.ucw.cz> <1122741937.7650.27.camel@localhost.localdomain> <20050730201508.B26592@flint.arm.linux.org.uk> <20050730223628.M26592@flint.arm.linux.org.uk> <7pune19t9m9cgdacv8b5r3djpqvk28nipu@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7pune19t9m9cgdacv8b5r3djpqvk28nipu@4ax.com>; from lkml@dodo.com.au on Sun, Jul 31, 2005 at 08:17:29AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 08:17:29AM +1000, Grant Coady wrote:
> On Sat, 30 Jul 2005 22:36:28 +0100, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> >Let me qualify that, because it's not 100% fine due to the changes in
> >PCMCIA land.
> >
> >Since PCMCIA cards are detected and drivers bound at boot time, we no
> 
> Without an unbind/eject option?  Implies reboot to remove a device...

No.  You can still use cardctl (or whatever the pcmciautils version
of that is) to eject cards, and you can of course still pull them
from the socket.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
