Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130856AbRBAUEO>; Thu, 1 Feb 2001 15:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131280AbRBAUEE>; Thu, 1 Feb 2001 15:04:04 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:56594
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130856AbRBAUDx>; Thu, 1 Feb 2001 15:03:53 -0500
Date: Thu, 1 Feb 2001 12:03:29 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ian Soboroff <ian@cs.umbc.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide hotplug and 2.4.1
In-Reply-To: <87hf2eo4w9.fsf@danube.cs.umbc.edu>
Message-ID: <Pine.LNX.4.10.10102010947060.16224-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nope........you have to wack subdrivers and flush things.
Cheers,

On 1 Feb 2001, Ian Soboroff wrote:

> 
> i've started playing with 2.4.1 on my Dell Latitude CS and it's pretty
> peppy; my only complaints are PCMCIA-related, which i think i'll solve
> by using the standalone package...
> 
> anyway, my real question is this.  i noticed the new options for
> hotplug, and am wondering if i can use this with my laptop.  the
> Latitude CS has a port on the side, with which you can connect a cable
> that hooks up to either a floppy drive or a CDROM.
> 
> if you boot the machine cold with the CDROM attached, linux notices it
> on a second IDE bus (/dev/hdc).  if you boot without it, /dev/hdc
> isn't there.  if you plug in the CDROM while the system is running,
> there is a noticeable pause for a couple seconds, which seems to imply
> some kind of BIOS action or interrupt or something happens which could
> be caught.
> 
> back in 2.2.x, i used to build IDE as a module, and after plugging up
> the CDROM do a 'rmmod ide-probe; modprobe ide-probe' which had a
> pretty good success rate.  i'm hoping maybe the 2.4.x hotplug features
> have made this obsolete.
> 
> (plugging up the floppy drive always works, because PC floppy
> controllers are too dumb to care if they actually have a drive
> attached).
> 
> ian
> 
> -- 
> ----
> Ian Soboroff                                       ian@cs.umbc.edu
> University of MD Baltimore County      http://www.cs.umbc.edu/~ian
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
