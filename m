Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbRAMUWx>; Sat, 13 Jan 2001 15:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132061AbRAMUWn>; Sat, 13 Jan 2001 15:22:43 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:38923
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129716AbRAMUWi>; Sat, 13 Jan 2001 15:22:38 -0500
Date: Sat, 13 Jan 2001 12:22:14 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Werner <werner.lx@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: HP Pavilion 8290 HANGS on boot 2.4/2.4-test9
In-Reply-To: <Pine.LNX.4.21.0101131444030.1779-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10101131219340.3339-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001, Werner wrote:

> The first and last message I get is: 
> "Uncompressing Linux... OK, booting the kernel"

> # lspci
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge(rev 02)
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge(rev 02)
> 00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> 00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)

It is to early to be caught by a DMA engine fault, but you have one of the
award winning systems that designed flaw in the hardware.  Only if the
BIOS with INT13 calls are performing DMA stuff until the OS takes over
could this be a player.

If you disable DMA in the BIOS does that help?

Regards,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
