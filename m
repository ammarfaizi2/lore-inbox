Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131413AbRCUNlB>; Wed, 21 Mar 2001 08:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131426AbRCUNkl>; Wed, 21 Mar 2001 08:40:41 -0500
Received: from ns.suse.de ([213.95.15.193]:19983 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131413AbRCUNkc>;
	Wed, 21 Mar 2001 08:40:32 -0500
Date: Wed, 21 Mar 2001 14:48:35 +0100 (CET)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: Only 10 MB/sec with via 82c686b chipset?
To: soda@xirr.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103210348.VAA24013@xirr.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010321143956.917977A94@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Mar, SodaPop wrote:

> I have an IWill KK-266R motherboard with an athlon-c 1200
> processor in it, and for the life of me I can't get more than
> 10 MB/sec through the on-board ide controller.  Yes, all the
> appropriate support is turned on in the kernel to enable dma
> and specific chipset support, and yes, I think I have all
> relevant patches and a reasonable kernel.

 Yes, actually I'm seeing the same on a KT133 board from Elitegroup.
 Although here I get a bit more: 15 MB/s

> I noted a number of other interesting things;  one, that -X33,
> -X34, and -X64 through -X69 all have the same 10 MB/sec transfer
> rate, and two, that the 10 MB/sec transfer rate can be linearly
> increased to 12 MB/sec by raising the system bus from 100 mhz to
> 120 mhz (all components are safely rated at 133, no overclocking
> involved.)

 Duh, before making such a claim you should consider the fact that
 this is overclocking your PCI/AGP bus and I have yet to see any
 graphic cards/IDE controllers/other devices which are rated for
 37MHz PCI bus speed.

-- 

Servus,
       Daniel

