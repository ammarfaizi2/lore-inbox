Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272867AbRIGVpC>; Fri, 7 Sep 2001 17:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272862AbRIGVox>; Fri, 7 Sep 2001 17:44:53 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:41485 "HELO
	pirx.hexapodia.org") by vger.kernel.org with SMTP
	id <S272857AbRIGVog>; Fri, 7 Sep 2001 17:44:36 -0400
Date: Fri, 7 Sep 2001 16:44:56 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB IRQ routing problems on Via Apollo Pro 133A
Message-ID: <20010907164456.A27672@hexapodia.org>
In-Reply-To: <20010906004520.A2891@hexapodia.org> <20010906202536.A11264@middle.of.nowhere> <20010907154129.B9370@hexapodia.org> <20010907135703.D25421@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010907135703.D25421@kroah.com>; from greg@kroah.com on Fri, Sep 07, 2001 at 01:57:03PM -0700
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 01:57:03PM -0700, Greg KH wrote:
> On Fri, Sep 07, 2001 at 03:41:29PM -0500, Andy Isaacson wrote:
> > Booting a non-APIC kernel makes it work, of course.
> > 
> > The system is a Tyan Tiger 133A, Via Apollo Pro 133A chipset, SMP,
> > currently running 2.4.9.  Complete dmesg, lspci -vvvvxxxx, and
> > /proc/interrupts are at
> > http://web.hexapodia.org/~adi/straum/usb/
> 
> That's the only solution to enable the on board USB controller for this
> motherboard, sorry.  If you can't live with noapic mode, spend $20 for
> a PCI USB controller.

Are you claiming that the USB controller IRQ line isn't routed to the
APIC?  If so, I'm curious as to any evidence you can provide to that
effect.

I'd appreciate a pointer to any discussion or whatnot.  URL?  Or even a
suggestion for where to search?  I think I've looked pretty
thoroughly...

But looking at noapic mode a bit more closely, it appears likely that I
can survive with its limitations, so thanks for the tip!

-andy
