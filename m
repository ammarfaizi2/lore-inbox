Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVLOOoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVLOOoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVLOOnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:43:35 -0500
Received: from melos.informatik.uni-rostock.de ([139.30.241.22]:1035 "EHLO
	melos.informatik.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750736AbVLOOnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:43:17 -0500
From: Denny Priebe <spamtrap@siglost.org>
Date: Thu, 15 Dec 2005 15:42:54 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repeated USB disconnect and reconnect with Wacom Intuos3 6x11 tablet
Message-ID: <20051215144254.GA19794@nostromo.dyndns.info>
References: <20051213184600.GA4283@nostromo.dyndns.info> <20051213193832.GA14047@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213193832.GA14047@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 11:38:32AM -0800, Greg KH wrote with possible deletions:

Hello,

> > These disconnects and reconnects disappear as soon as there's 
> > a process reading either /dev/input/mouse0 or /dev/input/event5 
> > (mouse0 and event5 according to my setup).

> Sounds like a hardware problem, the kernel can't cause a device to
> electronically disconnect itself like this.

thanks for your reply, Greg.
 
> I suggest plugging this into a different port, using a powered hub, or
> checking that the cable is still good.

I tried what you have suggested. Unfortunately, this doesn't change 
anything.

What confuses me a bit is that theses USB disconnects do not appear
as soon as I read what the tablet provides.

Could it be that the usb driver doesn't check for a connect status change
while there's a process reading /dev/input/{mouse,event}? so that I do not
see these disconnects while reading the tablet data? 

Or could it be that something prevents the tablet from disconnecting itself
when a process is reading the tablet data?

Regards,
Denny
