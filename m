Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSKMVZM>; Wed, 13 Nov 2002 16:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSKMVZM>; Wed, 13 Nov 2002 16:25:12 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:9405 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264711AbSKMVZI> convert rfc822-to-8bit; Wed, 13 Nov 2002 16:25:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: sk98lin driver in 2.5.47
Date: Wed, 13 Nov 2002 22:31:18 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Stuart Anderson <sba@srl.caltech.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211132231.18870.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stuart,

> I have been unable to compile the SysKonnect sk98lin GigE driver
> under linux-2.5.x. Is there a patch for the following linker
> problem of built-in.o? The following is from 2.5.47-ac2.
> drivers/built-in.o: In function `SkPnmiInit':
> drivers/built-in.o(.text+0x3a346): undefined reference to `__udivdi3'
> drivers/built-in.o: In function `SkPnmiEvent':
> drivers/built-in.o(.text+0x3ae97): undefined reference to `__udivdi3'
> drivers/built-in.o: In function `SensorStat':
> drivers/built-in.o(.text+0x3c0fd): undefined reference to `__udivdi3'
> drivers/built-in.o(.text+0x3c16d): undefined reference to `__udivdi3'
> drivers/built-in.o: In function `General':
> drivers/built-in.o(.text+0x3de99): undefined reference to `__udivdi3'
I have the same problems with any patch|driver in any kernel (2.4 and 2.5). 
I've talked to a technician at SysKonnect and he told me that my linker is 
broken and he also mentioned that Debian is known to have a broken linker (I 
cannot confirm this in any way!)

Sorry, I don't have more info's about that.

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
