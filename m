Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266925AbRGRHAi>; Wed, 18 Jul 2001 03:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbRGRHA2>; Wed, 18 Jul 2001 03:00:28 -0400
Received: from lilly.ping.de ([62.72.90.2]:57353 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S266925AbRGRHAQ>;
	Wed, 18 Jul 2001 03:00:16 -0400
Date: 18 Jul 2001 08:56:06 +0200
Message-ID: <20010718065606.1125.qmail@toyland.ping.de>
From: "Michael Stiller" <michael@toyland.ping.de>
To: "David HM Spector" <spector@zeitgeist.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: exmh version 2.0.2 2/24/98
Subject: Re: PCI hiccup installing Lucent/Orinoco carbus PCI adapter 
In-Reply-To: Your message of "Tue, 17 Jul 2001 13:06:03 EDT."
             <200107171706.f6HH63S05993@thx1138.ny.zeitgeist.com> 
X-Url: http://www.ping.de/~michael
X-Face: "wBy`XBjk-b]Wks].wV-RmZmir({Qfv85d&!VDrjx+4Ra(/ZyXjaV-x^QXX-Ab5X#3Eap^/
  W^Zo.K9=py=t6/F&p3cl/.zrgKH)0uxy{#5Y(_dD=ftF*Q}-lp\&Z-563qR3X5qv^o9~iP(pw3_1q
  !ti@9"V[C?^iW\BVArF#(YjjLJ/[R%Ri*sw
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i encountered the same problem here.

> Hi,  included is a bug-report that seems to be a PCI oops that affects the 
> intallation of a Lucent PCI CardBus adapter.
> 
> [1.] One line summary of the problem:    
> 
>      PCI Drivers fail to allocate interrrupt for Lucent Cardbus bridge
> 
> [2.] Full description of the problem/report:
> 
> The 2.4.3 kernel recognizes the card but failts to allocate an
> interrupt for it.  This is the Lucent Oinoco PCI Carbus bridge product
> which is based on the TI1410 chip.  In talking with Dave Hinds about
> the problem, he looked at the enclose outbut and suggested that it
> looks like a kernel/PCI problem.

Is the card getting an interrupt from thew bios ? Check your bios screen 
after reboot. There should be a patch regarding this included in 2.4.6, would
you try this and see if it works ?

Cheers,

-Michael


