Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSHMO7K>; Tue, 13 Aug 2002 10:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSHMO7K>; Tue, 13 Aug 2002 10:59:10 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:17536 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S315454AbSHMO7J>; Tue, 13 Aug 2002 10:59:09 -0400
From: jordan.breeding@attbi.com
To: Pau Montero =?ISO-8859-1?Q?Par=E9s?= <pau@imente.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP Athlon troubles under high load 
Date: Tue, 13 Aug 2002 15:02:55 +0000
X-Mailer: AT&T Message Center Version 1 (Aug 12 2002)
Message-Id: <20020813150256.XTMS19356.rwcrmhc51.attbi.com@rwcrwbc69>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I have a dual athlon system as well which does not 
normally reboot under Linux.  FreeBSd and Windows work 
fine but a stock Linux kernel does very weird things 
when rebooting.  My board is the Tyan Thunder K7 
(S2462UNG) and I solved the problem by booting with 
reboot=warm.  Hope that helps.

Jordan Breeding
> The system hangs both 1.1 and 1.4 SMP specification and with or without 
> using MP interrupts table.
> MainBoard: Tyan 2460 with registered ECC memory.
> 
> The MB can't reboot normaly, but i think it is a BIOS issue, i should 
> update it.
> 
> Good luck!
> 
> Pau Montero Parés.
> http://pau.no-ip.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
