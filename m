Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279509AbRJ3Iu5>; Tue, 30 Oct 2001 03:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279389AbRJ3Ius>; Tue, 30 Oct 2001 03:50:48 -0500
Received: from [213.236.192.200] ([213.236.192.200]:3332 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S279509AbRJ3Iuh>; Tue, 30 Oct 2001 03:50:37 -0500
Message-ID: <008e01c16120$723d6b00$d2c0ecd5@dead2>
From: "Dead2" <dead2@circlestorm.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDE6699.86FFF44F@softers.net>
Subject: Re: Intel EEPro 100 with kernel drivers
Date: Tue, 30 Oct 2001 09:54:12 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We have almost the same problem, except it totally locks up the
>computer. Light network utilization is ok, but heavy traffic does the
>effect.
>No syslog reports, even keyboards leds won't light up (numlock, etc).
>Rebooting helps for a while. We had to install another network card for
>a workaround. I've tried kernels 2.4.10 and 2.4.12.
>
>The network card is integrated at the motherboard.
>
>dmesg:
>----
>*snip*
>-----
>*snip*
>----
>Oh, eepro100-diag reported 'Sleep mode is enabled', which could do
>something like this -> I disabled it, but no positive effect.
>
>
>Any similar problems?

Sounds like this might be the same problem that we are experiencing
here. The nic does get a high load of traffic immedeately when it has
booted up.

No messages of anything remotely wrong whatsoever, even after
setting the highest debug level in the eepro100 driver.

-=Dead2=-

*my previous message to this list about this issue*

> Tested now with another motherboard with the same results.
> MSI 6321 Pro 1.0
>
> Both these motherboards use VIA dual-cpu chipsets.
> Same results with 2.4.13-Pre6 on both motherboards.
>
> > I have an Asus CUV266-d motherboard, and want to use my Intel NIC's..
> >
> > 2.4.10 & 2.4.12 hangs while "Setting up routing"
> > No error messages appear.
> >
> > 2.4.x(4 maybe?) has both 'e100' drivers and the 'eepro100' drivers.
> > When loading the 'eepro100', it hangs just like with todays kernels.
> > When loading the 'e100', everything works just fine for a short while..
> > 20-40seconds I guess.. Then the computer hangs.
> >
> > When not loading any NIC drivers, everything works just fine.
> >
> > The NIC's i've tried are named "Intel(R) PRO/100+ Dual Port Server
> Adapter"
> > Have also tried a "Intel(R) PRO/100+ Adapter"
> >
> > Any ideas of what to test?
> > I have the latest bios and have tried just about all bios settings.
> > 'noapic' doesn't help.


