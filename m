Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284393AbRLFPqQ>; Thu, 6 Dec 2001 10:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284124AbRLFPqF>; Thu, 6 Dec 2001 10:46:05 -0500
Received: from danielle.hinet.hr ([195.29.148.143]:7893 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S284300AbRLFPpx>; Thu, 6 Dec 2001 10:45:53 -0500
Date: Thu, 6 Dec 2001 16:45:47 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: Doug Ledford <dledford@redhat.com>
Cc: Nathan Bryant <nbryant@optonline.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch (it _works_ for me :)
Message-ID: <20011206164547.A19660@danielle.hinet.hr>
In-Reply-To: <3C0E7F1C.4060603@redhat.com> <3C0E8DBF.5010000@optonline.net> <3C0E90B2.1030601@redhat.com> <3C0EB1F2.7050007@optonline.net> <3C0EB46C.4010806@optonline.net> <3C0EBAEF.5090402@redhat.com> <3C0EC219.8010107@redhat!.com> <3C0EE865.1090607@red! <3C0EEDCE.2060404@optonline.net> <3C0EEF86.90101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0EEF86.90101@redhat.com>; from dledford@redhat.com on Wed, Dec 05, 2001 at 11:09:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> OK, I've reloaded a new 0.10 version of the driver to my web site.  At 
> this point, I'm calling this driver done until I hear otherwise.  If you 
> have problems, or suspect you might have problems with this driver, or 
> just want to make sure you *won't* have problems with this driver, test 
> and speak now or possibly end up having to hack it yourself later ;-)
> 
> http://people.redhat.com/dledford/i810_audio.c.gz

Well, 0.10 works for me ->

Dec  6 16:04:27 videotest kernel: Intel 810 + AC97 Audio, version 0.10, 16:01:33 Dec  6 2001
Dec  6 16:04:27 videotest kernel: PCI: Found IRQ 9 for device 00:1f.5
Dec  6 16:04:27 videotest kernel: PCI: Sharing IRQ 9 with 00:1f.3
Dec  6 16:04:27 videotest kernel: PCI: Setting latency timer of device 00:1f.5 to 64
Dec  6 16:04:27 videotest kernel: i810: Intel ICH2 found at IO 0xef00 and 0xe800, IRQ 9
Dec  6 16:04:27 videotest kernel: i810_audio: Audio Controller supports 6 channels.
Dec  6 16:04:27 videotest kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)
Dec  6 16:04:27 videotest kernel: i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
Dec  6 16:04:27 videotest kernel: i810_audio: setting clocking to 41319

RealProducer finally works on _all_ codecs and _all_ bitrates, no more oops,
xmms works and artsd also works.


thanks,

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
