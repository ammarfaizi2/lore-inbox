Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289988AbSAWT01>; Wed, 23 Jan 2002 14:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289989AbSAWTZk>; Wed, 23 Jan 2002 14:25:40 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:16091 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290000AbSAWTZC>; Wed, 23 Jan 2002 14:25:02 -0500
Date: Wed, 23 Jan 2002 20:24:57 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Dave Jones <davej@suse.de>, Andreas Jaeger <aj@suse.de>,
        Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <200201231813.g0NID5r15047@home.ashavan.org.>
Message-ID: <Pine.LNX.4.40.0201232021440.2202-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Timothy Covell wrote:

> Hey, don't get me wrong.  I'm all for power-saving.  That's
> why I own a Via C3 based system.   The Via C3 works
> great as an NFS server and draws 12 Watts max (avg.
> is 6 watts).   For just email and web browsing, I'd definitely
> recommend it.   I'd also recommend it for a small firewall/router
> system.   However, for A/V apps and heavy compiling, it's
> definitely not the way to go [BeOS C3 can handle one
> A/V app at a time, but not several].
>
>
> If the patch is really the way to go, then we should get it
> put into the main distribution.  But if it is going to hurt
> my performance, then I'd be happy to stick with vanilla
> kapmd (hlt based) power saving.

eenabling the discconect function causes a performance drop of about 2-3 %
as far as i heared ... but this patch is only for athlon processors on an
board with via chipset ... nothing to do with a via c3 cpu :)
what the patch does is that it make the idle calls take effect on this
combination of chipset and cpu ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

