Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263057AbTC1RDa>; Fri, 28 Mar 2003 12:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbTC1RDa>; Fri, 28 Mar 2003 12:03:30 -0500
Received: from [81.2.110.254] ([81.2.110.254]:36348 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263057AbTC1RD3>;
	Fri, 28 Mar 2003 12:03:29 -0500
Subject: Re: 64GB NUMA-Q before pgcl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andre Hedrick <andre@linux-ide.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0303280045240.2884-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.10.10303272136540.25072-100000@master.linux-ide.org>
	 <Pine.LNX.4.50.0303280045240.2884-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048871660.5055.33.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 17:14:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 05:45, Zwane Mwaikambo wrote:
> piix: 450NX errata present, disabling IDE DMA.
> piix: A BIOS update may resolve this.

Wow 100% real prehistory 8)

> PIIX4: not 100% native mode: will probe irqs later
> PCI: Setting latency timer of device 00:0e.1 to 64
>     ide0: BM-DMA at 0x00e0-0x00e7, BIOS settings: hda:pio, hdb:pio

Something weird happened here. The PCI bar is not null but appears to
pointing into complete lala land.

> PIIX4: IDE controller at PCI slot 00:10.0
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)

We looked at turning it on, but well it wasnt oging to turn on


We have to try enabling PIIX devices really because they appear on
docking stations

