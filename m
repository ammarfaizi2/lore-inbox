Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288076AbSACBCe>; Wed, 2 Jan 2002 20:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288075AbSACBCY>; Wed, 2 Jan 2002 20:02:24 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:25358 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288074AbSACBCK>;
	Wed, 2 Jan 2002 20:02:10 -0500
Date: Wed, 2 Jan 2002 17:01:07 -0800
From: Greg KH <greg@kroah.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange USB issues...
Message-ID: <20020103010106.GO3054@kroah.com>
In-Reply-To: <1010017950.20263.7.camel@unaropia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1010017950.20263.7.camel@unaropia>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 05 Dec 2001 19:35:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 07:32:02PM -0500, Shawn Starr wrote:
> I have a Pentium 200Mhz AMD Bios (home machine):
> 
> USB 1.0 - 2 ports

Ouch.  Watch out when using a hub.  They generally want 1.1 support.

> The bios has 2 options:
> 
> Enable USB controller and enable USB legacy stuff. 
> 
> If I turn on USB and boot to a Linux kernel WITH NO USB support compiled
> in. I get:
> 
> 1) Slow loading of kernel into memory on bootup
> 2) AT keyboard timeout (?) errors and no activity with the keyboard
> (shift lock/numlock/scroll lock). I  have to reboot to correct the
> problem by disabling USB in the bios.

Do you only have a USB keyboard, and no PS2 keyboard attached?
Is the "Enable USB legacy" stuff enabled in your bios?

Does things work better if you load the usb host controller for your
machine?

thanks,

greg k-h
