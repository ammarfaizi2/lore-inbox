Return-Path: <linux-kernel-owner+w=401wt.eu-S932287AbXAGAfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbXAGAfY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 19:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbXAGAfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 19:35:24 -0500
Received: from smtp.ono.com ([62.42.230.12]:51802 "EHLO resmaa01.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932287AbXAGAfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 19:35:23 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 19:35:23 EST
Date: Sun, 7 Jan 2007 01:29:27 +0100
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Question on ALSA intel8x0
Message-ID: <20070107012927.1fdcf8f3@werewolf-wl>
X-Mailer: Claws Mail 2.6.1cvs112 (GTK+ 2.10.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I have a curious issue with snd_intel8x0 ALSA driver:

Jan  7 01:14:27 werewolf-wl kernel: ACPI: PCI interrupt for device 0000:00:1f.5 disabled
Jan  7 01:14:27 werewolf-wl kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 21
Jan  7 01:14:27 werewolf-wl kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Jan  7 01:14:27 werewolf-wl kernel: AC'97 0 analog subsections not ready
Jan  7 01:14:27 werewolf-wl kernel: intel8x0_measure_ac97_clock: measured 50136 usecs
Jan  7 01:14:27 werewolf-wl kernel: intel8x0: measured clock 219 rejected
Jan  7 01:14:27 werewolf-wl kernel: intel8x0: clocking to 48000

And this file is created:

/dev/.udev/failed/class@sound@controlC0

What does this 'failed' mean ? Why is my card 'not ready' ?
Sound works, anyways.

BTW, before alsa driver loads, I hear a strange whisper through the speakers,
nothing since the sound subsystem is initialized. Bad connections ?

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.1 (Cooker) for i586
Linux 2.6.19-jam03 (gcc 4.1.2 20061110 (prerelease) (4.1.2-0.20061110.1mdv2007.1)) #0 SMP PREEMPT
