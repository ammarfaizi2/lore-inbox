Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135242AbREHUP2>; Tue, 8 May 2001 16:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135256AbREHUPR>; Tue, 8 May 2001 16:15:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15489 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135242AbREHUPN>; Tue, 8 May 2001 16:15:13 -0400
Date: Tue, 8 May 2001 16:15:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jens Axboe <axboe@suse.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20010508220643.S505@suse.de>
Message-ID: <Pine.LNX.3.95.1010508161252.29954A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, Jens Axboe wrote:

> On Tue, May 08 2001, Richard B. Johnson wrote:
> > 
> > To driver wizards:
> > 
> > I have a driver which needs to wait for some hardware.
> > Basically, it needs to have some code added to the run-queue
> > so it can get some CPU time even though it's not being called.
> > 
> > It needs to get some CPU time which can be "turned on" or
> > "turned off" as a result of an interrupt or some external
> > input from  an ioctl().
> > 
> > So I thought that the "tasklet" would be ideal. However, the
> > scheduler "thinks" that a tasklet is an interrupt, so any
> > attempt to sleep in the tasklet results in a kernel panic,
> > "ieee scheduling in an interrupt..., BUG sched.c line 688".
> 
> Use a kernel thread? If you don't need to access user space, context
> switches are very cheap.
> 
> > So, what am I supposed to do to add a piece of driver code to the
> > run queue so it gets scheduled occasionally?
> 
> Several, grep for kernel_thread.
> 
> -- 
> Jens Axboe
> 

Okay. Thanks. I thought I would have to do that too. No problem.
It's a "tomorrow" thing. Ten hours it too long to stare at a
screen.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


