Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbRLXT1k>; Mon, 24 Dec 2001 14:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285261AbRLXT1b>; Mon, 24 Dec 2001 14:27:31 -0500
Received: from h24-79-117-128.vc.shawcable.net ([24.79.117.128]:22532 "EHLO
	mail.howlingfrog.com") by vger.kernel.org with ESMTP
	id <S285229AbRLXT1M>; Mon, 24 Dec 2001 14:27:12 -0500
Message-Id: <200112241928.fBOJS8Ea015456@mail.howlingfrog.com>
Content-Type: text/plain; charset=US-ASCII
From: Graham TerMarsch <graham@howlingfrog.com>
Organization: Howling Frog
To: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-usb-users] VIA Chipsets + USB + SMP == UGLY TRASH
Date: Mon, 24 Dec 2001 11:26:43 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E16IRTQ-0003oN-00@s.automatix.de> <20011224104724.B8215@kroah.com>
In-Reply-To: <20011224104724.B8215@kroah.com>
X-Notice: Duplication and redistribution without consent of author is strictly prohibited.
X-Copyright: Copyright (C) Graham TerMarsch.  All rights Reserved
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 December 2001 10:47, Greg KH wrote:
> On Mon, Dec 24, 2001 at 10:32:49AM +0100, Juergen Sauer wrote:
> > Hi!
> > Merry X-Mas everywhere !
> >
> > So, my USB tryout is over.
> > This is the expierience report:
> > You should not try to use VIA Chipsets + SMP + USB, that's
> > the worst thinkable idea. It's junk (usb-Part).
>
> Depends on the motherboard.  What one do you have?

I've had similar problems here on an AOpen AK73Pro(A) motherboard.  Its a 
single-processor board based on KT133A, and since 2.4.3 haven't been able 
to get USB working on it at all.

Dug through the old USB-users mailing lists and tried a wide variety of 
things; "noapic", changing IRQs, PnP On/Off in the BIOS, but had no luck.  
Best I was able to discern was that the board is using MPS1.4 but has no 
option in the BIOS to switch it back to MPS1.1.

Would love to get it working so that I could finally get my Epson1200U 
scanner working again, but am out of things to try (any suggestions would 
be MORE than welcome).

> > That's why:
> > 1. not solved USB Irq errors in APIC mode, causes:
> > 	Error -110, device does not accept ID

Exactly the same error I'm getting here.  Doesn't matter whether its the 
USB scanner or printer that I plug in to the USB ports, I always end up 
getting that error.

-- 
Graham TerMarsch
Howling Frog Internet Development, Inc.   http://www.howlingfrog.com
