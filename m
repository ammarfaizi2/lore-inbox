Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRHRTrA>; Sat, 18 Aug 2001 15:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267140AbRHRTqv>; Sat, 18 Aug 2001 15:46:51 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:60436 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S267043AbRHRTqh>; Sat, 18 Aug 2001 15:46:37 -0400
Message-ID: <3B7EC60B.5BFFA6D8@pp.htv.fi>
Date: Sat, 18 Aug 2001 22:46:19 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Neuber <frank.neuber@gmx.de>
CC: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: BUGFIX: UDMA-SiS5513 chipset support
In-Reply-To: <Pine.LNX.3.96.1010818151105.1982A-200000@mars.private.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Neuber wrote:
> 
> recently I did an upgrade of my old computer (ASUS SP97-V) to
> the kernel-2.4.7.
> 
> Problem:
>   My system was crashing even when I load the module ide-disk.o
> Solution:
>   Because of the broken hardware (some UDMA problems with an non
>   UDMA-Cabel to the drive) the linux kernel hangs during ide_dma_check.
>   Even if UDMA is disabeld in the bios, the kernel detect this drive as
>   an udma drive. And this is wrong!!
>   My solution was simply to comment out the ide_dma_check in ide.c.
>   You can find this patch as attachment.

Same mobo here, with -ac kernel. I've never had any problems with any kernel
version (IBM/Maxtor/Seagate HDDs). So I'd suggest faulty HDD, not the
controller nor driver.


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
