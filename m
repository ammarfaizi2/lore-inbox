Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265455AbRF1Jas>; Thu, 28 Jun 2001 05:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265611AbRF1Jai>; Thu, 28 Jun 2001 05:30:38 -0400
Received: from zeus.kernel.org ([209.10.41.242]:12939 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265455AbRF1Ja3>;
	Thu, 28 Jun 2001 05:30:29 -0400
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Cosmetic JFFS patch.
Date: Thu, 28 Jun 2001 09:39:15 +0100
Message-ID: <JKEGJJAJPOLNIFPAEDHLKECBDEAA.laramie.leavitt@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010627225421.A23843@vitelus.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jun 27, 2001 at 01:50:28PM -0700, Linus Torvalds wrote:
> > How about we drop the "printk" altogether, and make it all a comment?
>
> Can we please also drop annoying static informational printk's?
>
> > Linux NET4.0 for Linux 2.4
> > Based upon Swansea University Computer Society NET3.039
>
> The later line is not something of interest to most people, and if it
> happens to be they can research it rather than being force-fed history
> on bootup.
>
> > POSIX conformance testing by UNIFIX
>
> Ditto.
>
> > usb-uhci.c: v1.251 Georg Acher, Deti Fliegl, Thomas Sailer,
> Roman Weissgaerber
> > usb-uhci.c: USB Universal Host Controller Interface driver
>
> How about "usb-uhci.c: USB Universal Host Controller Interface
> driver v1.251"
> instead?
>
> dmesg buffer space is rather limited and IMHO there isn't space to
> waste on credit-giving in boot logs.

Here here.  You don't see annoying log-eating copyright messages
printed out in the Windows boot. Just imagine:

Initializing VGA Display.  VGA Display by John Smith, John Smith, Jr.
Bill T. Gates, Paul G. Allen, Janet K. Reno.  Copyright(c) 1985 Microsoft.
Loading Microsoft ATAPI.  Microsoft ATAPI Copyright (c) 1983-2001 Microsoft.
Scanning Microsoft SCSI Layer.  Portions Copyright (c) 1992 Harold Potter.
Microsoft SCSI Layer developed in part by Seagate Corporation.
Starting Microsoft Display Device.  Display based on Microsoft VESA
Extensions.
Display layer Copyright(c) 1983-2001 Microsoft.
Loading Creative Diamond Viper V770 Display Driver.
Diamond Viper V770 Display driver Copyright(c) 1999 Diamond Multimedia.
Diamond Viper V770 Display driver based on NVIDIA TNT2 Display Driver.
NVIDIA TNT2 Copyright(c) 1998-1999 NVIDIA Corporation.
Scanning Network Devices...
WinSock 2000.  Copyright(c) 1990-2001 Microsoft.
WinSock 2000 Contributors include: John Doe, Jane Doe, Ed Smith, Herman
Melville.
Starting WinsockDirect.  Winsock Direct Copyright(c) 1999 Microsoft.
WinsockDirect supported by 3COM Corporation, Intel Corporation.
...

There would be no end to the suffering...


