Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135958AbRAJU6r>; Wed, 10 Jan 2001 15:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135944AbRAJU6h>; Wed, 10 Jan 2001 15:58:37 -0500
Received: from 216.41.5.host170 ([216.41.5.170]:62075 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S135763AbRAJU6Z>; Wed, 10 Jan 2001 15:58:25 -0500
Message-Id: <200101102058.f0AKwGr00680@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: kernel@ddx.a2000.nu, linux-kernel@vger.kernel.org
Subject: Re: unexplained high load 
In-Reply-To: Your message of "Wed, 10 Jan 2001 21:34:09 +0100."
             <Pine.LNX.4.30.0101102131520.4304-100000@ddx.a2000.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jan 2001 15:58:16 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could someone maybe explain this ?
> (top output, but same load is given with 'uptime')
> there is no cpu or disk activity
> kernel is 2.2.18pre9 on sun ultra10-300 (ultrasparc IIi)
> 
>    9:25pm  up 112 days,  1:52,  1 user,  load average: 1.24, 1.05, 1.02
>  91 processes: 90 sleeping, 1 running, 0 zombie, 0 stopped
>  CPU states:  2.5% user,  2.3% system,  0.0% nice, 95.1% idle
>  Mem:  515144K av, 506752K used,   8392K free,  73464K shrd,  58472K buff
>  Swap: 131528K av,  15968K used, 115560K free                358904K cached

You have no processes??? My gosh, that is a problem. :-)

The load average is how many processes are runnable, therefore you have 
runnable processes.

If you have Netscape or Mozilla running on your box, it may be in a 
permanently runnable state.

Another amusing possibility is that you have a hacked box, and top is 
reporting the stupid IRC bot that is running, but not showing you the actuall 
process, because it too is hacked.

Replace ps and top, and have a look. Don't believe ls, either. 

If none of these things are true, you might have another problem.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
