Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbRG1QVo>; Sat, 28 Jul 2001 12:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266914AbRG1QVd>; Sat, 28 Jul 2001 12:21:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26131 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266906AbRG1QVT>; Sat, 28 Jul 2001 12:21:19 -0400
Subject: Re: Problems with 2.4.7 and VIA IDE
To: yoda@isr.ist.utl.pt (Rodrigo Ventura)
Date: Sat, 28 Jul 2001 17:22:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <lxn15pdr5p.fsf@pixie.isr.ist.utl.pt> from "Rodrigo Ventura" at Jul 28, 2001 04:12:02 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QWqv-0007qf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>         This is sort of a continuation of my last msg. I tried a rpm
> -Va on one xterm and a tar cf /dev/null / on another, and I got
> another dma error:
> 
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

BadCRC is normally a cable error, but I'm suspicious that its also one of
the things caused by PCI bus problems on the VIA stuff
