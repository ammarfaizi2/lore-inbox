Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266549AbRGDV1D>; Wed, 4 Jul 2001 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266554AbRGDV0v>; Wed, 4 Jul 2001 17:26:51 -0400
Received: from u-207-21.karlsruhe.ipdial.viaginterkom.de ([62.180.21.207]:39674
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S266549AbRGDV0k>; Wed, 4 Jul 2001 17:26:40 -0400
Date: Wed, 4 Jul 2001 23:24:17 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Green <greeen@iii.org.tw>
Cc: LinuxEmbeddedMailList <linux-embedded@waste.org>,
        LinuxKernelMailList <linux-kernel@vger.kernel.org>,
        MipsMailList <linux-mips@fnet.fr>
Subject: Re: RF driver!!
Message-ID: <20010704232417.A7161@bacchus.dhis.org>
In-Reply-To: <000e01c1038d$477c8720$4c0c5c8c@trd.iii.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000e01c1038d$477c8720$4c0c5c8c@trd.iii.org.tw>; from greeen@iii.org.tw on Tue, Jul 03, 2001 at 02:56:21PM +0800
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 02:56:21PM +0800, Green wrote:

> I am porting a pcmcia rf driver (which worked on kernel 2.2.12)
> to kernel 2.4.0 on my MIPS machine.
> 
> 1. I found there are some diffenence in netdevice.h.
>     The structure device changed to net_device.
> 
> 2. And the tbusy, start, interrupt were gone with 
>     the use of the netif_start_queue, netif_stop_queue,
>     netif_wake_queue and related functions.
> 
> How do I use these functions to modify the 2.2.12 rf driver to 2.4.0 ??

Checkout the netdev archives at
http://oss.sgi.com/projects/netdev/archives/.

  Ralf
