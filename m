Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbUCJSHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUCJSHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:07:36 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:53436 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S262749AbUCJSGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:06:07 -0500
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
From: Disconnect <lkml@sigkill.net>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200403101015.19506.vda@port.imtp.ilyichevsk.odessa.ua>
References: <404E27E6.40200@linux.co.intel.com>
	 <1078866774.2925.15.camel@mentor.gurulabs.com>
	 <200403101015.19506.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1078941969.14394.41.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 13:06:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-10 at 03:15, vda wrote:
> *FLAME ALERT*
> /me is slowly getting mad about his prism54 11g hardware
> and its firmware, with neither firmware authors nor documentation
> for this pile of silicon crap nowhere in sight
> 
> What's so cool about having binary firmware? Bugs are bugs,
> and you won't be able to even see bugs, less fix, in it.
> I don't like being at the mercy of firmware authors.
> --
> vda

Short list of places you have binary firmware, in no particular order:
 - BIOS
 - Hard drives
 - CD/DVD ROM/RAM/RW/R/...
 - Controller for drives
 - Video card (regardless of open/closed driver status)
 - Sound card
 - Most 100M+ NICs
 - LCD display panels
 - CRT displays
 - KVMs
 - Printers more advanced than daisy-wheel
 - Some older daisy-wheel printers
 - Networking gear of all forms more complex than a cat5 inline
 - USB->* (usb->serial, usb->parallel, that sort of thing)

..and to go a little farther:

 - Microwave, Dishwasher, Clothes Washing machine (maybe not the latter,
since cogs/gears is sorta open source...)
 - TV
 - TV Cable/Sat Box
 - Tivo (yep, OS is linux. with lots of binary goo. but the loader
isn't..)
 - PDA (unless it runs - eg - CRL's arm bootldr)
 - Cellphone
 - Cordless phone
 - Some corded phones
 - Car, car radio, radar detector (if applicable)
 - Digital/crystal watch (analog-with-gears falls under sorta-open)
 - Many fridge/freezers
 - Many newer coffee makers

I'm curious as to how you go through life avoiding all that.  (For that
matter, hardware designers have you even more at their mercy than
firmware authors....)

I suspect the real beef here is -undocumented- firmware.  With api docs
the vast majority of bugs could be worked around, and some could be
fixed. (Its a 'firmware bug' if doing something that seems legit causes
failure. Its a driver bug if the firmware docs say "this has these
[currently undocumented] side-effects, so don't follow it with
'that'"..)

-- 
Disconnect <lkml@sigkill.net>

