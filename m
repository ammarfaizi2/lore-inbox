Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279805AbRKRPDE>; Sun, 18 Nov 2001 10:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbRKRPCz>; Sun, 18 Nov 2001 10:02:55 -0500
Received: from realityfailure.org ([209.150.103.212]:64138 "EHLO
	mail.realityfailure.org") by vger.kernel.org with ESMTP
	id <S279783AbRKRPCh>; Sun, 18 Nov 2001 10:02:37 -0500
Date: Sun, 18 Nov 2001 10:02:38 -0500 (EST)
From: John Jasen <jjasen@realityfailure.org>
To: <afu@fugmann.dhs.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
Message-ID: <Pine.LNX.4.33.0111180957020.10229-100000@geisha.realityfailure.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Anders Peter Fugmann wrote:

> dmesg for the "failing" 2.4.X kernel would be nice.
> (the ones on the site is from version 2.2.19)
> Also output from 'hdparm /dev/hda' is needed in order to sort out the
> problem.
  
dmesg, /proc/interrupts, /proc/pci added to
http://www.realityfailure.org/~jjasen/SiS630/2.4.12/
 
There is also a hdparm.info, from hdparm -I /dev/hda; and hdparm.stat from 
hdparm -t -T /dev/hda (3 runs).

I've also added, in http://www.realityfailure.org/~jjasen/SiS630/, 
hdparm.info and hdparm.stat from the RH 2.2.19 kernel.

What seems really interesting is that while the buffered disk reads from 
2.2.19 are 4.5x slower, 2.2.19 is able to get work done (ie compiling) 
_much_ faster. (subjectively, a 2.4.x kernel compile (make clean && make 
dep && make && make modules) might take 20 minutes or so on 2.2.19, 
whereas it takes 4-5 hours on a 2.4.x kernel.

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- If things worked according to specs, there'd be a lot less work.


