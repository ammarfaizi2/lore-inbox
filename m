Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264006AbUKZVug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264006AbUKZVug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264001AbUKZTxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:53:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262480AbUKZTbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:23 -0500
Date: Thu, 25 Nov 2004 17:56:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 4/51: Get module list.
Message-ID: <20041125165617.GC476@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293104.5805.203.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101293104.5805.203.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This provides access to the list of loaded modules for suspend's
> debugging output. When a cycle finishes, suspend outputs something the
> following:
> 
> > Please include the following information in bug reports:
> > - SUSPEND core   : 2.1.5.7
> > - Kernel Version : 2.6.9
> > - Compiler vers. : 3.3
> > - Modules loaded : tuner bttv videodev snd_seq_oss snd_seq_midi_event
> > snd_seq snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm
> > snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device
> > snd soundcore visor usbserial usblp joydev evdev usbmouse usbhid
> > uhci_hcd usbcore ppp_deflate zlib_deflate zlib_inflate bsd_comp
> > ipt_LOG ipt_state ipt_MASQUERADE iptable_nat ip_conntrack
> > ipt_multiport ipt_REJECT iptable_filter ip_tables ppp_async
> > ppp_generic slhc crc_ccitt video_buf v4l2_common btcx_risc Win4Lin
> > mki_adapter radeon agpgart parport_pc lp parport sg ide_cd sr_mod
> > cdrom floppy af_packet e1000 loop dm_mod tsdev suspend_bootsplash
> > suspend_text suspend_swap suspend_block_io suspend_lzf suspend_core
> > - Attempt number : 9
> > - Parameters     : 0 2304 32768 1 0 4096 5
> > - Limits         : 261680 pages RAM. Initial boot: 252677.
> > - Overall expected compression percentage: 0.
> > - LZF Compressor enabled.
> >   Compressed 922112000 bytes into 437892038 (52 percent compression).
> > - Swapwriter active.
> >   Swap available for image: 294868 pages.
> > - Debugging compiled in.
> > - Preemptive kernel.
> > - SMP kernel.
> > - Highmem Support.
> > - I/O speed: Write 72 MB/s, Read 119 MB/s.
> 
> Including the modules loaded is very helpful for debugging problems.

It might be usefull as an add-on patch when people are actually debugging it,
but I do not think it is needed for mainline. You can just do lsmod before suspend...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

