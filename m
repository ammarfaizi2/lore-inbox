Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316295AbSELCNm>; Sat, 11 May 2002 22:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316297AbSELCNl>; Sat, 11 May 2002 22:13:41 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:50466 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S316295AbSELCNj>; Sat, 11 May 2002 22:13:39 -0400
Date: Sun, 12 May 2002 04:13:00 +0200 (CEST)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@localhost.localdomain
To: Urban Widmark <urban@teststation.com>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Via-rhine problems (2.4.19-pre8)
In-Reply-To: <Pine.LNX.4.33.0205111911360.18398-100000@cola.enlightnet.local>
Message-ID: <Pine.LNX.4.44.0205120405010.1365-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002, Urban Widmark wrote:

> On Sat, 11 May 2002, Rui Sousa wrote:
> 
> > kernel: eth0: reset did not complete in 10 ms.
> > kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > kernel: eth0: Transmit timed out, status 0000, PHY status 782d, 
> > resetting...
> > 
> > Removing the ethernet cable, unloading/loading the module doesn't change a
> > thing, only a cold reboot fixes the problem (until next time).
> > 
> > Is this a known problem? Any fixes?
> 
> The effect (the timeout) can be caused by lots of things. Here it sounds
> like the chip has locked up (more or less) since you need a cold boot to
> recover.

Yep. The normal soft reset stops working.

> Why? Well ...
> 
> "Ivan G" has posted recently on via-rhine problems. For him it is only
> that the driver stalls but not the need for a full reboot (IIRC).
> 
> Simple things you could try is to test some other variants of the driver:
>  + Donald Becker's original
>    http://www.scyld.com/network/via-rhine.html
>  + VIAs modified version
>    http://www.viaarena.com/?PageID=71#lan
> 
> If either works better then the next step would be to find out why (and 
> copy those bits).
> 
> The diff between the VIA version and the other is large. I started looking
> at merging what they have done to the in-kernel driver.
> 
> /Urban
> 

Jeff sent me is latest version and I'm already trying it out. I loaded it
with full debug on to see if something interesting happens before the 
transmit/reset timeout errors. Now I just need to wait a couple of 
days...

I will keep you two informed on any developments,

Rui

