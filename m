Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSHGMTh>; Wed, 7 Aug 2002 08:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSHGMTh>; Wed, 7 Aug 2002 08:19:37 -0400
Received: from [212.18.235.100] ([212.18.235.100]:55438 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S317215AbSHGMTg>; Wed, 7 Aug 2002 08:19:36 -0400
From: kernel@street-vision.com
Message-Id: <200208071222.g77CMKh32527@tench.street-vision.com>
Subject: Re: kernel BUG at tg3.c:1557
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 7 Aug 2002 12:22:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1028726077.18478.284.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Aug 07, 2002 02:14:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, 2002-08-07 at 12:40, Roland Kuhn wrote:
> > On a dual Athlon MP with a 3ware-7850 RAID (640GB RAID-5) and 3C996B-T GE 
> > NIC I can crash the machine with the above BUG message in virtually no 
> > time simply by copying data both ways between the RAID and the NIC. The 
> > BUG message shows that this can happen any time, it doesn't matter if the 
> > interrupt is received in cpu_idle or something else. I tried noapic, but 
> > to no avail.
> > 
> > Does anybody know about this problem?
> 
> I've never been able to get a broadcom chipset ethernet card stable on a
> dual athlon with AMD 76x chipset. I have no idea what the problem is
> although it certainly appears to be PCI versus main memory ordering
> funnies.

Mine is absolutely fine, but I only have 1 CPU in the box at the moment.
3ware 7410 and 3C996B-T, Athlon MP.

Justin
