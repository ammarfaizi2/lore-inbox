Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312982AbSDTR05>; Sat, 20 Apr 2002 13:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314664AbSDTR04>; Sat, 20 Apr 2002 13:26:56 -0400
Received: from w226.z064000207.nyc-ny.dsl.cnc.net ([64.0.207.226]:47660 "EHLO
	carey-server.stronghold.to") by vger.kernel.org with ESMTP
	id <S312982AbSDTR0z>; Sat, 20 Apr 2002 13:26:55 -0400
Message-Id: <4.3.2.7.2.20020420132907.03c59cd0@mail.strongholdtech.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 20 Apr 2002 13:32:11 -0400
To: r.ems@gmx.net, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
From: "Nicolae P. Costescu" <nick@strongholdtech.com>
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
In-Reply-To: <3CC1A228.2B9C72F6@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We gave up using kt266A chipset motherboards with anything faster than ATA100.
I can reproduce disk corruption within 30 seconds on any of the KT266A 
motheroards we've tried that have a highpoint 370/372/372a either onboard 
or on the RocketRaid133 controller.
Did not get the corruption when using ATA100 or slower (e.g. promise 
fastrak 100 tx2).
Simple program that writes 1.2 gig to a file and reads them back (checking 
the value) will find corruption every time on these boards, and I tried 5 
motherboards (2 asus, 3 abit).
We switched to Intel I845 chipset and to AMD MPX chipset and haven't seen 
the problem.
I thought this problem was linked with the VIA chipset PCI latency issue as 
people were having the problem with high speed framegrabbers as well.
****************************************************
Nicolae P. Costescu, Ph.D.  / Senior Developer
Stronghold Technologies
46040 Center Oak Plaza, Suite 160 / Sterling, Va 20166
Tel: 571-434-1472 / Fax: 571-434-1478

