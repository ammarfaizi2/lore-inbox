Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSLHKST>; Sun, 8 Dec 2002 05:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSLHKST>; Sun, 8 Dec 2002 05:18:19 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:25480
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265276AbSLHKSS>; Sun, 8 Dec 2002 05:18:18 -0500
Date: Sun, 8 Dec 2002 05:21:17 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Shawn Starr <spstarr@sh0n.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH][2.5][RFT] ide-pnp.c conversion to new PnP layer
In-Reply-To: <200212072250.49687.spstarr@sh0n.net>
Message-ID: <Pine.LNX.4.50.0212080518480.2139-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0212071511550.3130-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0212071936320.2139-100000@montezuma.mastecende.com>
 <200212072245.56906.spstarr@sh0n.net> <200212072250.49687.spstarr@sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Dec 2002, Shawn Starr wrote:

> Things have been going on the background (this issue that is). The drive is
> detected with TCQ disabled (kernel panics when enabled).

Known issue, unsupported configuration, i hit that in my test runs ;)

> pnp: the driver 'ide-pnp' has been registered
> pnp: pnp: match found with the PnP device 'er' and the driver 'ide-pnp'
> pnp: the device 'er' has been activated
> ide6: ISA Plug and Play IDE interface
> hdm: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
> hdm: WDC AC32500H, ATA DISK drive
> hdn: probing with STATUS(0x00) instead of ALTSTATUS(0xff)
> hdn: probing with STATUS(0x01) instead of ALTSTATUS(0xff)
> isa bounce pool size: 16 pages
> ide6 at 0x100-0x107,0x300 on irq 12
> hda: host protected area => 1
> hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=4866/255/63, (U)DMA
>   hda: hda1 hda2
> hdm: irq timeout: status=0x50 { DriveReady SeekComplete }

I'll check that out.

Thanks,
	Zwane
-- 
function.linuxpower.ca
