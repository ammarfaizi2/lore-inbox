Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVKTOii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVKTOii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 09:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVKTOii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 09:38:38 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:34266 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751159AbVKTOii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 09:38:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=CC/Yr61eAU0kNG63vi8zsLM6H2XuYnp8Hk+9MwiSMk2baYlEdPp7ItFqTxgjOun+sOTvFbbtDjWZaQopoY1dyqXE68G8TRYZEYkWisYhH+yb4Zx5Es593JKJEgg1Ctib+6WfAkzrvY51M61Cn/jZH8kMObUDHt6O1bKq8EWQ0R4=
Date: Sun, 20 Nov 2005 17:52:41 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Geithe <warpy@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: cinergyT2 oops (was Re: Linux 2.6.15-rc2)
Message-ID: <20051120145241.GA18234@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511201420.55062.warpy@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511201420.55062.warpy@gmx.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 02:20:54PM +0100, Michael Geithe wrote:
> i get this after plugged in dvb-t/Cinergy T2 with Kernel 2.6.15-git*/rc*.

> usb 3-5.5: new high speed USB device using ehci_hcd and address 7
> DVB: registering new adapter (TerraTec/qanu USB2.0 Highspeed DVB-T Receiver).
> Unable to handle kernel paging request at virtual address 0483b400
>  printing eip:
> f9060f01
> *pde = 00000000
> Oops: 0002 [#1]
> SMP
> Modules linked in: cinergyT2 dvb_core w83627hf hwmon_vid eeprom i2c_isa
> snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi
> snd_seq_midi_emul snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event
> snd_seq usbhid usb_storage ehci_hcd ohci_hcd ohci1394 ieee1394 snd_emu10k1
> snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus
> snd_page_alloc snd_util_mem snd_hwdep snd soundcore e1000 nvidia i2c_i801
> intel_agp usbcore
> CPU:    0
> EIP:    0060:[<f9060f01>]    Tainted: P      VLI
			       ^^^^^^^^^^

Can you reproduce it with clean kernel?

