Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318630AbSGZXFS>; Fri, 26 Jul 2002 19:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318631AbSGZXFS>; Fri, 26 Jul 2002 19:05:18 -0400
Received: from kuma.unm.edu ([129.24.9.36]:399 "HELO kuma.unm.edu")
	by vger.kernel.org with SMTP id <S318630AbSGZXFR>;
	Fri, 26 Jul 2002 19:05:17 -0400
To: linux-kernel@vger.kernel.org, xpert@XFree86.Org
Subject: Super Micro MB and XF86 problem
Date: Fri, 26 Jul 2002 17:08:33 -0600
From: Daniel Sheltraw <sheltraw@unm.edu>
Message-ID: <1027724913.3d41d671e812b@webmail.unm.edu>
X-Mailer: UNM WebMail Cyrusoft Silkymail v1.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: 198.252.187.112
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xpert list

I have been pulling my hair out over a problem I have been having
with a Super Micro P6SBA motherboard with a 440BX chipset. I was
wondering if anyone else is having any problems with this board
or chipset. I have sent a few emails to Super Micro but so far
they have not given me a solution to this problem.

The problem arises in the following situation although it may
arise in others. We have a custom application that uses two
video cards. The AGP (ATI Radeon 7500) card is driven by our custom
kernel module while the PCI card (ATI Xpert 98) is driven by X. 
We have three machines on which our application is running just fine.
All three motherboards are from different manufactures. On a fourth
motherboard, the Super Micro P6SBA, we are having a problem. When
we try to startx this machine gives the error \"no screens found\".
This is a common error in XFree86 but the important point is that
all of the cards are using identical XF86config-4 files except
for the option BusID which we set according to the device number
found in /proc/pci or by using lspci.

So we have identical graphics cards, identical versions of XFree86
(4.2), identical (except for BusID in device section) XF86config
files on all machines, and even identical monitors but the Super Micro
machine is not working as expected. We can find no differences in the
BIOS that we think would be causing this problem and we have 
experimented with many different settings.

The /proc/pci system does detect both graphics cards on the Super Micro
machine and if we set up the XF86 config to use just one the two
graphics cards we find that they both function. Therefore it
does not appear to be a problem with the graphics cards.

Any ideas what could be going on here?

Thanks,
Daniel Sheltraw
