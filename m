Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270609AbTGNQjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270604AbTGNQjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:39:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65028 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270609AbTGNQiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:38:01 -0400
Date: Mon, 14 Jul 2003 17:52:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Sven Dowideit <svenud@ozemail.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mis-identified cisco aironet pccard (and Re: hang with pcmcia wlan card)
Message-ID: <20030714175243.B1076@flint.arm.linux.org.uk>
Mail-Followup-To: jt@hpl.hp.com, Sven Dowideit <svenud@ozemail.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1058100731.778.5.camel@localhost> <20030714164852.GC22238@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030714164852.GC22238@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Mon, Jul 14, 2003 at 09:48:52AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 09:48:52AM -0700, Jean Tourrilhes wrote:
> On Sun, Jul 13, 2003 at 10:57:58PM +1000, Sven Dowideit wrote:
> > Hi,
> > i just noticed with 2.5.75 that if I boot with the cisco airo 340 wifi
> > card in, this kernel thinks it is a memory card. when i remove it and
> > re-insert it after boot, it then works .... see the following log :) I
> > am running debian unstable, on an ibm t21 pIII-850 notebook
> > 
> > the cisco card works at boot time using 2.5.70.
> > 
> > as for the two patches for the pcmcia hang, this time i am running the
> > one Russell posted, but the result is the same for the other.
> > 
> > as i shutdown i get a number of kernel stack dumps related to airo_stat,
> > but the machine reboots before i can do anything about them..(what do i
> > need to log them?)
> > 
> > if i replace the cisco card with a dlink orinoco card, it get recognised
> > correctly at boot. 
> > 
> > to make this story more interesting, i put the thinkpad into the docking
> > station and the cisco card into the dock's pccard (something that has
> > locked up 2.5 every time that i tried it), and the card is recogised
> > correctly at boot, and runs fine (there was a kernel stack dump during
> > boot - *what do i need to do to get them logged?*)
> > 
> > thanks for the great work!
> > 
> > sven
> 
> 	I've seen this bug come and go in the 2.5.X serie. I believe
> this is because of the various work happening in the Pcmcia
> layer. Please contact Dominik Brodowski <linux@brodo.de>.

I think this may be my fault, but I haven't head a clear bug report for
it yet; I've only seen vague references to something going wrong with
aero cards on lkml yesterday, referring to what seemed to be a non-
existent thread.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

