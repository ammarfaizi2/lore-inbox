Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263533AbTC3KNF>; Sun, 30 Mar 2003 05:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263534AbTC3KNF>; Sun, 30 Mar 2003 05:13:05 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:10631 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263533AbTC3KNE>; Sun, 30 Mar 2003 05:13:04 -0500
Subject: Re: 2.5 and modules ?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048991950.1542.13.camel@tiger>
References: <1048564993.2994.13.camel@tiger>
	 <Pine.LNX.4.51.0303251219250.9373@dns.toxicfilms.tv>
	 <1048636973.1569.20.camel@tiger>  <1048638632.1176.4.camel@teapot>
	 <1048991950.1542.13.camel@tiger>
Content-Type: text/plain
Organization: 
Message-Id: <1049019855.597.13.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 30 Mar 2003 12:24:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-30 at 04:39, Louis Garcia wrote:
> One more question if you don't mind. These are the only errors I have
> left as boot. Are these not present in 2.5?
> 
> 
> Setting hostname tiger:                              [  OK  ]
> Initializing USB controller (usb-uhci):              [  OK  ]
> Mounting USB filesystem:                             [  OK  ]
> Initializing USB HID interface:                      [  OK  ]
> Initializing USB Keyboard: FATAL: Module keybdev not found.
>                                                      [ FAILED ]
> Initializing USB Mouse: FATAL: Module mousedev not found.
>                                                      [ FAILED ]

Did you compile USB HID input drivers as modules? IIRC, the keybdev
module is not named that way anymore in 2.5 kernels, so the "keybdev not
found" error is normal.

I was getting those errors on 2.5, and they were normal for me as I did
compile all the USB support built-in into the kernel, so there were no
USB modules to load. I had to edit /etc/rc.sysinit and remove a bunch of
stuff to get them away.

        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

