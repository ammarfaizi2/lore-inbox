Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280792AbRKOJTq>; Thu, 15 Nov 2001 04:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280794AbRKOJTg>; Thu, 15 Nov 2001 04:19:36 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:40462 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S280790AbRKOJTa>; Thu, 15 Nov 2001 04:19:30 -0500
Message-ID: <3BF388B9.33CFDBDB@loewe-komp.de>
Date: Thu, 15 Nov 2001 10:19:53 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Adam Harvey <matlhdam@iinet.net.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 fails to boot on a MediaGX
In-Reply-To: <E163y2Z-0004OH-00@the-village.bc.nu> <01111513115600.00812@blackbox.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Harvey wrote:
> 
> On Wed, 14 Nov 2001 19:17, Alan Cox wrote:
> > Ok on my box it boots fine. As an experiment can you build a kerne with no
> > PCI support (Im not saying it'll be useful production wise but it will tell
> > me if its a PCI issue)
> 
> And, interestingly enough, it does boot with PCI switched off.
> 
> Given that it's a somewhat unusual motherboard, I'm pretty willing to just
> put an ISA network card in there and write it off as flaky hardware, but it's
> odd that it boots under 2.2 with PCI support on.
> 

What kind of motherboard and peripherals are you using?
AKAIK the mediagx only supports one external pci busmaster and only
on a specific "device".

We are using mediaGXm on ETX and had problems with the wiring of the
TVIA CyberPro5050 (combined video+audio controller, audio as busmaster)

Then there are also tweaks in the PCI IDE configuration for mediaGX.
Did you enable that?
