Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSJ3QwX>; Wed, 30 Oct 2002 11:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264740AbSJ3QwX>; Wed, 30 Oct 2002 11:52:23 -0500
Received: from earth.colorado-research.com ([65.171.192.8]:8715 "EHLO
	earth.colorado-research.com") by vger.kernel.org with ESMTP
	id <S264739AbSJ3QwW>; Wed, 30 Oct 2002 11:52:22 -0500
Message-Id: <200210301658.g9UGwi509311@earth.colorado-research.com>
Content-Type: text/plain; charset=US-ASCII
From: Orion Poplawski <orion@colorado-research.com>
Organization: CoRA
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Running linux-2.4.20-rc1 on Dell Dimension 4550
Date: Wed, 30 Oct 2002 09:58:44 -0700
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       req@earth.colorado-research.com
References: <200210292353.g9TNrq514597@earth.colorado-research.com> <1035991410.5140.76.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1035991410.5140.76.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 08:23 am, Alan Cox wrote:
> The -ac tree may get your sound working. Please let me know either way
> (you can just pull the i810_audio and ac97 patches from the tree). The
> onboard video probably needs the 4.2 Xservers from 8.0 and may even need
> the upcoming 4.3 XFree86 release (or try CVS XFree86 if you are bold)

I applied i810_audio patch from the patch-2.4.20-pre10-ac2 patch bundle.  
Didn't see an ac97 patch.  Modules loads okay with the following output.  
Sound appears to work fine.  I'll probably hold off on the X for a little 
while...

Thanks for the help!

Intel 810 + AC97 Audio, version 0.24, 09:29:28 Oct 30 2002
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH4 found at IO 0xcc40 and 0xc800, MEM 0xffa04400 and 
0xffa04000, IRQ 11
i810: Intel ICH4 mmio at 0xd2dc5400 and 0xd2dc7000
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ADS114(Unknown)
i810_audio: AC'97 codec 2 supports AMAP, total channels = 2
