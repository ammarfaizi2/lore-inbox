Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287705AbSAIPrg>; Wed, 9 Jan 2002 10:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287684AbSAIPrW>; Wed, 9 Jan 2002 10:47:22 -0500
Received: from danielle.hinet.hr ([195.29.148.143]:23939 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S287658AbSAIPrE>; Wed, 9 Jan 2002 10:47:04 -0500
Date: Wed, 9 Jan 2002 16:47:00 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i810_audio
Message-ID: <20020109164700.A29228@danielle.hinet.hr>
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at> <3C3A2B5D.8070707@allegientsystems.com> <3C3A301A.2050501@redhat.com> <3C3AA6F9.5090407@redhat.com> <3C3AA9AD.6070203@redhat.com> <3C3AB5AB.2080102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C3AB5AB.2080102@redhat.com>; from dledford@redhat.com on Tue, Jan 08, 2002 at 04:02:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 08, 2002 at 04:02:35AM -0500, Doug Ledford wrote:
> OK, various clean ups made, and enough of the SiS code included that I think 
> it should work, plus one change to the i810 interrupt handler that will 
> (hopefully) render the other change you made to get_dma_addr and drain_dac 
> unnecessary.  If people could please download and test the new 0.14 version 
> of the driver on my site, I would appreciate it.
> 
> http://people.redhat.com/dledford/i810_audio.c.gz

Well, ver 0.18 works fine for me _and_ for a friend of mine who _had_
problems with high network traffic while playing sound.

I haven't tried it on my webcast farm yet.


Intel 810 + AC97 Audio, version 0.18, 09:27:34 Jan  9 2002
PCI: Found IRQ 9 for device 00:1f.5
PCI: Sharing IRQ 9 with 00:1f.3
PCI: Sharing IRQ 9 with 02:09.0
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0xc400 and 0xc300, IRQ 9
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x4352:0x5934 (Cirrus Logic CS4299 rev D)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
