Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132605AbRAGOeR>; Sun, 7 Jan 2001 09:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132976AbRAGOeD>; Sun, 7 Jan 2001 09:34:03 -0500
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:8656
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S132605AbRAGOds>; Sun, 7 Jan 2001 09:33:48 -0500
Date: Sun, 7 Jan 2001 15:33:42 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@pluto.fachschaften.tu-muenchen.de>
To: Philip Armstrong <phil@kantaka.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Related VIA PCI crazyness?
In-Reply-To: <20010107122800.A636@kantaka.co.uk>
Message-ID: <Pine.NEB.4.31.0101071449220.29839-100000@pluto.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Philip Armstrong wrote:

> In supplement to Evan Thompson's emails with the subject "Additional
> info. for PCI VIA IDE crazyness. Please read." I've noticed the
> following message with recent 2.4.0 test + release kernels:
>
> IRQ routing conflict in pirq table! Try 'pci=autoirq'
>...
> and the output of lspci is:
>
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 03)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
> 00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
> 00:08.0 SCSI storage controller: Advanced System Products, Inc ABP940-U / ABP960-U (rev 03)
> 00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
>...

I have exactly the same board and the same symptoms: I have a Realtek
Semiconductor Co., Ltd. RTL-8029(AS) (using the NE2000-PCI driver). I
always get the 'pci=autoirq' error message from the card when booting but
it took some time until I noticed it because the card works without any
problems. I get the same error message in 2.4.0-ac1 with the VIA IDE
driver upgraded to v3.6 . I don't have module support in my kernels.

> HTH someone.
>
> cheers,
>
> Phil Armstrong

cu,
Adrian

-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
