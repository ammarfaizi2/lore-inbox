Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135701AbRDSOui>; Thu, 19 Apr 2001 10:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135239AbRDSOu3>; Thu, 19 Apr 2001 10:50:29 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:37640 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S135699AbRDSOuK>;
	Thu, 19 Apr 2001 10:50:10 -0400
Date: Thu, 19 Apr 2001 16:50:02 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: ATA 100
To: ignaciomonge@navegalia.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3ADEFB1A.D47D63DF@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Ignacio Monge Garcia (ignaciomonge@navegalia.com) wrote :

> Hi. I have a ASUS A7V133 Motherboard with AMD ThinderBird 1 Ghz, and 
> PDC20265/VIA. I've tried all the possible combinations on "IDE, ATA and ATAPI 
> Block devices". I've read the "Unofficial Asus A7V and Linux ATA100 
> "Quasi-Mini-Howto" on http://www.geocities.com/ender7007/. But I still can't 
> use de IDE UDMA100 controler. I see some messages with this options on 
> earlier version of the ac-kernel, so I guess what I need to do the right 
> thing. My current kernel is 2.4.3-ac9. 
> Some settings: 

According to your dmesg output , hde is working in UDMA/100.
Since hde is the only device on your ATA/100 ( the PDC20265 )
controller , I don't see any problem.

Are the transfer rates not good ?
Whet is the output of hdparm -ti /dev/hde ?


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
