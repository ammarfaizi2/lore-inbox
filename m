Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319095AbSHFO0w>; Tue, 6 Aug 2002 10:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319096AbSHFO0w>; Tue, 6 Aug 2002 10:26:52 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:48144 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S319095AbSHFO0v> convert rfc822-to-8bit; Tue, 6 Aug 2002 10:26:51 -0400
Date: Tue, 6 Aug 2002 22:29:03 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Thomas Munck Steenholdt <tmus@get2net.dk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Sv: i810 sound broken...
In-Reply-To: <200208061030.MAA20559@eday-fe3.tele2.ee>
Message-ID: <Pine.LNX.4.44.0208062226350.885-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/06/2002
 10:30:20 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/06/2002
 10:30:22 PM,
	Serialize complete at 08/06/2002 10:30:22 PM
Content-Transfer-Encoding: 8BIT
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Aug 2002, Thomas Munck Steenholdt wrote:

> I'm afraid even that didn't help much - Only now I get a different kind
> of error... Before, trying to play a sound, the operation would just
> fisish immediatelyand a few noises were heard in the speakers... Now the
> operation never finishes - still no sound... and I found these error
> messages in dmesg..

one last try ...

unload all network, scsi, modems. Bare minimum and see if the sound alone
would work. Again, use "aumix" before playing anything.

Jeff

>
> dmesg:
> --------------------------------------------------------------
> Intel 810 + AC97 Audio, version 0.21, 11:44:41 Aug  6 2002
> PCI: Setting latency timer of device 00:1f.5 to 64
> i810: Intel ICH2 found at IO 0x1880 and 0x1c00, IRQ 11
> i810_audio: Audio Controller supports 6 channels.
> ac97_codec: AC97 Audio codec, id: 0x4144:0x5362 (Unknown)
> i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
> i810_audio: drain_dac, dma timeout?
>
>
> Any more suggestions?
>
> Thomas
>
> -- Send gratis SMS og brug gratis e-mail på Everyday.com --
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

