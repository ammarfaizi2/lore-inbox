Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318247AbSGQJFW>; Wed, 17 Jul 2002 05:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSGQJFV>; Wed, 17 Jul 2002 05:05:21 -0400
Received: from mail4.ucc.ie ([143.239.1.34]:1804 "EHLO mail4.ucc.ie")
	by vger.kernel.org with ESMTP id <S318247AbSGQJFU>;
	Wed, 17 Jul 2002 05:05:20 -0400
Message-ID: <9FBB394A25826C46B2C6F0EBDAD42755018E6E45@xch2.ucc.ie>
From: "O'Riordan, Kevin" <K.ORiordan@ucc.ie>
To: "'Joseph Wenninger'" <kernel@jowenn.at>, linux-kernel@vger.kernel.org
Subject: RE: Problem with Via Rhine- Kernel 2.4.18
Date: Wed, 17 Jul 2002 10:08:08 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's the exact same problem I'm having with my VT6102 chip, and apparently
people are having with the VT86C100A. Roger Luethi posted a few patches back
in May which fixed the problem and a new patch just a few days ago against
2.4.19-rc1(and against 2.4.19-rc2 as well I'd say as the via-rhine driver
hasn't changed between them). I'll forward that mail on to you.

-----Original Message-----
From: Joseph Wenninger [mailto:kernel@jowenn.at] 
Sent: 17 July 2002 09:35
To: linux-kernel@vger.kernel.org
Subject: Problem with Via Rhine- Kernel 2.4.18

Hi 
 
I'm new to the linux kernel, so please be patient. 
 
I have a P4 notebook with a via chipset and a mobile P4. In Windows XP my 
built in network device works without problems. In linux the device hangs a 
after some time of >90kB/s datatransfers. I have to completely reset my 
notebook to get it working again 
 
I'm not sure if it is a hardware or a kernel problem. How can I debug this 
to find out if it is a kernel bug and where it is ? 
 
I have to use pci=biosirq, otherwise the kernel warns me, that it can't 
change the interupts for my devcies. 
 
 
At bootup the device identifies itself as  
via-rhine.c:v1.10-LK1.1.13  Nov-17-2001  Written by Donald Becker 
  http://www.scyld.com/network/via-rhine.html 
eth0: VIA VT6102 Rhine-II at 0xd000, 00:40:45:07:ba:06, IRQ 11. 
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 0021. 
 
When it stops working I get a lot of messages like: 
kernel eth0: Transmit timed out, status 0000, PHY status 786d, resetting... 
kernel eth0: Reset did not  complete in 10ms. 
 
Another message I quite often get is: 
mtrr: no more MTRRs available 
 
 
I'm thankfull for any help 
 
Kind regards 
Joseph Wenninger 
