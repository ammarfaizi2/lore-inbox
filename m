Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313501AbSDLKKg>; Fri, 12 Apr 2002 06:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313491AbSDLKKf>; Fri, 12 Apr 2002 06:10:35 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:63698 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313501AbSDLKKa>; Fri, 12 Apr 2002 06:10:30 -0400
Message-Id: <5.1.0.14.2.20020412110908.01f703f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 12 Apr 2002 11:10:55 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: VIA and 2.5.8-pre kernels doesn't boot!
Cc: martin@dalecki.de, vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <3CB690DC.7020104@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:46 12/04/02, Martin Dalecki wrote:
>Anton Altaparmakov wrote:
>>For me 2.5.8-pre2 and -pre3 (-pre1 not tested) both fail to boot on my 
>>VIA chipset box. 2.5.7 works fine.
>>Best regards,
>>         Anton
>>2.5.8-pre3 prints on serial console and then it just dies:
>>----snip----
>>Uniform Multi-Platform E-IDE driver ver.:7.0.0
>>ide: system bus speed 33MHz
>>VIA Technologies, Inc. Bus Master IDE: IDE controller on PCI slot 00:07.1
>>VIA Technologies, Inc. Bus Master IDE: chipset revision 6
>>VIA Technologies, Inc. Bus Master IDE: not 100% native mode: will probe 
>>irqs later
>>VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
>>hda: IC35L040AVER07-0, ATA DISK drive
>>----snip----
>
>Does it crash dump thereafter? Could be that the code around
>save_match doesn't get it right.

There is no other output of any kind anywhere. I am both on serial console 
and on real console and both end with the hda line. If I can add something 
somewhere or whatever to find out where it hangs I would be happy to... 
(Remote gdb debugging is not setup yet as I have no idea how to do it...)

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

