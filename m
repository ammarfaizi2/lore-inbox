Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129816AbRBZTS4>; Mon, 26 Feb 2001 14:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRBZTSg>; Mon, 26 Feb 2001 14:18:36 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:28935 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129780AbRBZTSe>;
	Mon, 26 Feb 2001 14:18:34 -0500
Date: Mon, 26 Feb 2001 20:18:00 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: ide / usb problem
To: linux-kernel@vger.kernel.org, jdinardo@ix.netcom.com
Message-id: <3A9AABE8.3549CF95@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerry (jdinardo@ix.netcom.com)>    I also am using the cable supplied with the mobo (Abit kt7) so I
do not
> think it is ASUS specific. More likey it is releated to the
> VIA chipset and/or driver.
> 
> If I compile kernel with "Generic PCI bus-master DMA support"
> and run "hdparm -d1 /dev/hda" I get 700% performance increase  
> on hdparm -t benchmark and I do not get any dma BadCRC errors.
>            
> It is only when I also compile in the VIA82CXXX option that I get the
>     "hda: dma_intr:status=0x51 { DriveReady SeekComplete Error }"
>     "hda: dma_intr:error=0x84 { DriveStatusError BadCRC }"
> mesages (1000's of them).
> 
> Whether I get the messages or not, if I have dma enabled with 2.4.2
> my usb mouse stops working .

If you use the VIA IDE driver, then you _must_ turn on
the "Automatically enable DMA for PCI-IDE" kernel configuration
option. It is said in the help text for the VIA-IDE option.


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
