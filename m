Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWGSAlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWGSAlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 20:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWGSAlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 20:41:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:26985 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932436AbWGSAlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 20:41:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=nkYebltF1tMGlri+JBfE4jc9QhF1xlqpmquoGliEGJcM7EOcavKyVIEGLoB1xrJKEbF1qBaadk9BOgNpp+6diRfHH953jTpqJBLVGJ8Ea8vdUxu56fwgZGfTq9c1C5iGn5YJjL/6l0PCltMNag1p2FjIVIPi661HjamA4Ra1Tbo=
Subject: Re: kernel panic related to ReiserFS (v3)
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: John Stoffel <john@stoffel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17596.57854.569394.880757@stoffel.org>
References: <1153208388.8074.18.camel@localhost>
	 <17596.57854.569394.880757@stoffel.org>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 17:41:15 -0700
Message-Id: <1153269675.9726.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 09:28 -0400, John Stoffel wrote:

> Chris> Jul 17 23:42:49 localhost kernel: Modules linked in: usb_storage vmnet
> Chris> parport_pc parport vmmon snd_pcm_oss snd_mixer_oss md5 ipv6 ipt_recent
> Chris> ipt_REJECT xt_state iptable_filter nfs lockd nfs_acl sunrpc r8169
> Chris> ohci1394 ieee1394 emu10k1_gp gameport snd_emu10k1 snd_rawmidi
> Chris> snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer
> Chris> snd_page_alloc snd_util_mem snd_hwdep snd 8250_pci 8250 serial_core
> Chris> tda9887 tuner cx8800 cx88xx video_buf ir_common tveeprom compat_ioctl32
> Chris> v4l1_compat v4l2_common btcx_risc videodev nvidia forcedeth i2c_nforce2
> Chris> pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core
> Chris> Jul 17 23:42:49 localhost kernel: Pid: 7770, comm: firefox-bin Tainted:
> Chris> P      2.6.16.16 #1
> 
> 
> You've got a binary kernel module loaded here, please try to re-create
> this crash without the nvidia module loaded.  We (hah!  Not me
> actually... :-) can't debug this with such a module.
> 
> The key is the 'Tainted' flag.  

Even though the back-trace doesn't touch the video drivers? I wish I
could reproduce this easily. I have been using this kernel and firefox
for several weeks, and this is the first time it has panic'd on me.

Thanks, I'll see what I can do.

--
Chris Largret <http://www.largret.com>

