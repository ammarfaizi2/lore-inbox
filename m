Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbSKPANF>; Fri, 15 Nov 2002 19:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbSKPANE>; Fri, 15 Nov 2002 19:13:04 -0500
Received: from ch-12-44-142-33.lcisp.com ([12.44.142.33]:532 "EHLO
	dual.lcisp.com") by vger.kernel.org with ESMTP id <S267003AbSKPAMs>;
	Fri, 15 Nov 2002 19:12:48 -0500
From: "Kevin Krieser" <kkrieser@lcisp.com>
To: "Ian Chilton" <ian@ichilton.co.uk>, "Leopold Gouverneur" <lgouv@pi.be>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Anyone use HPT366 + UDMA in Linux?
Date: Fri, 15 Nov 2002 18:19:39 -0600
Message-ID: <NDBBLFLJADKDMBPPNBALIEBDKMAA.kkrieser@lcisp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-reply-to: <20021115162833.GA3717@buzz.ichilton.co.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never had good luck, especially under heavy load, until I took out my IBM
drives.  I haven't had any problems with Redhat kernels (and before that
stock 2.4.17) with my Western Digital.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ian Chilton
Sent: Friday, November 15, 2002 10:29 AM
To: Leopold Gouverneur
Cc: linux-kernel@vger.kernel.org
Subject: Re: Anyone use HPT366 + UDMA in Linux?


Hello,

> I am using an IBM-DTLA-307030 with HPT366

I am also using an IBM disk (can't rember the model number of hand but
it's a 45GB) with an Abit BP6.


> transfer rate to udma3 (44MB/s) in the HPT bios. You can also do it with
> hdparm if your boot disk is not on that controler. Trying udma4 resulted
> in _massive_ corruption (never tried recently).

It seemed to work for a while but then things went screwy and I kept
getting I/O errors all the time which needed a hard reset - could't even
shut down.

I also noticed things like this in the log:

Nov 14 23:26:40 buzz kernel: hda: status error:
status=0x58 { DriveReady SeekComplete DataRequest }
Nov 14 23:26:40 buzz kernel: hda: drive not ready for command
Nov 14 23:28:47 buzz kernel: hda: status error:
status=0x58 { DriveReady SeekComplete DataRequest }
Nov 14 23:28:47 buzz kernel: hda: drive not ready for command
Nov 14 23:29:00 buzz kernel: APIC error on CPU0: 02(02)

Is this anything like you got?

I'll try to drop it in the bios tonight (it is my boot drive). Are you
using hdparm commands at all or just setting the bios to udma3?


> HPT366 support in kernel configuration.

I am not sure I did this but I'll check. Maybe it's just working as a
normal ide interface or something?


Thanks!


Bye for Now,

Ian


                                \|||/
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton                  Web: http://www.ichilton.co.uk    |
 |  E-Mail: ian@ichilton.co.uk   Backup: ian@linuxfromscratch.org  |
 |-----------------------------------------------------------------|
 |            There are 10 types of people in the world:           |
 |        Those who understand binary, and those who don't.        |
 \-----------------------------------------------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

