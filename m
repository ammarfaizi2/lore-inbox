Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280911AbRKOPkF>; Thu, 15 Nov 2001 10:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280915AbRKOPj4>; Thu, 15 Nov 2001 10:39:56 -0500
Received: from raven.ecs.soton.ac.uk ([152.78.70.1]:477 "EHLO
	raven.ecs.soton.ac.uk") by vger.kernel.org with ESMTP
	id <S280911AbRKOPjj>; Thu, 15 Nov 2001 10:39:39 -0500
Date: Thu, 15 Nov 2001 15:39:16 +0000 (GMT)
From: Mark Cave-Ayland <mca198@ecs.soton.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Constant oops when PnP OS set to 'Y' in BIOS
Message-ID: <Pine.LNX.4.21.0111151531590.7211-101000@ugnode3.ecs.soton.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1318590791-1351861459-1005838756=:7211"
X-ECS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1318590791-1351861459-1005838756=:7211
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi there,

We are using an old Gigabyte motherboard with latest BIOS release, K6-2
350 processor and Sis5591 chipset with onboard USB as a fileserver using
Mandrake 8.1 (Linux 2.4.8-mdk20).

The problem I have is that when I set the "Plug and Play OS" option in
the BIOS to yes, the system becomes very unreliable and most times never
gets as far as allowing me to login before 'oopsing'.

Similarly, when I enable USB in the BIOS using usb-ohci and try to use our
ADSL Speedtouch modem (using Benoit's driver, not the kernel patch) the
kernel will oops again whilst trying to make a connection using PPP.

I have downloaded the latest 2.4.13 kernel and compiled the source to see
if this solves the problem, but exactly the same problem occurs under
2.4.13.

I think that there may be something wrong in the BIOS code which handles
the SiS chipset as we have tried the same setup on another Intel chipset
machine and both the PnP OS option and USB work fine.

Incidentally whilst compiling the 2.4.13 kernel to test, with PnP set to
'No', I encountered many segment faults which required me to restart gcc
- can't find a trace of one of these at the moment, but I may be able to
dig out something if someone would find them useful. So maybe this is just
a problem that is enhanced by using PnP in the BIOS?

I have included the 2.4.8 oops traces after running through ksymoops as
detailed in the Documentation folder. The first section contains the
'oops' which occurs when PnP OS is set to 'Yes' in the BIOS. The second
section contains the 'oops' which occur when I enable USB and try to
connect via PPP (I have no other USB devices to test with). I hope this is
the correct thing to do. 

If anyone can help, please email me off-list and I will try and do my
best to assist - I do not know enough about this side of things to know
what to do next.


Cheers,

Mark.


--1318590791-1351861459-1005838756=:7211
Content-Type: APPLICATION/x-gzip; name="mysymoops.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0111151539160.7211@ugnode3.ecs.soton.ac.uk>
Content-Description: ksymoops output
Content-Disposition: attachment; filename="mysymoops.gz"

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
--1318590791-1351861459-1005838756=:7211--
