Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131456AbRA0POj>; Sat, 27 Jan 2001 10:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131823AbRA0PO3>; Sat, 27 Jan 2001 10:14:29 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:57287 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131456AbRA0PON>; Sat, 27 Jan 2001 10:14:13 -0500
Message-ID: <3A72E5A7.92525EF6@home.com>
Date: Sat, 27 Jan 2001 10:13:43 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: spurious IRQ complaints
In-Reply-To: <3A728911.E4A02068@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> PCI: No IRQ known for interrupt pin A of device 01:00.0. Please try
> using pci=biosirq.
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF
> (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc: Unknown device 0008
>         Flags: bus master, stepping, 66Mhz, medium devsel, latency 64
>         Memory at e4000000 (32-bit, prefetchable) [size=64M]
>         I/O ports at d000 [size=256]
>         Memory at e9000000 (32-bit, non-prefetchable) [size=16K]
>         Expansion ROM at e8000000 [disabled] [size=128K]
>         Capabilities: [50] AGP version 2.0
>         Capabilities: [5c] Power Management version 1
> 
> Does it really need one?

DRI versions of X seem to behave better if an IRQ is assigned to the VGA
device via the BIOS. Didn't seem like a problem to let it have one, so I
did. :o)

John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
