Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSKMWKe>; Wed, 13 Nov 2002 17:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSKMWKe>; Wed, 13 Nov 2002 17:10:34 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:62890 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262884AbSKMWKe>; Wed, 13 Nov 2002 17:10:34 -0500
Subject: Re: sk98lin driver in 2.5.47
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stuart Anderson <sba@srl.caltech.edu>
In-Reply-To: <200211132231.18870.m.c.p@wolk-project.de>
References: <200211132231.18870.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 22:43:01 +0000
Message-Id: <1037227381.11979.197.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 21:31, Marc-Christian Petersen wrote:
> Hi Stuart,
> 
> > I have been unable to compile the SysKonnect sk98lin GigE driver
> > under linux-2.5.x. Is there a patch for the following linker
> > problem of built-in.o? The following is from 2.5.47-ac2.
> > drivers/built-in.o: In function `SkPnmiInit':
> > drivers/built-in.o(.text+0x3a346): undefined reference to `__udivdi3'
> > drivers/built-in.o: In function `SkPnmiEvent':
> > drivers/built-in.o(.text+0x3ae97): undefined reference to `__udivdi3'
> > drivers/built-in.o: In function `SensorStat':
> > drivers/built-in.o(.text+0x3c0fd): undefined reference to `__udivdi3'
> > drivers/built-in.o(.text+0x3c16d): undefined reference to `__udivdi3'
> > drivers/built-in.o: In function `General':
> > drivers/built-in.o(.text+0x3de99): undefined reference to `__udivdi3'
> I have the same problems with any patch|driver in any kernel (2.4 and 2.5). 
> I've talked to a technician at SysKonnect and he told me that my linker is 
> broken and he also mentioned that Debian is known to have a broken linker (I 
> cannot confirm this in any way!)

Its a bug in their driver.

