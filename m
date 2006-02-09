Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWBIJfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWBIJfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWBIJfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:35:46 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:42186 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1030400AbWBIJfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:35:45 -0500
Date: Thu, 9 Feb 2006 10:35:49 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Anthony Tippett <atippett@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/swap.c:49
Message-ID: <20060209093548.GA5710@stiffy.osknowledge.org>
References: <43EAB5FF.9030305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EAB5FF.9030305@gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g0bdd340c-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Anthony Tippett <atippett@gmail.com> [2006-02-08 19:24:47 -0800]:

> Can someone direct to whom I should send this kernel BUG or what else I 
> should send as debugging information.
> 
> It looks like it might be an issue with Xorg and fglrx (ati drivers)
> 
> Feb  8 16:50:42 act kernel: kernel BUG at mm/swap.c:49!
> Feb  8 16:50:42 act kernel: invalid operand: 0000 [#1]
> Feb  8 16:50:42 act kernel: Modules linked in: fglrx binfmt_misc nfsd 
> exportfs lockd nfs_acl sunrpc parport_pc lp parport autofs4 ipv6 deflate 
> zlib_deflate twofish serpent aes blowfish des sha256 sha1 crypto_null 
> af_key snd_bt87x emu10k1_gp gameport snd_emu10k1_synth snd_emux_synth 
> snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi 
> snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_seq_device 
> snd_util_mem snd_hwdep ohci1394 ieee1394 snd_intel8x0
> snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer 
> snd soundcore snd_page_alloc forcedeth ehci_hcd ohci_hcd ide_cd cdrom 
> ide_disk ide_generic usb_storage nvidia_agp agpgart usbhid usbcore 
> tvaudio tuner msp3400 bttv video_buf firmware_class v4l2_common 
> btcx_risc tveeprom videodev i2c_algo_bit i2c_core amd74xx ide_core 
> joydev ext3 jbd mbcache sd_mod sata_sil libata scsi_mod shpchp 
> pci_hotplug evdev mousedev

Uhm ... for what reason do you use fglrx and nvidia_agp at the same time?

I guess - as usual - you have to get on to your hardware vendor when using
closed source drivers.

Marc
