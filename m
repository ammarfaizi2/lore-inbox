Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283586AbRLRCJE>; Mon, 17 Dec 2001 21:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283680AbRLRCIy>; Mon, 17 Dec 2001 21:08:54 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:17159 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S283586AbRLRCIo>; Mon, 17 Dec 2001 21:08:44 -0500
Subject: Re: Poor performance during disk writes
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: jlm <jsado@mediaone.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1008639370.226.2.camel@PC2>
In-Reply-To: <1008636811.226.0.camel@PC2> 
	<1008637755.2501.9.camel@localhost.localdomain> 
	<1008639370.226.2.camel@PC2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Dec 2001 20:01:24 -0600
Message-Id: <1008640896.2615.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-17 at 19:36, jlm wrote:
> On Mon, 2001-12-17 at 20:09, Reid Hekman wrote:
> 
> > Specific kernel version, df, & hdparm output would all be helpful. 
> /usr 24> uname -a
> Linux PC2 2.4.16 #1 Sun Dec 2 15:26:09 EST 2001 i586 unknown

Is PCI IDE support for your chipset compiled in? PCI DMA by default?

> non-removable ATA device, with non-removable media
>         Model Number:           ST320413A                               
>         Serial Number:          6ED2305M            
>         Firmware Revision:      3.39    
[...]
> Capabilities:
>         LBA, IORDY(can be disabled)
>         Buffer size: 512.0kB    Queue depth: 1
>         Standby timer values: spec'd by standard
>         r/w multiple sector transfer: Max = 16  Current = 16
>         DMA: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5 
>              Cycle time: min=120ns recommended=120ns

Can you set udma on the drive instead?

> - Dave Olson

Regards,
Reid

