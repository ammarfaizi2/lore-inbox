Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271974AbRHVJcq>; Wed, 22 Aug 2001 05:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271976AbRHVJcg>; Wed, 22 Aug 2001 05:32:36 -0400
Received: from wlg21.werkleitz.de ([195.37.189.21]:24984 "EHLO
	mail-2.werkleitz.de") by vger.kernel.org with ESMTP
	id <S271974AbRHVJcX>; Wed, 22 Aug 2001 05:32:23 -0400
Date: Wed, 22 Aug 2001 02:00:29 +0200
From: Martin Mueller <mm@sig21.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 breaks apm, ymfpci, pcmcia on VAIO + patch
Message-ID: <20010822020029.A649@cicero.werkleitz.de>
In-Reply-To: <20010821160628.A2296@cicero.werkleitz.de> <E15ZCV0-0007xr-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15ZCV0-0007xr-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Organization: Unorganized Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply Alan, i just downloaded 2.4.8-ac8 and compiled
by copying .config from my 2.4.8 tree and using "make oldconfig".

On Tue, Aug 21, 2001 at 03:27:22PM +0100, Alan Cox wrote:
> 
> > Linux 2.4.8 worked _extremely_ well, all problems except the wrong
> > battery display gone. I just could suspend the running laptop while
> 
> Does 2.4.8-ac8 show the 2.4.9 problem. If so then we can try and binary
> search out where it broke

Nope, 2.4.8-ac8 works just as well as 2.4.8. I just tested it.

> > Aug 21 15:01:32 cicero kernel: PCI: Enabling device 00:09.0 (0000 -> 0003) 
> > Aug 21 15:01:32 cicero kernel: PCI: Found IRQ 9 for device 00:09.0 
> > Aug 21 15:01:32 cicero kernel: ymfpci: YMF744 at 0xfedf8000 IRQ 9 
> > Aug 21 15:01:33 cicero kernel: ymfpci_codec_ready: codec 0 is not ready [0xffff] 
> > 
> > This is with the ymfpci module shipped with the kernel tree, the
> > ALSA messages are roughly the same.
> 
> Something failed to bring back the codec ACLink.

The YMFPCI also works with 2.4.8-ac8!

bye
   MM

Martin Mueller      Phone: +49 39298 4125      e-mail:  mm@sig21.net
		    ICQ:         99023536              mm@lunetix.de
PGP/GPG mail welcome, keys as well other stuff at:  http://themm.net


