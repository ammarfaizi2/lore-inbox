Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbRFGObp>; Thu, 7 Jun 2001 10:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262628AbRFGOb0>; Thu, 7 Jun 2001 10:31:26 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:30817 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262615AbRFGObO>; Thu, 7 Jun 2001 10:31:14 -0400
Message-ID: <3B1E5B55.7C17C9E9@redhat.com>
Date: Wed, 06 Jun 2001 12:33:25 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Castricum <hostmaster@cia.c64.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: I810 Sound broke between 2.4.2 and 2.4.3
In-Reply-To: <000701c0ecf9$eae40dc0$0501a8c0@castricum.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Castricum wrote:
> 
> I use amp to play my mp3s and it seem to stop functioning since 2.4.3. I
> captured the kernel messages from the module :
> 
> --- 2.4.2 ---
> Intel 810 + AC97 Audio, version 0.01, 14:04:06 Jun  4 2001
> PCI: Found IRQ 10 for device 00:1f.5
> PCI: The same IRQ used for device 00:1f.3
> PCI: The same IRQ used for device 01:09.0
> PCI: Setting latency timer of device 00:1f.5 to 64
> i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, IRQ 10
> ac97_codec: AC97 Audio codec, id: 0x4144:0x5340 (Analog Devices AD1881)
> i810_audio: Codec refused to allow VRA, using 48Khz only.
> 
> --- 2.4.3 ---
> Intel 810 + AC97 Audio, version 0.01, 14:18:58 Jun  4 2001
> PCI: Found IRQ 10 for device 00:1f.5
> PCI: The same IRQ used for device 00:1f.3
> PCI: The same IRQ used for device 01:09.0
> PCI: Setting latency timer of device 00:1f.5 to 64
> i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, IRQ 10
> ac97_codec: AC97 Audio codec, id: 0x4144:0x5340 (Analog Devices AD1881)
> i810_audio: Codec refused to allow VRA, using 48Khz only.
> i810_audio: 9576 bytes in 50 milliseconds
> 
> an strace of amp seems to halt on writing to the /dev/dsp
> 
> I have an Intel Celeron on an Asus-MEW motherboard which has this soundcard
> integrated.
> 
> Any ideas?

Can you try xmms with the oss output module and tell me if that works?

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
