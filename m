Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280940AbRKOQra>; Thu, 15 Nov 2001 11:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280941AbRKOQrV>; Thu, 15 Nov 2001 11:47:21 -0500
Received: from symphony-03.iinet.net.au ([203.59.3.35]:16139 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S280940AbRKOQrC>;
	Thu, 15 Nov 2001 11:47:02 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Adam Harvey <matlhdam@iinet.net.au>
To: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Subject: Re: 2.4.14 fails to boot on a MediaGX
Date: Fri, 16 Nov 2001 00:47:50 +0800
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E163y2Z-0004OH-00@the-village.bc.nu> <01111513115600.00812@blackbox.local> <3BF388B9.33CFDBDB@loewe-komp.de>
In-Reply-To: <3BF388B9.33CFDBDB@loewe-komp.de>
MIME-Version: 1.0
Message-Id: <01111600475101.00812@blackbox.local>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2001 17:19, Peter Wächtler wrote:
> What kind of motherboard and peripherals are you using?
> AKAIK the mediagx only supports one external pci busmaster and only
> on a specific "device".

I don't know the make of the motherboard without actually pulling the box 
apart. The system was designed and used in hotels for Internet access in 
rooms to start with... I picked it up after they were replaced about a year 
ago.

It's unusual, because it has a PCI chipset, yet only has a couple of ISA 
slots. I've been enabling PCI mainly out of habit and in case anything on the 
motherboard was using the bus (apparently not), but I wouldn't be surprised 
if the PCI chipset is basically broken, since it wasn't really needed.

>
> We are using mediaGXm on ETX and had problems with the wiring of the
> TVIA CyberPro5050 (combined video+audio controller, audio as busmaster)

Could be applicable, given that video and audio are handled on-board. I might 
have to open her up tomorrow and have a poke around.

>
> Then there are also tweaks in the PCI IDE configuration for mediaGX.
> Did you enable that?

I've had them on and off, they don't affect the booting problem.

I'll build a kernel using the BIOS access mode (as suggested by Alan) 
tomorrow and see if that clears it up.

Adam
