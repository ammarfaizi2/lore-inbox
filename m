Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSHGLvh>; Wed, 7 Aug 2002 07:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSHGLvh>; Wed, 7 Aug 2002 07:51:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39673 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317580AbSHGLvg>; Wed, 7 Aug 2002 07:51:36 -0400
Subject: Re: kernel BUG at tg3.c:1557
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208071332110.3394-100000@pc40.e18.physik.tu-muenchen.de>
References: <Pine.LNX.4.44.0208071332110.3394-100000@pc40.e18.physik.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 14:14:37 +0100
Message-Id: <1028726077.18478.284.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 12:40, Roland Kuhn wrote:
> On a dual Athlon MP with a 3ware-7850 RAID (640GB RAID-5) and 3C996B-T GE 
> NIC I can crash the machine with the above BUG message in virtually no 
> time simply by copying data both ways between the RAID and the NIC. The 
> BUG message shows that this can happen any time, it doesn't matter if the 
> interrupt is received in cpu_idle or something else. I tried noapic, but 
> to no avail.
> 
> Does anybody know about this problem?

I've never been able to get a broadcom chipset ethernet card stable on a
dual athlon with AMD 76x chipset. I have no idea what the problem is
although it certainly appears to be PCI versus main memory ordering
funnies.

