Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbSKOWRh>; Fri, 15 Nov 2002 17:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266818AbSKOWRh>; Fri, 15 Nov 2002 17:17:37 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:59599 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S266809AbSKOWRg>; Fri, 15 Nov 2002 17:17:36 -0500
Date: Fri, 15 Nov 2002 23:24:30 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021115222430.GA1877@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar3op8$f20$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 09:26:00PM +0000, Linus Torvalds wrote:

> I dunno. I might even be willing to apply kgdb patches to my tree if it
> just could use the regular network card I already have connected on all
> my machines. None of my laptops have a serial line, for example, but
> they all have networking.
> 
> Soon even _desktops_ probably won't have serial lines any more, only USB.

Using USB instead of the serial line or the network card would be
the best IMHO, because:

	* many machines have network cards, but all machines have USB
	  (and it's gonna stay this way for some time)
	  
	* the USB stack seems simpler than the net stack + 
	  (eventualy) pcmcia + network card driver.

Maybe the 'simpler' USB protocols (usbkbd and usbmouse) could be
used for this, I don't know...

Stelian, which has a Vaio Picturebook without a serial port.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
