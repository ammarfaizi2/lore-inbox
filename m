Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271005AbTGPKqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271006AbTGPKqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:46:37 -0400
Received: from [203.185.132.124] ([203.185.132.124]:46417 "EHLO mrchoke")
	by vger.kernel.org with ESMTP id S271005AbTGPKqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:46:33 -0400
Message-ID: <3F15305F.4020807@opentle.org>
Date: Wed, 16 Jul 2003 18:00:47 +0700
From: Supphachoke Suntiwichaya <mrchoke@opentle.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030709
X-Accept-Language: th,en-us, en
MIME-Version: 1.0
To: Supphachoke Suntiwichaya <mrchoke@opentle.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre6 + alsa 0.9.5 + i810 not work
References: <3F150561.5040903@opentle.org>
In-Reply-To: <3F150561.5040903@opentle.org>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=TIS-620; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear sir,

now I can use ALSA-Drvier with 2.4.22-pre6 but I downgrade to ALSA-0.9.4 !!
I think something worng with ALSA.

MrChoke

Supphachoke Suntiwichaya wrote:

> Dear sir,
>
>        Today I upgrade my kernel from 2.4.21-ac1 to 2.4.22-pre6 and 
> alsa-drivers from  0.9.4 to 0.9.5.
> Every thing work well but I can't play musics.
>
> :: dmesg ::
>
> Intel 810 + AC97 Audio, version 0.24, 11:19:13 Jul 16 2003
> i810_rng: RNG not detected
>
> :: /var/log/message ::
>
> Jul 16 13:59:36 MrChoke kernel: Intel 810 + AC97 Audio, version 0.24, 
> 11:19:13 Jul 16 2003
> Jul 16 13:59:36 MrChoke pci.agent: ... can't load module i810_audio
> Jul 16 13:59:36 MrChoke pci.agent: missing kernel or user mode driver 
> i810_audio
> Jul 16 13:59:36 MrChoke pci.agent: ... can't load module i810_rng
> Jul 16 13:59:36 MrChoke pci.agent: missing kernel or user mode driver 
> i810_rng
>
> I trie modprobe i810_rng but not success.
>
> /lib/modules/2.4.22-pre6/kernel/drivers/char/i810_rng.o: init_module: 
> No such device
> Hint: insmod errors can be caused by incorrect module parameters, 
> including invalid IO or IRQ parameters.
>      You may find more information in syslog or the output from dmesg
>
> With last kernel I never do above.
> I use oldconfig from 2.4.21-ac1.
>
> :: My labtop ::
> Toshiba 2410
> Gentoo linux
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 
> Audio Controller (rev 02)
>
> :: lsmod ::
> Module                  Size  Used by    Tainted: P
> snd-mixer-oss          13752   1  (autoclean)
> hid                    22020   0  (unused)
> uhci                   26800   0  (unused)
> ohci1394               31240   0  (unused)
> ieee1394               48420   0  [ohci1394]
> snd-intel8x0           18756   1
> snd-mpu401-uart         3472   0  [snd-intel8x0]
> snd-rawmidi            13920   0  [snd-mpu401-uart]
> snd-seq-device          4336   0  [snd-rawmidi]
> snd-ac97-codec         41256   0  [snd-intel8x0]
> snd-pcm                62944   0  [snd-intel8x0]
> snd-timer              14852   0  [snd-pcm]
> snd                    30948   0  [snd-mixer-oss snd-intel8x0 
> snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec snd-pcm 
> snd-timer]
> snd-page-alloc          6548   0  [snd-intel8x0 snd-pcm]
> nvidia               1541984  10
> usbmouse                2264   0  (unused)
> mousedev                4404   1
> ide-scsi               10480   0
>
>
> Thank
>
> MrChoke
> =====



