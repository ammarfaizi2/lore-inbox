Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280750AbRKOGPV>; Thu, 15 Nov 2001 01:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280752AbRKOGPK>; Thu, 15 Nov 2001 01:15:10 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:48388 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S280750AbRKOGOz>;
	Thu, 15 Nov 2001 01:14:55 -0500
From: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
To: matlhdam@iinet.net.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 fails to boot on a MediaGX
In-Reply-To: <01111513115600.00812@blackbox.local>
In-Reply-To: <E163y2Z-0004OH-00@the-village.bc.nu>
Message-Id: <20011115061452.8C7B236DDD@hog.ctrl-c.liu.se>
Date: Thu, 15 Nov 2001 07:14:52 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01111513115600.00812@blackbox.local> you write:
>On Wed, 14 Nov 2001 19:17, Alan Cox wrote:
>> Ok on my box it boots fine. As an experiment can you build a kerne with no
>> PCI support (Im not saying it'll be useful production wise but it will tell
>> me if its a PCI issue)
>
>And, interestingly enough, it does boot with PCI switched off.
>
>Given that it's a somewhat unusual motherboard, I'm pretty willing to just 
>put an ISA network card in there and write it off as flaky hardware, but it's 
>odd that it boots under 2.2 with PCI support on.

I have had some problem with the PCI direct probe on a MediaGX CPU, 
when the probe looked at the CX5530 companion chip the box would
reboot.  Could you try to only use the PCI BIOS method instead?

PCI support (CONFIG_PCI) [N/y/?] (NEW) y 
  PCI access mode (BIOS, Direct, Any) [Any] (NEW) BIOS
  defined CONFIG_PCI_GOBIOS

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
