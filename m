Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWBIUom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWBIUom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWBIUom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:44:42 -0500
Received: from atpro.com ([12.161.0.3]:18955 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1750773AbWBIUol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:44:41 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 9 Feb 2006 15:43:18 -0500
To: Marc Koschewski <marc@osknowledge.org>
Cc: Anthony Tippett <atippett@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/swap.c:49
Message-ID: <20060209204318.GL18918@voodoo>
Mail-Followup-To: Marc Koschewski <marc@osknowledge.org>,
	Anthony Tippett <atippett@gmail.com>, linux-kernel@vger.kernel.org
References: <43EAB5FF.9030305@gmail.com> <20060209093548.GA5710@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209093548.GA5710@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/06 10:35:49AM +0100, Marc Koschewski wrote:
> * Anthony Tippett <atippett@gmail.com> [2006-02-08 19:24:47 -0800]:
> 
> > Can someone direct to whom I should send this kernel BUG or what else I 
> > should send as debugging information.
> > 
> > It looks like it might be an issue with Xorg and fglrx (ati drivers)
> > 
> > Feb  8 16:50:42 act kernel: kernel BUG at mm/swap.c:49!
> > Feb  8 16:50:42 act kernel: invalid operand: 0000 [#1]
> > Feb  8 16:50:42 act kernel: Modules linked in: fglrx binfmt_misc nfsd 
> > exportfs lockd nfs_acl sunrpc parport_pc lp parport autofs4 ipv6 deflate 
> > zlib_deflate twofish serpent aes blowfish des sha256 sha1 crypto_null 
> > af_key snd_bt87x emu10k1_gp gameport snd_emu10k1_synth snd_emux_synth 
> > snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi 
> > snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_seq_device 
> > snd_util_mem snd_hwdep ohci1394 ieee1394 snd_intel8x0
> > snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer 
> > snd soundcore snd_page_alloc forcedeth ehci_hcd ohci_hcd ide_cd cdrom 
> > ide_disk ide_generic usb_storage nvidia_agp agpgart usbhid usbcore 
> > tvaudio tuner msp3400 bttv video_buf firmware_class v4l2_common 
> > btcx_risc tveeprom videodev i2c_algo_bit i2c_core amd74xx ide_core 
> > joydev ext3 jbd mbcache sd_mod sata_sil libata scsi_mod shpchp 
> > pci_hotplug evdev mousedev
> 
> Uhm ... for what reason do you use fglrx and nvidia_agp at the same time?
> 
> I guess - as usual - you have to get on to your hardware vendor when using
> closed source drivers.
> 
> Marc

I could be wrong, but I'm pretty sure nvidia_agp is the OSS nVidia AGPGART
driver, so I assume he has an nVidia-based motherboard and an ATI video
card.

Jim.
