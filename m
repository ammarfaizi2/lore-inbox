Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293085AbSBWEJm>; Fri, 22 Feb 2002 23:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293087AbSBWEJd>; Fri, 22 Feb 2002 23:09:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32516
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293085AbSBWEJT>; Fri, 22 Feb 2002 23:09:19 -0500
Date: Fri, 22 Feb 2002 19:56:54 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Adam Huffman <bloch@verdurin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Boot problem with PDC20269
In-Reply-To: <20020223015348.A1148@bloch.verdurin.priv>
Message-ID: <Pine.LNX.4.10.10202221953470.3281-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Adam,

http://www.tecchannel.de/hardware/817/index.html


We do not put ATAPI devices on such HOSTS.
The driver will not work w/ ATAPI there because it uses a different DMA
engine location and is not supported in Linux.

You will find greater success in putting your ATAPI device on the native
south bridge.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development




On Sat, 23 Feb 2002, Adam Huffman wrote:

> When I try to boot a kernel with the latest IDE driver in order to
> support my Promise UltraATA133 TX2 card, the system hangs at the point
> where it should be listing the two drives attached to the card i.e. it
> shows /dev/hdc which is a DVD drive, then stops.  Sometimes I can reboot
> with Alt-SysRq, sometimes a hard reset is needed.  This happens with
> 2.4.17+ide, 2.4.18-rc1, 2.5.5-dj1.
> 
> Motherboard is MSI K7T-Turbo 2, K7 1.4, drives attached to the Promise
> card are an IBM 60GXP and a Maxtor D740X-6L.  The drives work when
> attached to the VIA interface on the m/b.

