Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbTLFMwh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 07:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbTLFMwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 07:52:34 -0500
Received: from karmafish.net ([217.160.141.155]:33934 "EHLO karmafish.net")
	by vger.kernel.org with ESMTP id S265141AbTLFMwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 07:52:33 -0500
Message-ID: <3FD1D11C.309@gmx.net>
Date: Sat, 06 Dec 2003 13:52:44 +0100
From: Paulus Esterhazy <pesterhazy@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug report: sound playback slow-down/speed-up
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after switching to 2.6.0-test10 using acpi, I'm experiencing strange 
sound artefacts when
playing music on my Sony-notebook using the alsa intel8x0-driver. Whereas it
all works ok and I don't get any error messages, sound playback seems to
slow down or speed up occasionally, i.e. an mp3 file plays normally, then it
sounds as if the frequency goes up resulting in a higher-pitched voice 
etc., then
I get strange noises, then it works again as expected. This is not 
dependant to the
used output (alsa/OSSemu). I also disabled the cpufreq option, which didn't
change much. The problem didn't exist in 2.4.x where the alsa driver 
worked flawlessly;
I didn't update to -test11 as I didn't see any related changes.

I include some system info:

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio 
Controller (rev 02)
   Subsystem: Sony Corporation: Unknown device 80fa
   Flags: bus master, medium devsel, latency 0, IRQ 9
   I/O ports at 1c00 [size=256]
   I/O ports at 18c0 [size=64]

The only relevant kernel messages (as far as I get tell):
kernel: intel8x0: clocking to 48000
Modules Loaded         vfat fat ppp_deflate zlib_deflate zlib_inflate 
bsd_comp ppp_async hsfmc97ali hsfmc97via hsfmc97ich hsfpcibasic2 
hsfserial serial_core hsfengine hsfosspec hsfsoar ipv6 radeon irda 
snd_seq_oss snd_seq_midi_event snd_seq nls_iso8859_1 ntfs snd_intel8x0 
snd_ac97_codec snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm_oss 
snd_pcm snd_page_alloc snd_timer snd_mixer_oss snd soundcore uhci_hcd 
pppox ppp_generic slhc sd_mod visor usbserial usb_storage scsi_mod 
thermal processor fan button battery ac e100 agpgart hid usbkbd usbcore

I can supply further information if needed.
Please CC me for replies as I am not subscribed to the kernel mailing list.

Regards,
Paulus Esterhazy

