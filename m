Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266058AbRF1RsZ>; Thu, 28 Jun 2001 13:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266059AbRF1RsQ>; Thu, 28 Jun 2001 13:48:16 -0400
Received: from altus.drgw.net ([209.234.73.40]:13836 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S266058AbRF1Rr7>;
	Thu, 28 Jun 2001 13:47:59 -0400
Date: Thu, 28 Jun 2001 12:47:38 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: lar@cs.york.ac.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010628124738.O8027@altus.drgw.net>
In-Reply-To: <20010627225421.A23843@vitelus.com> <JKEGJJAJPOLNIFPAEDHLKECBDEAA.laramie.leavitt@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <JKEGJJAJPOLNIFPAEDHLKECBDEAA.laramie.leavitt@btinternet.com>; from laramie.leavitt@btinternet.com on Thu, Jun 28, 2001 at 09:39:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 09:39:15AM +0100, Laramie Leavitt wrote:
> > On Wed, Jun 27, 2001 at 01:50:28PM -0700, Linus Torvalds wrote:
> > > How about we drop the "printk" altogether, and make it all a comment?
> >
> > Can we please also drop annoying static informational printk's?
> >
> > > Linux NET4.0 for Linux 2.4
> > > Based upon Swansea University Computer Society NET3.039
> >
> > The later line is not something of interest to most people, and if it
> > happens to be they can research it rather than being force-fed history
> > on bootup.
> >
> > > POSIX conformance testing by UNIFIX
> >
> > Ditto.
> >
> > > usb-uhci.c: v1.251 Georg Acher, Deti Fliegl, Thomas Sailer,
> > Roman Weissgaerber
> > > usb-uhci.c: USB Universal Host Controller Interface driver
> >
> > How about "usb-uhci.c: USB Universal Host Controller Interface
> > driver v1.251"
> > instead?
> >
> > dmesg buffer space is rather limited and IMHO there isn't space to
> > waste on credit-giving in boot logs.
> 
> Here here.  You don't see annoying log-eating copyright messages
> printed out in the Windows boot. Just imagine:

Whoaa, back the truck up you just threw all those log messages in.

One of the reasons I absolutely HATED windoze was that it didn't tell you 
ANYTHING about what it was doing when booting. If it died during bootup 
you had no idea what driver was loading.

Yes, *some* of the boot messageses are excessive, but I don't know how
many times I've been able to diagnose a hardware problem or been helped by
verbose boot messages on some strange hardware I was trying to bring up, 
and the 'what was the last message printed out' has been invaluable.

> Initializing VGA Display.  VGA Display by John Smith, John Smith, Jr.
> Bill T. Gates, Paul G. Allen, Janet K. Reno.  Copyright(c) 1985 Microsoft.
> Loading Microsoft ATAPI.  Microsoft ATAPI Copyright (c) 1983-2001 Microsoft.
> Scanning Microsoft SCSI Layer.  Portions Copyright (c) 1992 Harold Potter.
> Microsoft SCSI Layer developed in part by Seagate Corporation.
> Starting Microsoft Display Device.  Display based on Microsoft VESA
> Extensions.
> Display layer Copyright(c) 1983-2001 Microsoft.
> Loading Creative Diamond Viper V770 Display Driver.
> Diamond Viper V770 Display driver Copyright(c) 1999 Diamond Multimedia.
> Diamond Viper V770 Display driver based on NVIDIA TNT2 Display Driver.
> NVIDIA TNT2 Copyright(c) 1998-1999 NVIDIA Corporation.
> Scanning Network Devices...
> WinSock 2000.  Copyright(c) 1990-2001 Microsoft.
> WinSock 2000 Contributors include: John Doe, Jane Doe, Ed Smith, Herman
> Melville.
> Starting WinsockDirect.  Winsock Direct Copyright(c) 1999 Microsoft.
> WinsockDirect supported by 3COM Corporation, Intel Corporation.


-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
