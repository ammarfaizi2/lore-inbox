Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBXQws>; Sat, 24 Feb 2001 11:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129122AbRBXQwj>; Sat, 24 Feb 2001 11:52:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42514 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129104AbRBXQw0>; Sat, 24 Feb 2001 11:52:26 -0500
Subject: Re: ide / usb problem
To: jdinardo@ix.netcom.com (jerry)
Date: Sat, 24 Feb 2001 16:55:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010224073003.A285@ix.netcom.com> from "jerry" at Feb 24, 2001 07:30:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Whyu-000096-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get the following message when copying a 300MB directory under 2.4.2.
> 
> uhci:host system error, PCI problems?
> uhci:host controller halted, very bad

The USB code should recover from that , if it doesnt report it to the USB
folks.

> I was not sure if the VIA82CXXX option should be set with the via kt133
> chipset , but setting it results in hundreds of
>     hda: dma_intr:status=0x51 { DriveReady SeekComplete Error }
>     hda: dma_intr:error=0x84 { DriveStatusError BadCRC }
> mesages along with the uhci: errors mentioned above.
> Again , the directory was copied correctly.

That indicates cable problems. The CRC will avoid bad transfers as it will
do retries

Alan

