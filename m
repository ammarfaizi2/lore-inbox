Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbSLOA3Z>; Sat, 14 Dec 2002 19:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSLOA3Z>; Sat, 14 Dec 2002 19:29:25 -0500
Received: from elin.scali.no ([62.70.89.10]:49418 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S266095AbSLOA3Y>;
	Sat, 14 Dec 2002 19:29:24 -0500
Date: Sun, 15 Dec 2002 01:37:27 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Russell King <rmk@arm.linux.org.uk>
cc: arun4linux <arun4linux@indiatimes.com>,
       Michael Richardson <mcr@sandelman.ottawa.on.ca>, <netdev@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: pci-skeleton duplex check
In-Reply-To: <20021214161446.B23020@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212150131400.1053-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2002, Russell King wrote:

> On Sat, Dec 14, 2002 at 08:05:30PM +0530, arun4linux wrote:
> > Interfaces should NEVER change in patch level versions.
> > Just *DO NOT DO IT*.
> > I do agree on this.
> 
> Rubbish.
> 
> Think about what you've just said.  Patch level version changes are
> things like 2.5.43 to 2.5.44 or 2.4.19 to 2.4.20.
> 
> You are saying that we shouldn't change any interfaces between (eg)
> 2.5.43 and 2.5.44, but we should change every interface we want to
> change between 2.4.15 and 2.5.0.
> 
> This is obviously completely bogus.  2.5 is a _development_ tree.
> Everyone should expect anything, including interfaces to change
> between each development patch level.
> 
> > This is a common complaint about linux kernel developers. And this always
> > gives an insecure feeling  :-) for the device driver or kernel module
> > programmers. 
> 
> If interfaces are changed without extremely good reason between two
> _stable_ patch level versions, that would be a bug.
>

There have been a few during 2.4... The alloc_kiovec stuff for instance 
and zap_page_range. 2.2 was much more stable.

Interface changes in development series is (or atleast should be to 
everyone using linux) a known "feature".

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

