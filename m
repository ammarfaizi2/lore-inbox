Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130902AbRCWOX7>; Fri, 23 Mar 2001 09:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130831AbRCWOXt>; Fri, 23 Mar 2001 09:23:49 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:48908 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S130902AbRCWOXn>;
	Fri, 23 Mar 2001 09:23:43 -0500
Date: Fri, 23 Mar 2001 15:22:53 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: VIA vt82c686b  and UDMA(100)
To: dushaw@munk.apl.washington.edu, linux-kernel@vger.kernel.org
Message-id: <3ABB5C3D.2C29962A@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Dushaw (dushaw@munk.apl.washington.edu) wrote :

> Dear Linux Kernel Wisemen, 
>    I have been following the discussion of the VIA vt82c686b chipset 
> and the troubles people have had in getting UDMA(100) to work. This 
> is to report that I have now tried the 2.4.2-ac20 kernel and the 
> 2.2.18 kernel with Andre's patch (dated March 20) and neither of 
> them get the disk speed up to where it ought to be. hdparm -t reports 
> back 11 MB/s or so for either kernel. 
>    VIA82CXXX enabled, and I also tried the ide0=ata66 flag, in desparation. 
>    At boot up both kernels report the disk as UDMA(100) - everything 
> seems to be peachy keen, but for the sluggish disk performance. 
> 
> Merely a report from the front lines, 
> 
> B.D. 

Do you also have IDE_AUTO_WHATEVER option enabled , 
as suggested ( no, commanded ) in the VIA_IDE_OPTION help text ?
( press '?' when selecting the VIA IDE driver option )

cat /proc/ide/via ?

What do you think is the "correct" transfer rate of the disk ?

For the record , I have a MSI K7T Pro2A board ( VIA KT133 with a
vt82c686b south bridge ) and a IBM DTLA 307045 hard drive on a 80
wire IDE cable ( set to CABLE-SELECT , connected to the end connector;
you must always first use both connectors on the end of the cable !
never left one end unused )

Without doing any settings with hdparm, I get the full transfer rate
of the disk, measured with hdparm : ~35MB/s


kernel is 2.4.recent or redhat recent 2.4.x versions.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
