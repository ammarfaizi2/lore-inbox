Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131540AbQLMUbz>; Wed, 13 Dec 2000 15:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131541AbQLMUbp>; Wed, 13 Dec 2000 15:31:45 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:34830 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131540AbQLMUbh>; Wed, 13 Dec 2000 15:31:37 -0500
Date: Wed, 13 Dec 2000 21:01:56 +0100 (CET)
From: eduard.epi@t-online.de (Peter Bornemann)
To: linux-kernel@vger.kernel.org
Subject: parport1 gone in 2.2.18  
Message-ID: <Pine.LNX.4.21.0012132059530.1616-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
I have a second parport installed as a PCI-card. In earlier Linux-versions
this would lock the machine completely if parport & Co where compiled as
modules (2.2.16 and 2.2.17). Compiled into the kernel however, everything
worked fine. I wrote about that to LK, but no solution was found. Now in
2.2.18 it is the other way round, modules work with the proper
initialization in modules.conf, but if compiled into the kernel, the
second parport vanishes completely.
 
lspci -v gives:
 
00:0d.0 Parallel controller: Timedia Technology Co Ltd: Unknown device
7268 (rev 01) (prog-if 02 [ECP])
        Subsystem: Timedia Technology Co Ltd: Unknown device 0103
        Flags: stepping, medium devsel, IRQ 9
        I/O ports at 9000
        I/O ports at 8800
 
/proc/parport however only knows about parport0
 
As I prefer the parport being modularized, it´s no problem for me. But
IMHO the other way it should work, too.
 
Cheers
Peter B


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
