Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRCMMBC>; Tue, 13 Mar 2001 07:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRCMMAw>; Tue, 13 Mar 2001 07:00:52 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:26628 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129126AbRCMMAf>; Tue, 13 Mar 2001 07:00:35 -0500
Message-ID: <3AAE0BBE.179294FA@idb.hist.no>
Date: Tue, 13 Mar 2001 12:59:58 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Pete Toscano <pete.lkml@toscano.org>, linux-kernel@vger.kernel.org
Subject: Re: APIC  usb MPS 1.4 and the 2.4.2 kernel
In-Reply-To: <200103130245.f2D2j2J01057@janus.local.degeorge.org> <20010313002513.A1664@bubba.toscano.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Toscano wrote:
> 
> Well, I can't speak for the consequences of noapic (I've wondered as
> much myself), but I know that there's been a problem with SMP 2.4
> kernels (even the 2.4 test kernels) and USB running on VIA chipsets for
> a while now.  I'm told by the linux-usb maintainers that it's a problem
> with the PCI IRQ routing for the VIA chipsets, but I've been unable to
> get anyone who knows about this to do anything (and I've been asking for
> a while).  Alas, since this stuff is beyond me, I just accept the fact
> that it'll probably always be broke.

There seems to be something wrong with 2.4.2 smp even without usb.
My abit bp6 freeze after a day or so.  I have gone back to
2.4.2pre3 and this seems better.  I have to run a few more days
to be sure though.

I don't use USB and no devices malfunction - the machine just freeze
in the middle of the night and don't respond to sysrq 
or pings.  Resetting shows
nothing in the logs.

Helge Hafting
