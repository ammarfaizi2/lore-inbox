Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUGYVVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUGYVVj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 17:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUGYVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 17:21:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.190]:10472 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264501AbUGYVVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 17:21:25 -0400
From: Emmeran Seehuber <rototor@rototor.de>
To: Frederik Himpe <fhimpe@pandora.be>
Subject: Re: 2.6.7-ck5: System hangs under constant load
Date: Sun, 25 Jul 2004 23:21:22 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407252227.05580.rototor@rototor.de> <pan.2004.07.25.20.57.36.483562@pandora.be>
In-Reply-To: <pan.2004.07.25.20.57.36.483562@pandora.be>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407252321.22781.rototor@rototor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d84d732d8ddd2281dac05c143a411240
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 25. Juli 2004 22:57 schrieb Frederik Himpe:
> On Sun, 25 Jul 2004 22:27:05 +0200, Emmeran Seehuber wrote:
> > Hello everybody!
> >
> > I'm using a 2.6.7 kernel with the ck5 patch (gentoo ck-sources). But the
> > problem I have may not directly be related to this kernel version,
> > because I had it a few times already with other 2.6.x kernels.
> >
> > When I put the machine under constant load (e.g. emerge of kde 3.3beta2),
> > it works for some hours without problems. But then the machine suddenly
> > hangs. "Hang" means that no keyboard or mouse input works (even SysRq
> > doesn't work), the screen freezes and the cpu seems to go into a loop.
> > The system is a laptop and I hear the fan spin loudly. And the fan
> > doesn't stop to spin nor turns down the sound, even after some hours.
> > (Well, I start the emerge and then let the computer alone for some hours,
> > in the hope that it finishes it ... when I come back, it hangs)
>
> Interesting, as I'm having also a problem with random hangs since kernel
> 2.6.6 (2.6.5 and before worked fine), also on a laptop. Which laptop do
> you have? I'm using a Compaq EVO N1020v, with this hardware:
>

I've got a Xeron laptop with this hardware:

0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host & 
Memory & AGP Controller (rev 01)
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI 
bridge (AGP)
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media 
IO] (rev 14)
0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
0000:00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire 
Controller
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
0000:00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller 
(rev a0)
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
Sound Controller (rev a0)
0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller
0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
[Radeon Mobility 9000 M9] (rev 01)

Xeron has some base laptop motherboards and cases and you can specify which 
components (CPU, RAM, Harddisk) you like to have in the laptop. They then 
build the laptop as you ordered. 

cu,
  Emmy
