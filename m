Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290054AbSAWUXO>; Wed, 23 Jan 2002 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290059AbSAWUXH>; Wed, 23 Jan 2002 15:23:07 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:65453 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S290054AbSAWUWu>; Wed, 23 Jan 2002 15:22:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Timothy Covell <timothy.covell@ashavan.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Wed, 23 Jan 2002 21:22:41 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201232021440.2202-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201232021440.2202-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020123202258Z290054-13996+10694@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 23. January 2002 20:24, Daniel Nofftz wrote:
> On Thu, 24 Jan 2002, Timothy Covell wrote:
> > Hey, don't get me wrong.  I'm all for power-saving.  That's
> > why I own a Via C3 based system.   The Via C3 works
> > great as an NFS server and draws 12 Watts max (avg.
> > is 6 watts).   For just email and web browsing, I'd definitely
> > recommend it.   I'd also recommend it for a small firewall/router
> > system.   However, for A/V apps and heavy compiling, it's
> > definitely not the way to go [BeOS C3 can handle one
> > A/V app at a time, but not several].
> >
> >
> > If the patch is really the way to go, then we should get it
> > put into the main distribution.  But if it is going to hurt
> > my performance, then I'd be happy to stick with vanilla
> > kapmd (hlt based) power saving.
>
> eenabling the discconect function causes a performance drop of about 2-3 %
> as far as i heared ...

If not smaller. Read the VCool doku.

> but this patch is only for athlon

Athlon and Duron

> processors on an board with via chipset ...

AMD 750/760/maybe MP/MPX, SiS, Ali, Nvidia (?), etc.

> nothing to do with a via c3 cpu :)
> what the patch does is that it make the idle calls take effect on this
> combination of chipset and cpu ...

YES. Without bus disconnet _NO_ real "idle" (cool CPU's).

-Dieter
