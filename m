Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSHVUS4>; Thu, 22 Aug 2002 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSHVUS4>; Thu, 22 Aug 2002 16:18:56 -0400
Received: from mail50-s.fg.online.no ([148.122.161.50]:4557 "EHLO
	mail50.fg.online.no") by vger.kernel.org with ESMTP
	id <S316682AbSHVUSz>; Thu, 22 Aug 2002 16:18:55 -0400
From: "Ulf-Andre Gramstad" <j1@gramstad.org>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: hpt374 / BUG();
Date: Thu, 22 Aug 2002 22:22:13 +0200
Message-ID: <IOELJIHGBNLBJNBMHABBOEACCDAA.j1@gramstad.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.10.10208201354260.3867-100000@master.linux-ide.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You have a system where it actually have the PLL already set and in
> 66-clock base?  You are the first person to ever hit this BUG().
> I will need to work with HighPoint to finish the timing table.
>
> If you would have several device of various max transfer rate limits you
> could attach without the driver being built it, it would give me a few
> data point to verify if the table I have started is even close.

My HPT374 controller works with the new 2.4.20-pre2-ac6 patch, running at
ATA-66.
/proc/ide/hpt366 shows only primary and secondary channel, so I guess thats
why the hard drives on channel 3 and 4 is not working?


-
UAG

