Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262188AbREQV3G>; Thu, 17 May 2001 17:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262189AbREQV24>; Thu, 17 May 2001 17:28:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47110 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262188AbREQV2u>; Thu, 17 May 2001 17:28:50 -0400
Subject: Re: VIA/PDC/Athlon
To: jlaako@pp.htv.fi (Jussi Laako)
Date: Thu, 17 May 2001 22:25:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), vojtech@suse.cz (Vojtech Pavlik),
        linux-kernel@vger.kernel.org
In-Reply-To: <3B043481.A394D98D@pp.htv.fi> from "Jussi Laako" at May 17, 2001 11:28:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150VHJ-0006Ak-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ummm... Here's stripped dmesg of both kernels... Is this compiler thingie or
> Athlon optimizations?

Neither by the look of it

> Notice also different detected PDC20265 BIOS settings! So 2.4.4-ac9 detects
> those BIOS settings correctly and 2.4.2-2 doesn't. That's probably reason
> why 2.4.2-2 works?

Could be.

> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

CRC errors are cable errors so that bit is reasonable in itself


