Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132699AbRDQPCq>; Tue, 17 Apr 2001 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRDQPCh>; Tue, 17 Apr 2001 11:02:37 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:61638 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S132699AbRDQPCU>; Tue, 17 Apr 2001 11:02:20 -0400
Date: Tue, 17 Apr 2001 17:02:06 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417170206.C2589096@informatics.muni.cz>
In-Reply-To: <20010417151007.F916@informatics.muni.cz> <E14pWmr-0002UK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14pWmr-0002UK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 17, 2001 at 03:48:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
: > 	The long story: My server is Athlon 850 on ASUS A7V, 256M RAM.
: > Seven IDE discs, one SCSI disc. The controllers and NIC are as follows
: > (output of lspci):
: 
: See the VIA chipset report on www.theregister.co.uk about corruption problems
: with VIA chipsets. The cases seen on Linux included short and also sometimes
: stale/corrupted DMA transfers.
: 
: Nothing in your report says it is or isnt going to be a VIA chipset problem
: but once a fixed BIOS is out for your board that would be a good first step.
: If it still does it then, its worth digging for kernel naughties
: 
	I don't think I have 686b southbridge. I have 686 (without "b"):

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30
[...]

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
///... in B its 'extrn' not 'extern'.        Alan (yes I programmed in B)\\\

