Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRCARer>; Thu, 1 Mar 2001 12:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRCARei>; Thu, 1 Mar 2001 12:34:38 -0500
Received: from cninexchsrv01.crane.navy.mil ([164.227.4.52]:31761 "EHLO
	cninexchsrv01.crane.navy.mil") by vger.kernel.org with ESMTP
	id <S129742AbRCARe3>; Thu, 1 Mar 2001 12:34:29 -0500
Message-ID: <AF6E1CA59D6AD1119C3A00A0C9893C9A04F570ED@cninexchsrv01.crane.navy.mil>
From: Friedrich Steven E CONT CNIN <friedrich_s@crane.navy.mil>
To: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Looking for best resource for device driver programmers
Date: Thu, 1 Mar 2001 12:34:28 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me start by apoligizing for the brevity of my post.

I appreciate the responses so far, but I left out info that may have
resulted in responses more in line with what I'm looking for.

I have studied the various docs people usually mention, but they contain
little info about 2.4 kernel.
I have "Linux Device Drivers" from O'Reilly and "Professional Linux
Programming" from Wrox.
I have questions that these tomes are not answering...

We are only interested in writing to 2.4 and beyond, and the device driver
I'm writing will not be of general interest, it's very specific to our
project.

So far, I've written a loadable kernel module and I have a skeleton driver
that uses the "newest" techniques; pci_register_driver, etc., and so far,
implements open, release, read, and write, though the read and write don't
actually go out to my hardware, they allow user programs to write data and
read it back.  

The questions I have are difficult to research because so little info exists
about 2.4 design philosophy.

My hardware is "memory-mapped" and we're not concerned about non-x86
platforms.  I need to find out how I can map my hardware to user vm space.
The pci support under linux 2.4 has found the device and mapped it in
/proc/iomem.  I used ioremap to get the virtual address.  I can access the
hardware from the driver just fine, but since this hardware is digital in
and out, I want it to be memory mapped, just like in VxWorks, etc.

So I'm hoping to find someone that I can ask fairly technical questions
about linux kernel device drivers, etc.

We are not looking for $2000 tools that will generate code for us, but I do
appreciate the suggestion.  I think most people in my shoes would be
interested in such apps.  Our group has to hand code a linux kernel device
driver (me, actually).

Is this mailing list an appropriate forum for these type questions or is
there another mailing list or web site better suited?



-----Original Message-----
From:	Friedrich Steven E CONT CNIN 
Sent:	Thursday, March 01, 2001 10:59
To:	Linux Kernel List (E-mail)
Subject:	Looking for best resource for device driver programmers

I'm a real-time developer new to the Linux platform.  I'm currently trying
to write my first linux kernel device driver.
Anyone know the best web site or mailing list to ask questions about linux
device driver and kernel issues for a programmer like me?


Steven Friedrich
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
<mailto:majordomo@vger.kernel.org> 
More majordomo info at  http://vger.kernel.org/majordomo-info.html
<http://vger.kernel.org/majordomo-info.html> 
Please read the FAQ at  http://www.tux.org/lkml/ <http://www.tux.org/lkml/> 
