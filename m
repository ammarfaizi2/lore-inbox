Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTARP03>; Sat, 18 Jan 2003 10:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTARP03>; Sat, 18 Jan 2003 10:26:29 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:28303 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S264844AbTARP01>;
	Sat, 18 Jan 2003 10:26:27 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "Mark F." <daracerz@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 - Compaq 900z - No Go..
References: <BAY2-DAV69nJkxWwBvt0000440f@hotmail.com>
	<20030118132807.GC21489@codemonkey.org.uk>
	<87lm1iiiwm.fsf@lapper.ihatent.com>
	<20030118152140.GB25365@codemonkey.org.uk>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 Jan 2003 16:35:17 +0100
In-Reply-To: <20030118152140.GB25365@codemonkey.org.uk>
Message-ID: <87hec6ii8a.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> On Sat, Jan 18, 2003 at 04:20:41PM +0100, Alexander Hoogerhuis wrote:
> 
>  > > My Compaq Evo 1015v did the same thing. I think it was disabling the PNP
>  > > stuff that made it work for me iirc.
>  > Comapq Evo800c here, boots somewhat fine. 2.5.58 hung at
>  > "Uncompressing, booting...", 2.5.59 did almost the same, but then I
>  > noticed the disk actually doing stuff, and by waiting, up popped the
>  > "login:" promt after a while, but nothing was printed to the console
>  > during boot.
> 
> My Vaio does that, not sure whats going on there. But the Evo is dead.
> doorstop. I've left it booting whilst I took a bath, and it was still
> dead when I got out 8-)
>

Wrong kind of soap, I guess. 

Is the problem with ALSA a FAQ? This is a part of what ends up in my
logs:

Jan 18 15:39:34 lapper kernel: snd_ac97_codec: Unknown symbol snd_iprintf
Jan 18 15:39:34 lapper kernel: snd_ac97_codec: Unknown symbol snd_kcalloc
Jan 18 15:39:34 lapper kernel: snd_ac97_codec: Unknown symbol snd_device_new
Jan 18 15:39:34 lapper kernel: snd_ac97_codec: Unknown symbol snd_info_create_card_entry
Jan 18 15:39:34 lapper kernel: snd_ac97_codec: Unknown symbol snd_info_unregister
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_info_register
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_ac97_resume
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_new
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_card_register
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_card_free
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_info_free_entry
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_ac97_set_rate
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_ac97_update_bits
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_ac97_mixer
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_verbose_printk
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_free_pci_pages
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_card_new
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_iprintf
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_lib_malloc_pages
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_lib_ioctl
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_lib_free_pages
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_kcalloc
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_set_ops
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_hw_constraint_list
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_device_new
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_suspend_all
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_malloc_pci_pages
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_hw_constraint_integer
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_lib_preallocate_pci_pages_for_all
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_info_create_card_entry
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_mpu401_uart_new
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_lib_preallocate_free_for_all
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_pcm_period_elapsed
Jan 18 15:39:34 lapper kernel: snd_intel8x0: Unknown symbol snd_info_unregister
Jan 18 15:39:38 lapper kernel: soundcore: Unknown symbol errno
[repeat ad nauseum]

> 		Dave

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
