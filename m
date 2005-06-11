Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVFKTk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVFKTk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVFKTk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:40:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35334 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261783AbVFKThb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:37:31 -0400
Date: Sat, 11 Jun 2005 21:37:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: John covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org, cramerj@intel.com, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, netdev@oss.sgi.com
Subject: Re: e1000 not working using 2.6.11
Message-ID: <20050611193729.GJ3770@stusta.de>
References: <17064.41290.461755.920152@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17064.41290.461755.920152@ccs.covici.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 04:06:34PM -0400, John covici wrote:

> Hi.  I am not getting good results on a box I have which uses an Intel
> Pro gigabit Ethernet driver for its network connection.  What happens
> is that I get messages like watchdog xmit timeout and lots of errors
> out of ifconfig.  Here is the listpci entry for that card.  It works
> under the other OS, so I imagine the hardware is OK.
> 
> 0000:01:0b.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
>         Subsystem: Intel Corp.: Unknown device 3013
>         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 19
>         Memory at e7000000 (64-bit, non-prefetchable) [size=128K]
>         Memory at e7020000 (64-bit, non-prefetchable) [size=64K]
>         I/O ports at b400 [size=64]
>         Capabilities: [dc] Power Management version 2
>         Capabilities: [e4] PCI-X non-bridge device.
>         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
> 
> 
> Any assistance would be appreciated.

Does 2.6.12-rc6 work?

If not, the maintainers of this driver (Cc'ed) might be able to help 
you.

>          John Covici

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

