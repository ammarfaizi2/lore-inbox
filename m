Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRDJRKS>; Tue, 10 Apr 2001 13:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRDJRKJ>; Tue, 10 Apr 2001 13:10:09 -0400
Received: from [63.109.146.2] ([63.109.146.2]:21753 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S129134AbRDJRKC>;
	Tue, 10 Apr 2001 13:10:02 -0400
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1B7D@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Tamas Nagy'" <nagytam@rerecognition.com>, linux-kernel@vger.kernel.org
Subject: RE: SiS 630
Date: Tue, 10 Apr 2001 10:09:45 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tamas Nagy said:

> Hello,
> 
> I'm just wondering, whether somebody use this SiS 630 chip 

[...]

I have a couple of the very small, highly-integrated ASUS CUSI-FX
motherboards
with the SiS 630 chipset. One is using a PIII-866 with 133 Mhz bus and 320MB

RAM, and the other has a Celeron 300 and 66 Mhz bus with 128 MB RAM.  

(Motherboard description: SiS-630E,  PIII/S370, SiS300AGP shared Memory 2M
to 
64M, Cmedia PCI Audio, 2P/ 1A/2D/2U, PC133/ VCM, SiS630E 10/100, w/ RJ45, 
ATA66, Flex ATX.)

With 2.4.2-ac-?? and vanilla X 4.0.2, I have the onboard sound, VGA, IDE,
and 
network working.  The onboard video uses some of the system RAM, and the 2.4

kernels appears to detect that properly.  Everything seems to work pretty
well, 
I've compiled kernels, run setiathome, and copied hundreds of megs of data 
through the network, but I can't say I've _really_ stress tested them yet.

I do have some problems with the CMedia sound: when playing MP3's, XMMS will

run for a while and then just stop.  That doesn't happen if I use an SBLive 
instead of the onboard audio.  Haven't had time to track down the bug yet.

For the onboard IDE, I'm using the generic driver, and use hdparm to turn on

DMA and 32bit.  That gives decent performance.  Also, the motherboard has
5(!) 
USB sockets, and I haven't tried those yet, but there's no reason to believe

they won't work too.

Hope that helps.

Torrey Hoffman
