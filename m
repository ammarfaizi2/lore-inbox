Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSFDPNY>; Tue, 4 Jun 2002 11:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSFDPNX>; Tue, 4 Jun 2002 11:13:23 -0400
Received: from vivi.uptime.at ([62.116.87.11]:23213 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S312681AbSFDPNU>;
	Tue, 4 Jun 2002 11:13:20 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Jan-Benedict Glaw'" <jbglaw@lug-owl.de>, <linux-kernel@vger.kernel.org>,
        <axp-kernel-list@redhat.com>
Cc: "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>
Subject: RE: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
Date: Tue, 4 Jun 2002 17:13:08 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <001b01c20bda$58cea930$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20020604142207.GN20788@lug-owl.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> That's a known problem. Please look for my mail with Subject 
> "[2.5.19] Oops during PCI scan on Alpha". One follow-up had a 
> working (but
> hackish) fix.
[ ... ]

OK. Next error. I give up for today. :o)
[ ... ]
Freeing unused kernel memory: 360k freed
Kernel bug at ll_rw_blk.c:1602
swapper(1): Kernel Bug 1
pc = [<fffffc000040b850>]  ra = [<fffffc000040ba44>]  ps = 0000    Not
tainted
v0 = 0000000000000000  t0 = 0000000000000060  t1 = 0000000000000001
t2 = fffffc000fd84740  t3 = 0000000000000000  t4 = 0000000000000060
t5 = 0000000000000001  t6 = fffffc000fcfabf0  t7 = fffffc00008a8000
a0 = fffffc000fee08c0  a1 = fffffc000fee08c0  a2 = fffffc00008ab4e0
a3 = fffffc00008ab4f0  a4 = fffffc00008ab554  a5 = 0000000000000001
t8 = 0000000000000000  t9 = 0000000000000001  t10= 0000000000000000
t11= 0000000000000278  pv = fffffc000040b9a0  at = fffffc00005acc90
gp = fffffc00005eece8  sp = fffffc00008ab530
Trace:fffffc000040ba44 fffffc0000382e00 fffffc00003831f4
fffffc0000383354 fffffc00003b2280 fffffc00003d630c fffffc00003464ac
fffffc00003b2280 fffffc00003b280c fffffc0000359c10 fffffc0000359e14
fffffc0000347204 fffffc0000347928 fffffc00003477d0 fffffc0000368b58
fffffc0000369a00 fffffc000031078c fffffc00003101cc fffffc0000310708
fffffc0000310bf8 fffffc000032ed58 fffffc000031008c fffffc00003100b0
fffffc00003106f0 
Code: 4821f621  48213681  48407622  404103a2  e4400005  00000081
<00000642> 0057c095 
Kernel panic: Attempted to kill init!


