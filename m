Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284569AbRLMSok>; Thu, 13 Dec 2001 13:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284704AbRLMSoa>; Thu, 13 Dec 2001 13:44:30 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:63942 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S284569AbRLMSoZ>; Thu, 13 Dec 2001 13:44:25 -0500
Message-ID: <3C18F64E.2010102@antefacto.com>
Date: Thu, 13 Dec 2001 18:41:18 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: linux-kernel@vger.kernel.org, hfhsu@sis.com.tw, lcchang@sis.com.tw
Subject: Re: Disappointing SiS900 performance - driver issue?
In-Reply-To: <20011213102423.B13809@vitelus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:

> My new motherboard has an onboard SiS900 ethernet device. I was hoping
> to free up a PCI slot by switching from my Intel EEPro100 to it. With
> the Intel card I can quite easilly pull 11.5mb/s, but the SiS seems to
> max out at 3.5mb/s or so. Is this the fault of the hardware or the
> driver?
> 
> sis900.c: v1.08.01  9/25/2001
> PCI: Assigned IRQ 11 for device 00:03.0
> eth0: Realtek RTL8201 PHY transceiver found at address 1.
> eth0: Using transceiver found at address 1 as default
> eth0: SiS 900 PCI Fast Ethernet at 0xcc00, IRQ 11, 00:d0:09:ea:ea:7e.
> ...
> eth0: Media Link On 100mbps full-duplex 

Just a me too:

Though with a little better performance.
ftp with sis900 (laptop) @ 5MB/s (2.4.13)
ftp with 3c905C-TX       @ 12MB/s(2.4.2-2)

Padraig.

