Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbSKUPoI>; Thu, 21 Nov 2002 10:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266767AbSKUPoI>; Thu, 21 Nov 2002 10:44:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24838 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266760AbSKUPoG>;
	Thu, 21 Nov 2002 10:44:06 -0500
Message-ID: <3DDD00EC.1010305@pobox.com>
Date: Thu, 21 Nov 2002 10:51:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Kudryavtsev <dkudr@sao.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Sound VIA VT8233 on K7VTA3 motherboard
References: <Pine.LNX.4.44.0211211445190.1664-100000@jack.sao.ru>
In-Reply-To: <Pine.LNX.4.44.0211211445190.1664-100000@jack.sao.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Kudryavtsev wrote:

> [1.] One line summary of the problem:
> -------------------------------------
>   Problems with sound VIA VT8233A on K7VTA3 motherboard
>
>
>
> [2.] Full description of the problem/report:
> --------------------------------------------
>
>  Sound works perfectly with Windows on the same host.
>
>  dmesg:
>   PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try
>    using pci=biosirq
>   ...
>   VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
>
> sndconfig:
>  /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/
>  via82cxxx_audio.o: init_module: No such device
>  /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/
>  via82cxxx_audio.o: insmod
>  /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/
>  via82cxxx_audio.o failed
>  /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/
>  via82cxxx_audio.o: insmod sound-slot-0 failed
>
> modprobe via82cxxx_audio:
>  /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o:
>  init_module: No such device
>  Hint: insmod errors can be caused by incorrect module parameters,
>  including invalid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg
>  /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o:
>   insmod
>  /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o
>   failed
>  /lib/modules/2.4.18-18.7.xcustom/kernel/drivers/sound/via82cxxx_audio.o:
>   insmod via82cxxx_audio failed



Kernel 2.4.x does not support your audio chip.  I hope to add support soon.

ALSA 2.4.x or the in-kernel ALSA in 2.5.x does support your audio.

	Jeff



