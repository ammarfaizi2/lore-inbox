Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129812AbQLTQQa>; Wed, 20 Dec 2000 11:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbQLTQQU>; Wed, 20 Dec 2000 11:16:20 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:45040 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129655AbQLTQQK>; Wed, 20 Dec 2000 11:16:10 -0500
Subject: Re: Oops with 2.4.0-test13pre3 - swapoff
In-Reply-To: <3A40BF53.400EF44B@torque.net> "from Douglas Gilbert at Dec 20,
 2000 09:16:51 am"
To: Douglas Gilbert <dougg@torque.net>
Date: Wed, 20 Dec 2000 16:45:34 +0100 (CET)
CC: linux-kernel@vger.kernel.org, Zdenek Kabelac <kabi@fi.muni.cz>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E148lQt-0000UI-00@decibel.fi.muni.cz>
From: Zdenek Kabelac <kabi@informatics.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Zdenek Kabelac wrote:
> > This is oops I've got when rebooting after some heavy disk activity on
> > my SMP system:
> > 
> > Written by hand:
> > 
> > kernel BUG swap_state.c:78!
> [snip]
> 
> Same here during a halt of a RH 6.2 based K6-2 500 MHz
> UP machine running lk240t13p3. The machine had been on
> for a while and had built a kernel amongst other things.
> 

I'll just append that my machine has been up for just several
minutes (maybe 10) but has been doing heavy copying - several
600MB files between some partitions.

So maybe the problem with memory thrashing is still not fully fixed ???


-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
