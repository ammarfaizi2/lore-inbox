Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRDMO21>; Fri, 13 Apr 2001 10:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRDMO2I>; Fri, 13 Apr 2001 10:28:08 -0400
Received: from stanis.onastick.net ([207.96.1.49]:42770 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S129134AbRDMO14>; Fri, 13 Apr 2001 10:27:56 -0400
Date: Fri, 13 Apr 2001 10:27:55 -0400
From: Disconnect <dis@sigkill.net>
To: Moses Mcknight <moses@texoma.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with k7 optimizations in 2.4.x?
Message-ID: <20010413102755.B21462@sigkill.net>
In-Reply-To: <3AD706C4.8020705@texoma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD706C4.8020705@texoma.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several of us on the list had the same/similar problems.  AFAIK the only
fix at this point is to run w/ no more than K6 optimizations.

Check the archives for
-> Only 10 MB/sec with via 82c686b (towards the end of the thread)
-> thunderbird 1.2G + kk266 + 2.4.x oops

It seems to be something wierd with the way memory is handled on the iwill
board.

On Fri, 13 Apr 2001, Moses Mcknight did have cause to say:

> Hi,
> 
>     I don't know if this is a problem with my hardware setup or config 
> settings or what, but whenever I try to run a 2.4.x kernel on my machine 
> with k7 optimizations the computer will never fully boot and seems to 
> give random errors about being "unable to handle kernel NULL pointer 
> dereference at virtual address xxxxxxxx" and other errors.
>     This has happened with the debian 2.4.2 package and my own 
> compilings of 2.4.3, 2.4.3-ac4, and 2.4.3-ac5.  If I compile it with 586 
> optimizations it works fine.
>     My hardware is as follows: Athlon/Thunderbird 850 Mhz CPU,
> Iwill KK266 Mobo. (uses VIA kt133a chipset and 686b southbridge) with 
> the latest BIOS update from fullon3d.com which is supposed to fix the 
> data corruption problem, 256 MB SDRAM and IBM DTLA-307060 HD.
> 
> Thanks for any info/help.
> Moses
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---
   _.-=<Disconnect>=-._
|     dis@sigkill.net    | And Remember...
\  shawn@healthcite.com  / He who controls Purple controls the Universe..
 PGP Key given on Request  Or at least the Purple parts!

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
