Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVI1UZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVI1UZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVI1UZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:25:13 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:43790 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750774AbVI1UZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:25:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BtNEZx9d3fQGDNxyyd9sQmhIaXaeIzpLih+ip6aun8GtONMwwNufdOlguhQKcOQtqEJGpb1PXNBUjGJn2QUppgDhlQHInkMAdsJs6q4pYEVOX1z0N/uwvUFRxBlqHiMqiAG1ZfuTIuzHxLjczNj4ZucPrzQ3kgtte4OnGvbGWok=
Date: Thu, 29 Sep 2005 00:36:11 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Grzegorz Piotr Jaskiewicz <gj@kdemail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops on firewire pcmcia card removal
Message-ID: <20050928203611.GB27645@mipter.zuzino.mipt.ru>
References: <200509282202.09341@gj-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509282202.09341@gj-laptop>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 10:02:05PM +0200, Grzegorz Piotr Jaskiewicz wrote:
> sometimes it's enough to just unplug the cable first, than eject pcmcia card. 

> Sep 28 19:56:10 thinkpaddie kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000000

> Sep 28 19:56:10 thinkpaddie kernel: Modules linked in: dv1394 raw1394 eth1394 
> ohci1394 binfmt_misc rfcomm l2cap bluetooth ipv6 deflate zlib_deflate twofish 
> serpent aes_i586 blowfish des sha256 crypto_null af_key joydev ide_cd cdrom 
> 8250_pnp snd_intel8x0m 8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec 
> tpm_nsc tpm_atmel tpm uhci_hcd usbcore isofs zlib_inflate tun irtty_sir 
> sir_dev irda radeon drm intel_agp evdev vmmon vmnet nvram snd_pcm_oss snd_pcm 
> snd_timer snd_page_alloc snd_mixer_oss agpgart ieee1394 pcmcia firmware_class 
> yenta_socket rsrc_nonstatic pcmcia_core rtc 3c59x mii nfs lockd nfs_acl 
> sunrpc af_packet

> Tainted: P      VLI

Can you reproduce it without proprietary modules loaded?

