Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130777AbRCMCpx>; Mon, 12 Mar 2001 21:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130793AbRCMCpo>; Mon, 12 Mar 2001 21:45:44 -0500
Received: from moore.degeorge.org ([216.254.116.78]:61447 "EHLO
	moore.degeorge.org") by vger.kernel.org with ESMTP
	id <S130775AbRCMCp2>; Mon, 12 Mar 2001 21:45:28 -0500
Message-Id: <200103130245.f2D2j2J01057@janus.local.degeorge.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: APIC  usb MPS 1.4 and the 2.4.2 kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Mar 2001 21:45:02 -0500
From: David DeGeorge <dld@degeorge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.4.2 as obtained from redhat, but I have experienced the same 
problems with a kernel compiled from the 2.4.2 sources at kernel.org.
I am experiencing troubles with enabling MPS 1.4 and USB. I have an ABIT VP6 
motherboard with two stock 733MHz PIIIs.
If I set MPS1.1 in the bios then my IOmega Photoshow usb zip drive works, the 
usb interrupt appears on irq 9 and after a day or two I experience  a hard 
(sysreq doesn't work) lock. It seems usb related since doing usb things i.e. 
mounting the drive sometimes cause the lock.
If I set MPS1.4 in the bios  then the usb interrupt appears on irq 19, whose 
count is alway zero, and the zip drive doesn't get registered. If give the 
noapic command line then things appear to work, irq=9,don't know about the 
hard locks, but booting seems much slower. Of course I can provide much more 
information but I wonder is this a common problem and what are the 
consequences of the noapic command?
David


