Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283761AbRLEFOt>; Wed, 5 Dec 2001 00:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283775AbRLEFOj>; Wed, 5 Dec 2001 00:14:39 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:48001 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283771AbRLEFOW>; Wed, 5 Dec 2001 00:14:22 -0500
Message-ID: <3C0DAD26.1020906@optonline.net>
Date: Wed, 05 Dec 2001 00:14:14 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> A few more tweaks to the mmap code.  This might actually work.  It 
> should apply cleanly on top of what you already have.  Let me know if 
> it enables Quake sound...

No still silence, and debug output is weirder. (still using only 
DEBUG_INTERRUPTS)

Intel 810 + AC97 Audio, version 0.07, 00:07:49 Dec  5 2001
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH 82801AA found at IO 0x2400 and 0x2000, IRQ 17
i810_audio: Audio Controller supports 2 channels.
ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not 
present), total channels = 2
i810_audio: setting clocking to 41231
NVRM: AGPGART: allocated 257 pages
NVRM: AGPGART: allocated 128 pages
CHANNEL NUM 1 PORT 10 IRQ ( ST7 DAC HWP 2048,2048,0
LVI DAC HWP 2048,2048,0
)
cdrom: open failed.
VFS: Disk change detected on device ide1(22,0)
DAC HWP 2048,2048,0
DAC HWP 2048,2048,0
DAC HWP 2048,2048,0
[a few hundred of the above line]
DAC HWP 2048,2048,0
NVRM: AGPGART: freed 128 pages
NVRM: AGPGART: freed 257 pages
DAC HWP 2048,2048,0
i810_audio: drain_dac, dma timeout?

